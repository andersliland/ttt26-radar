clc; clear; close all;
%% 2.24
% Radar parameters
Pt = 25e3; % Peak power [W]
G_dB  = 33; % Gain [dB]
G = 10^(G_dB/10); % Gain
f = 9400e6; % Frequency [Hz]
c = 299792458; % Speed of light [m/S]
lambda = c/f; % wavelength
t_p = 0.15e-6; % pulse width [s]
Ae = (G*lambda^2)/(4*pi); % Antenna effective aperture [m^2]
RCS = 10; % Target cross-section [m^2]
B = 15e6;% Receiver bandwidth [Hz]
T_fa = 4*60*60; % False-alarm time [s]
P_fa = 1/(T_fa*B); % Probability of false alarm
k = 1.38e-23; % Boltsman constant [J/deg]
T_o = 290; % Standard temperature [K]
Fn_dB = 5; % Receiver noise figure [dB]
Fn = 10^(Fn_dB/10); % Receiver noise figure
horz_bw = 0.8; % [deg]
vert_bw = 15; % [deg]
prf = 4000; % Pulse repetition frequency [Hz]
w_r = 20; % revolutions per minute
n = (horz_bw*prf) / (6*w_r); % Number of pulses integrated, hits per scan, pulses per scan
Ii = 10; % Integration efficiency, based of graph from figure 2.7, p47
Ei = Ii/n; 
Ls_dB = 12; % System loss [dB]
Ls = 10^(Ls_dB/10); % System loss
Rmax = linspace(5e3, 3e4,10e3); % Maximum radar range [m]
Rmax_nmi = Rmax./1852;

%% a)
% Single-scan probability of detection, as funciton of range
SNR = (Pt*G*Ae*RCS*n*Ei)./((4*pi)^2*k*T_o*B*Fn*(Rmax.^4)*Ls);
figure(1); plot(Rmax_nmi, 10*log10(SNR));
grid on
title('SNR ratio vs distance');
xlabel('Maximum radar range [nmi]');
ylabel('SNR [dB]');

A = log(0.62/P_fa); % Temp variable from Albersheim empirical formula for relationship between S_N, Pd and Pfa
C = exp((SNR-A)./(0.12*A+1.7));
P_d = C./(1+C);
figure(2); plot(Rmax_nmi, P_d);
%axis([0.3 0.99]);
title('Pd vs distance');
xlabel('Maximum radar range [nmi]');
ylabel('Probability of detection');
grid on
hold on
%%
% b) Swerling Case 1: Completely correlated
p = 1; % correlation coefficient
n_e = 1+(n-1)*log(1/p)

L_f = 1.5; % Additional SNR for one pulse
SNR = (Pt*G*Ae*RCS*n*Ei)./((4*pi)^2*k*T_o*B*Fn*(Rmax.^4)*Ls*L_f);
A = log(0.62/P_fa);
C = exp((SNR-A)./(0.12*A+1.7));
P_d = C./(1+C);
plot(Rmax_nmi, P_d);

L_f = 3;
SNR = (Pt*G*Ae*RCS*n*Ei)./((4*pi)^2*k*T_o*B*Fn*(Rmax.^4)*Ls*L_f);
A = log(0.62/P_fa);
C = exp((SNR-A)./(0.12*A+1.7));
P_d = C./(1+C);
plot(Rmax_nmi, P_d);
legend('Lf = 1','Lf = 1.5','Lf = 3');
hold off


%% c)
% The radar have a 90% probability of detection at 8 nmi. This shoud be
% enough time for the bout to safely change course.


%% d)
% The ship-mounted radar antenna have a 15deg elevation beamwidth to allow
% it to see over the horizon. The radar beams will be curved due to gravity








