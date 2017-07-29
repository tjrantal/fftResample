close all;
clear all;
clc;

time = linspace(0,1,1500);
desiredNumberOfDataPoints = 170;
fftTime = linspace(0,1,desiredNumberOfDataPoints);
testSignal = sin(2*pi*time*25)+sin(2*pi*time*10);
tic
reconstructed = fft_normalize(testSignal,desiredNumberOfDataPoints);
toc
figure
set(gcf,'position',[10 10 1000 500]);
plot(time,testSignal,'k.-');
hold on;
plot(fftTime,reconstructed,'r.-');
