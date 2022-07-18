close all;
clear;
clc;

format long;
n = 15000;
%οριο για να κάνει break το loop της επανάληψης
tol = 1000000;

%%%%%%%%%%%%%%-------ΑΡΧΙΚΟΠΟΙΗΣΕΙΣ ΠΑΡΑΜΕΤΡΩΝ ΕΛΕΓΚΤΗ-------%%%%%%%%%%%%%%

%αρχικοποιώ τα Κ
K1_initial = 0;
K2_initial = 0;
K3_initial = 0;
K4_initial = 0;
K5_initial = 0;

%αρχικοποιώ τα theta
theta1_init = -1;
theta2_init = -1;
theta3_init = -1;
theta4_init = -1;
theta5_init = -1;

%αρχικοποιώ τα u
u1_init = 1;
u2_init = 1;
u3_init = 1;
u4_init = 1;
u5_init = 1;

%αρχικοποιώ τα K_best
K1_best = K1_initial;
K2_best = K2_initial;
K3_best = K3_initial;
K4_best = K4_initial;
K5_best = K5_initial;

%αρχικοποιώ τα theta_best
theta1_best = theta1_init;
theta2_best = theta2_init;
theta3_best = theta3_init;
theta4_best = theta4_init;
theta5_best = theta5_init;

%αρχικοποιώ u best
u1_best = u1_init;
u2_best = u2_init;
u3_best = u3_init;
u4_best = u4_init;
u5_best = u5_init;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%ο πίνακας performance κρατάει τα performance κάθε επανάληψης και το
%best_perf το καλύτερο performance
performance = 0;
best_perf = 0;


%loop επαναλήψεων μέχρι να ωθήσω την έξοδο y στο 0 με τον καλύτερο ελεγκτή
for k = 1:n
   
   %αν βρίσκομαι στην πρώτη επανάληψη τότε χρησιμοποιώ τις αρχικές τιμές που έχω ορίσει  
    K_1(1) = K1_initial; 
    K_2(1) = K2_initial;
    K_3(1) = K3_initial;
    K_4(1) = K4_initial;
    K_5(1) = K5_initial;
   
    theta_1(1) = theta1_init;
    theta_2(1) = theta2_init;
    theta_3(1) = theta3_init;
    theta_4(1) = theta4_init;
    theta_5(1) = theta5_init;
   
    u_1(1) = u1_init;
    u_2(1) = u2_init;
    u_3(1) = u3_init;
    u_4(1) = u4_init;
    u_5(1) = u5_init;
   

%βήμα της προσομοίωσης
dt = 0.01;

%αρχικοποιώ την μεταβλητή της έξοδου
y = 0;


%πίνακας σημείου ισορροπίας
x = [1 0.05 0.01 0.17 0.08];

