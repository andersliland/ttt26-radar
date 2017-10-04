clc; clear; close all;
k = 1;
p = 2;
h=xlsread('filters.xls');   % import the analysis filters
f=xlsread('filters.xls');   % import the synthesis filters

t=0:1/(2*pi):60;       % time interval

% creat an input signal which consists of four sinusoidal waves with differet frequencies
f_base=pi/8;             
f1=0.5*f_base;
f2=2.5*f_base;
f3=4.5*f_base;
f4=6.5*f_base;

x=sin(2*pi*f1*t)+sin(2*pi*f2*t)+sin(2*pi*f3*t)+sin(2*pi*f4*t);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

amplifier_coefficient=[2 0 1 0.5];   % the processing unit


%%% Main  %%%
for i=1:4
    temp1=filter(h(i,:),1,x);                % filter the input with the analysis filters
    temp2=downsample(temp1,4);               % downsample by 4
    temp3=amplifier_coefficient(i)*temp2;    % process the wave
    temp4=upsample(temp3,4);                 % upsample by 4
    temp5=filter(f(i,:),1,temp4);            % filter the upsampled signals with the synthesis filters
    subband(i,:)=temp5;                      % store the output for each subband
end
y=sum(subband);                              % final output
%%%%%%%%%%%%%%%


% plot the input and output in the frequency domain
X=fftshift(fft(x,512));
Y=fftshift(fft(y,512));
plot(linspace(-pi,pi,length(X)),abs(X),'linewidth',2);
hold on
plot(linspace(-pi,pi,length(Y)),abs(Y),'r','linewidth',2);
legend('input','output')
xlim([0 pi])
xlabel('Normalized Frequency','FontName','Times New Roman','FontSize',10)
ylabel('Amplitude','FontName','Times New Roman','FontSize',10)


