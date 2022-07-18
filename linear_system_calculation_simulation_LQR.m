close all;
clear;
clc;


%εισάγω τους πίνακες
A = [0 1 0 0 0;0 0 1 0 0;0 0 0 1 0;0 0 0 0 1;97.82 63.01 97.36 80.3 28.27];
B = [0;0;0;0;9460.52];
C = [1 0 0 0 0];
D = 0;

%θέτω τους πίνακες για την LQR μέθοδο
Q = eye(5);
R = [1];

%υπολογίζω τον ελεγκτή
[K,M,E] = lqr(A,B,Q,R)

%υπολογίζω την απόκριση
sys2 = ss(A-B*K,B,C,D);
%υπολογίζω το διάνυσμα του χρόνου
tt = 0:0.01:8;

%προσομοιώνω την απόκριση
[y2,t2,x2] = initial(sys2,[1;pi/2;pi/2;pi/2;pi/2]',tt);

%υπολογίζω την είσοδο ελέγχου
u = -K*x2';

%plotting
subplot(211)
plot(t2,x2(:,1),'r-.'); hold on
plot(t2,x2(:,2),'k--'); hold on
plot(t2,x2(:,3),'y--'); hold on
plot(t2,x2(:,4),'m--'); hold on
plot(t2,x2(:,5),'b--');
legend('x1','x2', 'x3','x4','x5');
legend('Location','southeast','Orientation','horizontal');
grid; ylabel('states')
subplot(212)
plot(t2,u); 
grid; 
ylabel('control'); 
xlabel('time [s]'); 
title('LQR design ex. 2')