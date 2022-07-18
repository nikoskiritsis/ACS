close all;
clear;
clc;
format long;

n = 1000000;

%���� ��� �� ����� break �� loop ��� ����������
tol = 100000000000; %10^11

%%%%%%%%%%%%%%-------�������������� ���������� �������-------%%%%%%%%%%%%%%

%���������� �� �p,Kd,Ki
Kd_initial = 100;
Kp_initial = 100;
Ki_initial = 100;

%���������� �� �p_best,Kd_best,Ki_best
Kd_best = Kd_initial;
Kp_best = Kp_initial;
Ki_best = Ki_initial;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%� ������� performance ������� �� performance ���� ���������� ��� ��
%best_perf �� �������� performance
performance = 0;
best_perf = 0;


%loop ����������� ����� �� ����� ��� ����� y ��� 0 �� ��� �������� �������
for k = 1:n
%�� ��������� ���� ����� ��������� ���� ����������� ��� ������� ����� ��� ��� ������
Kd(1) = Kd_initial;
Kp(1) = Kp_initial;
Ki(1) = Ki_initial;


%���� ��� ������������
dt = 0.001;

  
%���������� ��� ��������� ��� ������
y = 0;
%���������� ��� ���������� ��� ������������� ��� ��� ������������ ���� ��� ������
int_y = 0;
prev_y = 0;

%������� ������� ����������
x = [1 0.05 0.01 0.17 0.08];

%���������� ��� performance ��� ���������� �� ��������� ��������������� ���
%�������
perf_int = 0;   
       
 for i = 1:60000
    y = x(1);
    int_y = y*dt+int_y;
    dy = (y-prev_y)/dt;
    u = Kd(k)*dy + Kp(k) + Ki(k)*int_y;
    
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
    
    perf_int = abs(y) + perf_int;
    if(perf_int > tol)
        break;
    end
    
 end
    performance(k) = perf_int;
    
    %���� 1� ��������� ���������� �� �� best performance
    %�� 1� performance
    if(k == 1)
        best_perf = performance(k);
    end

    
    %elegxos an to performance meiwnetai i oxi
if(performance(k) < best_perf)
    
    best_perf = performance(k);
    
    Kd_best = Kd(k);
    Kp_best = Kp(k);
    Ki_best = Ki(k);
    
    iteration_of_best_perf = k;
end

   %����� ������� ��������� ��� �� �
   disp_Kp = 1000 - 2000*rand; 
   disp_Kd = 1000 - 2000*rand;
   disp_Ki = 1000 - 2000*rand;
   
   %��������� �� � ��� �������� ����������
   Kp(k+1) = Kp_best + disp_Kp;
   Kd(k+1) = Kd_best + disp_Kd;
   Ki(k+1) = Ki_best + disp_Ki;
   
   

end


%%%%%%%%%%%%%%%------------���������� ��� ����� Y ��� ��� �������� �������------------%%%%%%%%%%%%%%%

%������� ������� ����������
 x = [1 0.05 0.01 0.17 0.08];
%���� ��� ������������
 dt = 0.001;
 
  for i = 1:60000
    y = x(1);
    int_y = y*dt+int_y;
    dy = (y-prev_y)/dt;
    u = Kd_best*dy + Kp_best + Ki_best*int_y;
    
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


%apeikonizw tis veltistes times
best_perf
iteration_of_best_perf
Kp_best
Kd_best
Ki_best

plot(y_plot)