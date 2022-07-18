close all;
clear;
clc;
format long;
%PID ελεγκτής
Kd = 0.006063481945883;
Kp = 0.010328469966251;
Ki = -5.873338864813438e-08;
%χρόνος προσομοίωσης
dt = 0.0001;
int_y = 0;
prev_y = 0;
%πίνακας σημείου ισορροπίας
x = [1 pi/2 pi/2 pi/2 pi/2];
for i = 1:5500
    y = x(1);
    int_y = y*dt+int_y;
    dy = (y-prev_y)/dt;
    u = Kd*dy + Kp + Ki*int_y;
    
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
    prev_y = y;
    y_plot(i) = real(y);
end

plot(y_plot)