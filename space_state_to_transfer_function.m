clear;
clc;
syms s Kd Ki Kp

A = [0 1 0 0 0;0 0 1 0 0;0 0 0 1 0;0 0 0 0 1;97.82 63.01 97.36 80.3 28.27];
B = [0;0;0;0;9460.52];
C = [1 0 0 0 0];
D = 0;

[b,a] = ss2tf(A,B,C,D);
sys   = tf(b,a);

closed_loop_tf = feedback(sys,1);
