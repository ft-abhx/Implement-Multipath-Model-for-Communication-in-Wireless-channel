%Computing BER for BPSK modulation in a AWGN channel
clear; close all; clc; tic;
n=10^6;% numBER of samples or bits 
bits=randn(1,n)>0.5;%  enerating 0,1 with equal probability
signal=2*bits-1;% BPSK modulation 0 -> -1; 1 -> 1     
noise=1/sqrt(2)*(randn(1,n)+1i*randn(1,n)); %generating noise with zero mean and var. equal to 1.
mean(abs(noise.^2)) %test the power of the noise 
SNR=0:10; %set SNR in dB
snr_lin=10.^(SNR/10); %calculate linear snr from dB SNR.
y=zeros(length(SNR),n);
 %multiply sqrt of snr to signal and add noise:
for i=1:length(SNR)
    y(i,:)=real(sqrt(snr_lin(i))*signal+noise);
end
%reciever and BER count
err=zeros(length(SNR),n); Err=zeros(10,2); 
for i=1:length(SNR)
    for j=1:n
       if y(i,j)>=0
           y(i,j)=1;
       else
           y(i,j)=0;  
       end 
    end
      err(i,:)=abs(y(i,:)-bits);
      Err(i,:)=size(find(err(i,:)));
end
 %calculating BER
BER=zeros(length(SNR),1);
for i=1:length(SNR)
    BER(i)=Err(i,2)/n;
end
semilogy(SNR,BER,'b-','linewidth',1); grid on;  hold on;
xlabel('SNR'); ylabel('BER'); legend('AWGN') ; toc;
title('BER for BPSK modulation in AWGN channel');