%ολοκλήρωμα του performance που χρησιμεύει ως συνάρτηση βελτιστοποίησης του
%ελεγκτή
perf_int = 0;   
       
 for i = 1:20000
    y = x(1);
    
    u = -(K_1(k)*x(1) + K_2(k)*x(2) + K_3(k)*x(3) + K_4(k)*x(4) + K_5(k)*x(5)) + ( theta_1(k)*x(1)*x(3)*x(5) + theta_1(k)*log(abs(x(1)+2)) + theta_2(k)*x(1)*x(3)*cos(x(4)) + theta_2(k)*x(1)*x(2)*log(abs(x(1)+2)) + theta_3(k)*x(2)*x(3)*x(4) + theta_3(k)*x(1)*cos(x(2)) + theta_4(k)*cos(x(1))*log(abs(x(1)+2)) + theta_4(k)*x(2)*x(3)*x(4) + theta_5(k)*x(5)*x(2)*cos(x(3)) + theta_5(k)*x(4)*x(1)*log(abs(x(1)+ 2)))/((u_1(k)*x(4)*x(3)*cos(x(2)) + u_1(k)*x(1)*x(2)*log(abs(x(1)+2)) + u_2(k)*x(4)*x(5)*log(abs(x(1)+2)) + u_2(k)*x(2)*x(4)*cos(x(2)) + u_3(k)*x(1)*x(5)*x(3) + u_3(k)*x(4)*log(abs(x(1)+2)) + u_4(k)*cos(x(5))*log(abs(x(1)+2)) + u_4(k)*x(2)*x(1)*x(3) + u_5(k)*x(2)*x(4)*x(5) + u_5(k)*x(3)*cos(x(2)))^2);
    
    x1_dot = x(2);
    x2_dot = x(3);
    x3_dot = x(4);
    x4_dot = x(5);
    x5_dot = 18*x(1)*x(3)*x(5) +18*log(abs(x(1)+2)) + 7*x(1)*x(3)*cos(x(4)) +7*x(1)*x(2)*log(abs(x(1)+2)) +18*x(2)*x(3)*x(4) +18*x(1)*cos(x(2)) +19*cos(x(1))*log(abs(x(1)+2)) +19*x(4)*x(2)*x(3) +9*x(5)*x(2)*cos(x(3)) +9*x(4)*x(1)*log(abs(x(1)+2)) +(( 18*x(4)*x(3)*cos(x(2)) +18*x(1)*x(2)*log(abs(x(1)+2))+15*x(4)*x(5)*log(abs(x(1)+2))+15*x(2)*x(4)*cos(x(2))+10*x(1)*x(5)*x(3)+10*x(4)*log(abs(x(1)+2))+9*cos(x(5))*log(abs(x(1)+2))+9*x(1)*x(2)*x(3)+13*x(2)*x(4)*x(5)+13*x(3)*cos(x(2)))^2)*u;
    
    x(1) = x(1)+dt*x1_dot;
    x(2) = x(2)+dt*x2_dot;
    x(3) = x(3)+dt*x3_dot;
    x(4) = x(4)+dt*x4_dot;
    x(5) = x(5)+dt*x5_dot;
    
    
    perf_int = abs(y) + perf_int;
     %perf_int = abs(y)*dt;
     
    if(perf_int > tol)
        break;
    end
    
 end
    performance(k) = perf_int;
    
    %στην 1η επανάληψη αρχικοποιώ ως το best performance
    %το 1ο performance
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
    
    
    theta1_best = theta_1(k);
    theta2_best = theta_2(k);
    theta3_best = theta_3(k);
    theta4_best = theta_4(k);
    theta5_best = theta_5(k);
    
    u1_best = u_1(k);
    u2_best = u_2(k);
    u3_best = u_3(k);
    u4_best = u_4(k);
    u5_best = u_5(k);
    
    iteration_of_best_perf = k;
end
    
   plot_best_perf(k) = best_perf;
   
   %ορίζω τυχαίες μεταβολές για το Κ
   disp_K1 = 0.1 - 0.2*rand; 
   disp_K2 = 0.1 - 0.2*rand;
   disp_K3 = 0.1 - 0.2*rand;
   disp_K4 = 0.1 - 0.2*rand;
   disp_K5 = 0.1 - 0.2*rand;
   
   %ορίζω τυχαίες μεταβολές για το theta
   disp_theta_1 = 0.1 - 0.2*rand;
   disp_theta_2 = 0.1 - 0.2*rand;
   disp_theta_3 = 0.1 - 0.2*rand;
   disp_theta_4 = 0.1 - 0.2*rand;
   disp_theta_5 = 0.1 - 0.2*rand;
   
   %ορίζω τυχαίες μεταβολές για το u
   disp_u1  = 0.1 - 0.2*rand;
   disp_u2  = 0.1 - 0.2*rand;
   disp_u3  = 0.1 - 0.2*rand;
   disp_u4  = 0.1 - 0.2*rand;
   disp_u5  = 0.1 - 0.2*rand;
   
   %υπολογίζω τα Κ της επόμενης επανάληψης
   K_1(k+1) = K1_best + disp_K1; 
   K_2(k+1) = K2_best + disp_K2;
   K_3(k+1) = K3_best + disp_K3;
   K_4(k+1) = K4_best + disp_K4;
   K_5(k+1) = K5_best + disp_K5;
   
   %υπολογίζω τα θ της επόμενης επανάληψης
   theta_1(k+1) = theta1_best + disp_theta_1;
   theta_2(k+1) = theta2_best + disp_theta_2;
   theta_3(k+1) = theta3_best + disp_theta_3;
   theta_4(k+1) = theta4_best + disp_theta_4;
   theta_5(k+1) = theta5_best + disp_theta_5;
   
   %υπολογίζω τα u της επόμενης επανάληψης
   u_1(k+1) = u1_best + disp_u1;
   u_2(k+1) = u2_best + disp_u2;
   u_3(k+1) = u3_best + disp_u3;
   u_4(k+1) = u4_best + disp_u4;
   u_5(k+1) = u5_best + disp_u5;
   
