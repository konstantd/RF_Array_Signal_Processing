%Πίνακας Οδήγησης
A=zeros(8,7);  
for i=1:8
    A(i,1)= exp(1i*pi* (i-1)*cosd(40)); 
    A(i,2)= exp(1i*pi* (i-1)*cosd(60)); 
    A(i,3)= exp(1i*pi* (i-1)*cosd(80)); 
    A(i,4)= exp(1i*pi* (i-1)*cosd(100));  
    A(i,5)= exp(1i*pi* (i-1)*cosd(120));
    A(i,6)= exp(1i*pi* (i-1)*cosd(130)); 
    A(i,7)= exp(1i*pi* (i-1)*cosd(150));               
end

SNR=10;
sigma2 = 1/(10^(SNR/10)); 
Rnn=sigma2*eye(8);
Rgg=eye(7);
Rxx=A*Rgg*A'+Rnn;

%Yπολογισμός Χωρικού Φάσματος
Py=zeros(1,1800);
for step=1:1800
 ad=zeros(8,1);
    for in=1:8
         ad(in)=exp((in-1)*1i*pi*cosd(step*0.1));
    end  
    Py(1,step)=1/(ad'*inv(Rxx)*ad);   
end

%Απεικόνιση Χωρικού Φάσματος
thetad=0.1:0.1:180;
plot(thetad,10*log10(abs(Py)/max(abs(Py))))
xlabel('degrees')
ylabel('Py (dB)')


%Διάνυσμα Βαρών
w_capon=(inv(Rxx)*ad)/(ad'*inv(Rxx)*ad);

  
  