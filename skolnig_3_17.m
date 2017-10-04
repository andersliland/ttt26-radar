clc; clear; close all;
%% 3.17
% a)

w = 5; % wind speed in [kts]  
f0 = 3; % carrier frequency [GHz]

r = 394*w^(-1.55)*f0^(-1.21);


If = (r+1)*((lambda*fp*b)/(2*pi))^(2*n)*((1*3*5)/(2^n)*factorial(n)*factorial(2*n));