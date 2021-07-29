%������� ��������
A=zeros(8,6);  
for i=1:8
    A(i,1)= exp(1i*pi* (i-1)*cosd(50)); 
    A(i,2)= exp(1i*pi* (i-1)*cosd(70)); 
    A(i,3)= exp(1i*pi* (i-1)*cosd(100)); 
    A(i,4)= exp(1i*pi* (i-1)*cosd(110));  
    A(i,5)= exp(1i*pi* (i-1)*cosd(130));
    A(i,6)= exp(1i*pi* (i-1)*cosd(160)); 
end

%���������� ������� �������
N = normrnd(0,sqrt(10*10^(-2)),[8,100]);  
G = normrnd(0,1,[6,100]);       

%���� ��������-���������
p=G(1,:);

%������� �������
X=A*G+N;

%�������� �������� �����
w_smi=inv(X*X')*X*p'

%Y���������� Array Factor
 AF=zeros(1,1801);       %�������� 0.1 ������
 for step=1:1801
     a=zeros(8,1);
     for in=1:8
         a(in)=exp((in-1)*1i*pi*cosd((step-1)*0.1));
     end
     AF(step)=abs(w_smi'*a);
 end
 
%���������� Array Factor
AFdB=20*log10(AF/max(AF));
thetad=0:0.1:180;
plot(thetad,AFdB)
xlabel('degrees')
ylabel('AF (dB)')

 
  %���� �� �������� � islocalmin (�� ��� ������ ��� matlab ��� �����������) ��� ������� �������� �� ������� ��
  %findpeaks ��� ������� ������� ���� ������������� �� -1 
  
  for i=1:1800
   AF(i) = -AF(i);
  end
  
  %E����� �������� ��� ������� ���������
 [min_values,index_mins] = findpeaks(AF);
 [max_value, index_max] = min(AF);
 
 %������ ���
 Du0= 50-index_max/10;

%������ ��1
Du1=180;
  for i=1:size(index_mins,2)
    if abs(70- index_mins(i)/10) < abs( Du1)
      Du1 = 70- index_mins(i)/10 ;
    end
end
  
  %������ ��2 
Du2=180;
  for i=1:size(index_mins,2)
    if abs(100- index_mins(i)/10 ) <abs( Du2)
       Du2 = 100- index_mins(i)/10 ;
    end
  end
 
   
 %������ ��3
Du3=180;
  for i=1:size(index_mins,2)
    if abs(110- index_mins(i)/10 ) <abs( Du3)
       Du3 = 110- index_mins(i)/10 ;
    end
  end
  
  %������ ��4
Du4=180;
  for i=1:size(index_mins,2)
    if abs(130- index_mins(i)/10 ) <abs( Du4)
       Du4 = 130- index_mins(i)/10 ;
    end
  end
  
   %������ ��5   
Du5=180;
  for i=1:size(index_mins,2)
    if abs(160- index_mins(i)/10 ) <abs( Du5)
       Du5 = 160- index_mins(i)/10 ;
    end
  end
 
 