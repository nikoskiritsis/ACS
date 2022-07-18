close all;
clear;
clc;
format long;

n = 50000;
%οριο για να κάνει break το loop της επανάληψης
tol = 10000000;

%%%%%%%%%%%%%%-------ΑΡΧΙΚΟΠΟΙΗΣΕΙΣ ΠΑΡΑΜΕΤΡΩΝ ΕΛΕΓΚΤΗ-------%%%%%%%%%%%%%%

%αρχικοποιώ τα Κ
K1_initial = 0;
K2_initial = 0;
K3_initial = 0;
K4_initial = 0;
K5_initial = 0;

%αρχικοποιώ τα K_best
K1_best = K1_initial;
K2_best = K2_initial;
K3_best = K3_initial;
K4_best = K4_initial;
K5_best = K5_initial;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%ο πίνακας performance κρατάει τα performance κάθε επανάληψης και το
%best_perf το καλύτερο performance
performance = 0;
best_perf = 0;

for k = 1:n

K_1(1) = K1_initial; 
K_2(1) = K2_initial;
K_3(1) = K3_initial;
K_4(1) = K4_initial;
K_5(1) = K5_initial;

%βήμα της προσομοίωσης
dt = 0.001;

%πίνακας σημείου ισορροπίας
x = [1 0.05 0.01 0.17 0.08];

%ολοκλήρωμα του performance που χρησιμεύει ως συνάρτηση βελτιστοποίησης του
%ελεγκτή
perf_int = 0; 
     
       
 for i = 1:30000
    y = x(1);
    
    u = -(K_1(k)*x(1) + K_2(k)*x(2) + K_3(k)*x(3) + K_4(k)*x(4) + K_5(k)*x(5));
    
    x1_dot = x(2);
    x2_dot = x(3);
    x3_dot = x(4);
    x4_dot = x(5);
    x5_dot = 18*x(1)*x(3)*x(5) +18*x(2)*log(abs(x(1)+2)) + 7*x(1)*x(3)*cos(x(4)) +7*x(2)*log(abs(x(1)+2)) +18*x(2)*x(3)*x(4) +18*x(1)*cos(x(2)) +19*cos(x(1))*log(abs(x(1)+2)) +19*x(4)*x(1)*log(abs(x(1)+2)) +9*x(5)*x(2)*cos(x(3)) +9*x(4)*x(1)*log(abs(x(1)+2)) +(( 18*x(4)*x(3)*cos(x(2)) +18*x(1)*x(2)*log(abs(x(1)+2))+15*x(4)*x(5)*log(abs(x(1)+2))+15*x(2)*x(4)*cos(x(2))+10*x(1)*x(5)*x(3)+x(4)*log(abs(x(1)+2))+9*cos(x(5))*log(abs(x(1)+2))+9*x(1)*x(2)*x(3)+13*x(2)*x(4)*x(5)+13*x(3)*cos(x(2)))^2)*u;
    
    x(1) = x(1)+dt*x1_dot;
    x(2) = x(2)+dt*x2_dot;
    x(3) = x(3)+dt*x3_dot;
    x(4) = x(4)+dt*x4_dot;
    x(5) = x(5)+dt*x5_dot;
    
    
    perf_int = abs(y) + perf_int;
     
    if(perf_int > tol)
        break;
    end
    
 end
 
     performance(k) = perf_int;
    
    %στην πρώτη επανάληψη αρχικοποιώ ως best performance
    %το πρώτο performance
    if(k == 1)
        best_perf = performance(k);
        
    end
    
%elegxos an to performance meiwnetai i oxi
if(performance(k) < best_perf)
    
    best_perf = performance(k);
    
    K1_best = K_1(k);
    K2_best = K_2(k);
    K3_best = K_3(k);
    K4_best = K_4(k);
    K5_best = K_5(k);
    
    
    iteration_of_best_perf = k;
end

   best_perf_plot(k) = best_perf;
   
   %ορίζω τυχαίες μεταβολές για το Κ
   disp_K1 = 1 - 2*rand; 
   disp_K2 = 1 - 2*rand;
   disp_K3 = 1 - 2*rand;
   disp_K4 = 1 - 2*rand;
   disp_K5 = 1 - 2*rand;
   
   K_1(k+1) = K1_best + disp_K1; 
   K_2(k+1) = K2_best + disp_K2;
   K_3(k+1) = K3_best + disp_K3;
   K_4(k+1) = K4_best + disp_K4;
   K_5(k+1) = K5_best + disp_K5;
   
end


%apeikonizw tis veltistes times
best_perf
iteration_of_best_perf
K1_best
K2_best
K3_best
K4_best
K5_best

%%%%%%%%%%%%%%%------------ΑΠΕΙΚΟΝΙΖΩ ΤΗΝ ΕΞΟΔΟ Y ΓΙΑ ΤΟΝ ΚΑΛΥΤΕΡΟ ΕΛΕΓΚΤΗ------------%%%%%%%%%%%%%%%

%πίνακας σημείου ισορροπίας
 x = [1 0.05 0.01 0.17 0.08];
%βήμα της προσομοίωσης
 dt = 0.001;
 
  for i = 1:30000
    y = x(1);
    
    u = -(K1_best*x(1) + K2_best*x(2) + K3_best*x(3) + K4_best*x(4) + K5_best*x(5));
    
    x1_dot = x(2);
    x2_dot = x(3);
    x3_dot = x(4);
    x4_dot = x(5);
    x5_dot = 18*x(1)*x(3)*x(5) +18*x(2)*log(abs(x(1)+2)) + 7*x(1)*x(3)*cos(x(4)) +7*x(2)*log(abs(x(1)+2)) +18*x(2)*x(3)*x(4) +18*x(1)*cos(x(2)) +19*cos(x(1))*log(abs(x(1)+2)) +19*x(4)*x(1)*log(abs(x(1)+2)) +9*x(5)*x(2)*cos(x(3)) +9*x(4)*x(1)*log(abs(x(1)+2)) +( 18*x(4)*x(3)*cos(x(2)) +18*x(1)*x(2)*log(abs(x(1)+2))+15*x(4)*x(5)*log(abs(x(1)+2))+15*x(2)*x(4)*cos(x(2))+10*x(1)*x(5)*x(3)+x(4)*log(abs(x(1)+2))+9*cos(x(5))*log(abs(x(1)+2))+9*x(1)*x(2)*x(3)+13*x(2)*x(4)*x(5)+13*x(3)*cos(x(2)))^2*u;
    
    x(1) = x(1)+dt*x1_dot;
    x(2) = x(2)+dt*x2_dot;
    x(3) = x(3)+dt*x3_dot;
    x(4) = x(4)+dt*x4_dot;
    x(5) = x(5)+dt*x5_dot;
    
    y_plot(i) = real(y);
  end
 
plot(y_plot)