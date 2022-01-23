% Computing BER for BPSK modulation in a Rayleigh fading channel
clear; close all; clc; tic;
n = 10^6; % number of bits or symbols
bits = rand(1,n)>0.5; % generating 0,1 with equal probability
signal = 2*bits-1; % BPSK modulation 0 -> -1; 1 -> 1
Eb_n0_dB = [0:10]; % multbitsle Eb/n0 values
for i = 1:length(Eb_n0_dB)
   gn = 1/sqrt(2)*[randn(1,n) + j*randn(1,n)]; % white gaussian noise, 0dB variance 
   h = 1/sqrt(2)*[randn(1,n) + j*randn(1,n)]; % Rayleigh channel
   y = h.*signal + 10^(-Eb_n0_dB(i)/20)*gn;% Channel and noise addition 
   yHat = y./h;% equalization
   bitsHat = real(yHat)>0;% receiver - hard decision decoding
   num_Error(i) = size(find([bits- bitsHat]),2); % counting the errors
end
sim_BER = num_Error/n; % simulated ber
Ebn0Lin = 10.^(Eb_n0_dB/10);%Making snr linear for plotting
figure;
semilogy(Eb_n0_dB,sim_BER,'-','LineWidth',1);
axis([0 10 10^-5 1]);grid on;
legend( 'RAYLEIGH');xlabel('SnR,dB');ylabel('BER');
title('BER for BPSK modulation in RAYLEIGH channel');