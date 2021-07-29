clear

SNR_values=[0 5 10 20];

for q=1:size(SNR_values,2)
  SNR=SNR_values(q);
   for D=2:2:10  %��

fileID=fopen('AoAdev_SINR.txt', 'w');

%������� ������ 
angles=zeros(1000,3);
counter=1;
u0=120*rand+30;
u1=120*rand+30;
u2=120*rand+30;

while counter <1001  
    if abs(u0-u1)>D && abs(u0-u2)>D && abs(u1-u2)>D
      angles(counter,1)= u0;    
      angles(counter,2)= u1;    
      angles(counter,3)= u2;           
      counter=counter+1;
    end
    
 u0=120*rand+30;
 u1=120*rand+30;
 u2=120*rand+30;     
end
     
        
for iN=1:1000

%������� ��������
A=zeros(8,3);  
for i=1:8
    A(i,1)= exp(1i*pi* (i-1)*cosd(angles(iN,1)) ); 
    A(i,2)= exp(1i*pi* (i-1)*cosd(angles(iN,2)) ); 
    A(i,3)= exp(1i*pi* (i-1)*cosd(angles(iN,3)) ); 
end


e1=[1; 0; 0];
sigma2 = 1/(10^(SNR/10)); 

%�������� �����
w_nsb=A* inv( A'*A + sigma2*eye(3,3) )*e1;


Rgg=eye(3,3);
Rgigi=eye(2,2);
Rnn=sigma2*eye(8,8);
Ai=A(1:8,2:3);
Rxx=A*Rgg*A'+Rnn;
Ruu=Ai*Rgigi*Ai'+Rnn;

%Y���������� ad
ad=zeros(8,1);
for i=1:8
    ad(i)= exp(1i*pi*(i-1)*cosd(angles(1,1)) );   
end
     
%Y���������� SINR
%SINR2 = 10*log10((w_nsb' * ad * ad' * w_nsb )/ ( w_nsb' * Ai * Rgigi * Ai' * w_nsb + w_nsb' * Rnn *w_nsb));

%������������� SINR
SINR=10*log((w_nsb'*Rxx*w_nsb)/(w_nsb'*Ruu*w_nsb)-1);

%Y���������� Array Factor
 AF=zeros(1,1801);        %�������� 0.1 ������
 for step=1:1801
     a=zeros(8,1);
     for in=1:8
         a(in)=exp((in-1)*1i*pi*cosd((step-1)*0.1));
     end
     AF(step)=abs(w_nsb'*a);
 end
 
 %A��������� Array Factor
 AFdB=20*log10(AF/max(AF));
 thetad=0:0.1:180;
 plot(thetad,AFdB)
 
 
  %���� �� �������� � islocalmin (�� ��� ������ ��� matlab ��� �����������) ��� ������� �������� �� ������� ��
  %findpeaks ��� ������� ������� ���� ������������� �� -1 
  
  for i=1:1800
   AF(i) = -AF(i);
  end
  
 %E����� �������� ��� ������� ���������
 [min_values,index_mins] = findpeaks(AF);
 [max_value, index_max] = min(AF);
 
 %������ ���
 Du0=angles(iN,1)-index_max/10;   
  
  %������ ��1
Du1=180;
  for i=1:size(index_mins,2)
    if abs( angles(iN,2)- index_mins(i)/10  ) < abs( Du1)
       Du1 = angles(iN,2)- index_mins(i)/10 ;
    end
  end
  
  
  %������ ��2
Du2=180;
  for i=1:size(index_mins,2)
    if abs(angles(iN,3)- index_mins(i)/10 ) <abs( Du2)
       Du2 = angles(iN,3)- index_mins(i)/10 ;
    end
  end
  
 %��������� ��������� ��� ���� ��� 3��� ������ ��� ������
fprintf(fileID,'%3.5f\t %3.5f\t %3.5f\t %3.5f\t %3.5f\t %3.5f\t %3.5f \n',angles(iN,1), angles(iN,2), angles(iN,3), Du0, Du1, Du2, SINR);

end

%������� ������� ��� ������ �����������
load AoAdev_SINR.txt 

max_Du0 = max(abs(AoAdev_SINR(:,4)));
min_Du0 = min(abs(AoAdev_SINR(:,4)));
mean_Du0 = mean2(abs(AoAdev_SINR(:,4)));
std_Du0 = std2(AoAdev_SINR(:,4));


max_Du12 = max(max(abs(AoAdev_SINR(:,[5:6]))));
min_Du12 = min(min(abs(AoAdev_SINR(:,[5:6]))));
mean_Du12=mean2(abs(AoAdev_SINR(:,[5:6])));
std_Du12=std2(AoAdev_SINR(:,[5:6]));


min_SINR = min(AoAdev_SINR(:,7));
max_SINR = max(AoAdev_SINR(:,7));
mean_SINR = mean2(AoAdev_SINR(:,7));
std_SINR = std2(AoAdev_SINR(:,7));

%������� ����������� ��������� ��� ���� ��� SNR, �� ��������� ��� �atlab
fprintf('\n\n\nFor SNR= %3.3f and for Du= %3.3f the results are: \n\n min_Du0= %3.3f \n max_Du0= %3.3f \n mean_Du0= %3.3f \n std_Du0= %3.3f \n min_Du12= %3.3f \n max_Du12= %3.3f \n mean_Du12= %3.3f \n std_Du12= %3.3f \n min_SINR= %3.3f \n max_SINR= %3.3f \n mean_SINR= %3.3f \n std_SINR= %3.3f \n\n\n',SNR, D, min_Du0, max_Du0, mean_Du0, std_Du0, min_Du12, max_Du12, mean_Du12, std_Du12, min_SINR, max_SINR, mean_SINR, std_SINR);

  end
end
fclose(fileID);


  