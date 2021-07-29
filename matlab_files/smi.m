%Πίνακας Οδήγησης
A=zeros(8,6);  
for i=1:8
    A(i,1)= exp(1i*pi* (i-1)*cosd(50)); 
    A(i,2)= exp(1i*pi* (i-1)*cosd(70)); 
    A(i,3)= exp(1i*pi* (i-1)*cosd(100)); 
    A(i,4)= exp(1i*pi* (i-1)*cosd(110));  
    A(i,5)= exp(1i*pi* (i-1)*cosd(130));
    A(i,6)= exp(1i*pi* (i-1)*cosd(160)); 
end

%Γεννήτριες Τυχαίων αριθμών
N = normrnd(0,sqrt(10*10^(-2)),[8,100]);  
G = normrnd(0,1,[6,100]);       

%Σήμα αναφοράς-Επιθυμητό
p=G(1,:);

%Πίνακας Εισόδου
X=A*G+N;

%Εκτύπωση Διάνυσμα Βαρών
w_smi=inv(X*X')*X*p'

%Yπολογισμός Array Factor
 AF=zeros(1,1801);       %Ακρίβεια 0.1 μοίρες
 for step=1:1801
     a=zeros(8,1);
     for in=1:8
         a(in)=exp((in-1)*1i*pi*cosd((step-1)*0.1));
     end
     AF(step)=abs(w_smi'*a);
 end
 
%Απεικόνιση Array Factor
AFdB=20*log10(AF/max(AF));
thetad=0:0.1:180;
plot(thetad,AFdB)
xlabel('degrees')
ylabel('AF (dB)')

 
  %Αφού δε δουλεύει η islocalmin (με την έκδοση του matlab που χρησιμοποιώ) που βρίσκει ελάχιστα θα δουλέψω με
  %findpeaks που βρίσκει μέγιστα αφου πολλαπλασιάσω με -1 
  
  for i=1:1800
   AF(i) = -AF(i);
  end
  
  %Eύρεση μεγίστου και τοπικών ελαχίστων
 [min_values,index_mins] = findpeaks(AF);
 [max_value, index_max] = min(AF);
 
 %Εύρεση Δθο
 Du0= 50-index_max/10;

%Εύρεση Δθ1
Du1=180;
  for i=1:size(index_mins,2)
    if abs(70- index_mins(i)/10) < abs( Du1)
      Du1 = 70- index_mins(i)/10 ;
    end
end
  
  %Εύρεση Δθ2 
Du2=180;
  for i=1:size(index_mins,2)
    if abs(100- index_mins(i)/10 ) <abs( Du2)
       Du2 = 100- index_mins(i)/10 ;
    end
  end
 
   
 %Εύρεση Δθ3
Du3=180;
  for i=1:size(index_mins,2)
    if abs(110- index_mins(i)/10 ) <abs( Du3)
       Du3 = 110- index_mins(i)/10 ;
    end
  end
  
  %Εύρεση Δθ4
Du4=180;
  for i=1:size(index_mins,2)
    if abs(130- index_mins(i)/10 ) <abs( Du4)
       Du4 = 130- index_mins(i)/10 ;
    end
  end
  
   %Εύρεση Δθ5   
Du5=180;
  for i=1:size(index_mins,2)
    if abs(160- index_mins(i)/10 ) <abs( Du5)
       Du5 = 160- index_mins(i)/10 ;
    end
  end
 
 