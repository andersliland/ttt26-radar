clc; clear; close all;

%% 3.3
% a)
c = 3e8;
f = 1250e6;
prf = 340;
Tp = 1/prf;
vr_kts = 12;
vr_ms = 12*0.51444; % radial velocity [m/s]
lambda = c/f;

vr_ms = linspace(0,50,100);
fd = (2.*vr_ms)/lambda; % Doppler frequency [Hz]
H = 2*sin(pi*fd*Tp); % Frequency response
plot(vr_ms,abs(H));
axis([0 50 0 3]);
hold on
plot(vr_ms,max(abs(H))*ones(size(vr_ms)));
hold off
title('Amplitude response of L-band radar')
xlabel('Velocity [$\frac{m}{s}$]','Interpreter','latex');
ylabel('|H(f)|');
legend('|H(f)|', 'max(|H(f)|)');
