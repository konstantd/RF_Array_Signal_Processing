%�������� �� ������� 8 ������ ������� ���� 2 ������ ������������ �������
%��� ��������� ������ ���� �� ��� ����� ���������� �� 2 ������ �������

for u1= 86:0.01:90  %�1 
     
  u2=180-u1; %�2
  
 
%������� �������
A=zeros(8,2);  
for i=1:8
    A(i,1)= exp(1i*pi* (i-1)*cosd(u1)); 
    A(i,2)= exp(1i*pi* (i-1)*cosd(u2));                
end

SNR=10;
sigma2 = 1/(10^(SNR/10));  
Rnn=sigma2*eye(8);
Rgg=eye(2);
Rxx=A*Rgg*A'+Rnn;

%Y���������� ������� ��������
Py=zeros(1,18000);
for step=1:18000
 ad=zeros(8,1);
    for in=1:8
       ad(in)=exp((in-1)*1i*pi*cosd(step*0.01));
    end   
 Py(1,step)=1/(ad'*inv(Rxx)*ad);   
end

%���������� ������� ��������
thetad=0.01:0.01:180;
Py=10*log10(abs(Py)/max(abs(Py)));
plot(thetad,Py) 
xlabel('degrees')
ylabel('Py (dB)')

%�������� ��� ���������� ������ ������� ���� ������ ���� ��� �� -1dB
[max_value, index_max] = findpeaks(Py,'MINPEAKHEIGHT', -1);
 
%��� ����� ������ 1 �������, break 
if size(max_value,2)== 1
    fprintf('The minimum degree-distance of the 2 signals in order to be recognized is  u2-u1= %3.3f \n', u2-u1) 
    break
end

end