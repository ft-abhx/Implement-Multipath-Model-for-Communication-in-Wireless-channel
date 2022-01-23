%Wireless Channel comparison using fading channels(BPSK modulation)
% Computing BER for BPSK modulation in a Rician fading channel
clear; close all; clc; tic;
n=10^6;%no of samples or bits 
bits=randi([0,1],1,n);% generates random integers 0's and 1's
signal=2*bits-1;% BPSK modulation 0 -> -1; 1 -> 1 
k_factor=10; % Rician factor
mean=sqrt(k_factor/(k_factor+1));% mean
variance=sqrt(1/(2*(k_factor+1)));% variance
Nr2=randn(1,length(signal))*variance+mean;
Ni2=randn(1,length(signal))*variance;
RFC=sqrt(Nr2.^2+Ni2.^2); % Rician fading coefficient
for k=0:1:40
    snrl=10^(k/10);% convert the SNR in dB value
    Np=1/snrl;% To generate the noise power
    sd=sqrt(Np/2);% standard deviation of guassian noise
    noise=random('Normal',0,sd,1,length(signal)); % Generates Gaussian noise
    t1=signal.*RFC+noise; % s means transmitted signal
    z1=t1./RFC;% equalization
 op1=(z1>0); % threshold detection
    BER(k+1)=sum(xor(op1,bits))/n; % observed BER
    end;
    %figure;
    k=0:1:20;
    semilogy(k,BER(k+1),'-','LineWidth',1);
    hold on;
    axis([0 10 10^-5 1]);
title('BER for BPSK modulation in RICIAN channel');grid on;
xlabel('SNR');ylabel('BER');
hleg=legend('RICIAN')