end




%%%%%%%%%%%%%%%------------ΑΠΕΙΚΟΝΙΖΩ ΤΗΝ ΕΞΟΔΟ Y ΓΙΑ ΤΟΝ ΚΑΛΥΤΕΡΟ ΕΛΕΓΚΤΗ------------%%%%%%%%%%%%%%%

%πίνακας σημείου ισορροπίας
 x = [1 0.05 0.01 0.17 0.08];
%βήμα της προσομοίωσης
 dt = 0.01;

 for i = 1:20000
    y = x(1);
    
    u = -(K1_best*x(1) + K2_best*x(2) + K3_best*x(3) + K4_best*x(4) + K5_best*x(5)) + ( theta1_best*x(1)*x(3)*x(5) + theta1_best*log(abs(x(1)+2)) + theta2_best*x(1)*x(3)*cos(x(4)) + theta2_best*x(1)*x(2)*log(abs(x(1)+2)) + theta3_best*x(2)*x(3)*x(4) + theta3_best*x(1)*cos(x(2)) + theta4_best*cos(x(1))*log(abs(x(1)+2)) + theta4_best*x(2)*x(3)*x(4) + theta5_best*x(5)*x(2)*cos(x(3)) + theta5_best*x(4)*x(1)*log(abs(x(1)+ 2)))/((u1_best*x(4)*x(3)*cos(x(2)) + u1_best*x(1)*x(2)*log(abs(x(1)+2)) + u2_best*x(4)*x(5)*log(abs(x(1)+2)) + u2_best*x(2)*x(4)*cos(x(2)) + u3_best*x(1)*x(5)*x(3) + u3_best*x(4)*log(abs(x(1)+2)) + u4_best*cos(x(5))*log(abs(x(1)+2)) + u4_best*x(2)*x(1)*x(3) + u5_best*x(2)*x(4)*x(5) + u5_best*x(3)*cos(x(2)))^2);
    
    x1_dot = x(2);
    x2_dot = x(3);
    x3_dot = x(4);
    x4_dot = x(5);
    x5_dot = 18*x(1)*x(3)*x(5) +18*log(abs(x(1)+2)) + 7*x(1)*x(3)*cos(x(4)) +7*x(1)*x(2)*log(abs(x(1)+2)) +18*x(2)*x(3)*x(4) +18*x(1)*cos(x(2)) +19*cos(x(1))*log(abs(x(1)+2)) +19*x(4)*x(2)*x(3) +9*x(5)*x(2)*cos(x(3)) +9*x(4)*x(1)*log(abs(x(1)+2)) +(( 18*x(4)*x(3)*cos(x(2)) +18*x(1)*x(2)*log(abs(x(1)+2))+15*x(4)*x(5)*log(abs(x(1)+2))+15*x(2)*x(4)*cos(x(2))+10*x(1)*x(5)*x(3)+10*x(4)*log(abs(x(1)+2))+9*cos(x(5))*log(abs(x(1)+2))+9*x(1)*x(2)*x(3)+13*x(2)*x(4)*x(5)+13*x(3)*cos(x(2)))^2)*u;
    
    x(1) = x(1)+dt*x1_dot;
    x(2) = x(2)+dt*x2_dot;
    x(3) = x(3)+dt*x3_dot;
    x(4) = x(4)+dt*x4_dot;
    x(5) = x(5)+dt*x5_dot;
    
    y_plot(i) = real(y);
 end
 
%απεικονίζω τις τιμές του performance και του βέλτιστου ελεγκτή
best_perf
iteration_of_best_perf
K1_best
K2_best
K3_best
K4_best
K5_best
theta1_best
theta2_best
theta3_best
theta4_best
theta5_best
u1_best
u2_best
u3_best
u4_best
u5_best


plot(y_plot)