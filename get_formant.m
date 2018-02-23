function [first_three_formants,A,formants] = get_formant(y,Fs,p_factor,g,window_length)

% Calculate the start and end of the section of the sample to be analysed
start_section = round(length(y)*0.25);
end_section = round(length(y)*0.85);

%y_w = y(start_section:end_section);
y_w = y(start_section:start_section+round(window_length*Fs));
% Apply a hamming window and pre-emphasis filter to the section
y_w = y_w.*hamming(length(y_w));
preemph = [1,0.63];
y_w = filter(1,preemph,y_w);

% This returns the coefficients of the Nth order forward linear predictor 
% and the variance (power) of the prediction error.
% Analyse the section with freqz - magnitude and frequency information and
% periodogram to see the performance of the LPC and original signal
[A,E_lpc] = aryule(y_w,p_factor);
freqz(1,A,360)
if (g==1)
    title('Male "Had" Frequency and Magnitude Response')
else
    title('Female "Had" Frequency and Magnitude Response')
end
pause;
[H1,w1] = freqz(sqrt(E_lpc),A);
periodogram(y_w)
hold on
hp = plot(w1/pi,20*log10(2*abs(H1)/(2*pi)),'r'); % Scale to make one-sided PSD
hp.LineWidth = 2;
xlabel('Normalized frequency (\times \pi rad/sample)')
ylabel('One-sided PSD (dB/rad/sample)')
legend('PSD estimate of x','PSD of model output')
if (g==1)
    title('Male "Had" Periodogram Power Spectral Density Estimate')
else
    title('Female "Had" Periodogram Power Spectral Density Estimate')
end
pause;
close all;

% Calculate the roots, separate the complex conjugate. Calculate the angle
% and then calculate the formant frequencies. 
roots_A = roots(A);
pos_roots_A = roots_A(imag(roots_A)>=0);
angles = atan2(imag(pos_roots_A),real(pos_roots_A));
formants = (angles./(2*pi))*Fs;

[formants,indices] = sort(formants);
first_three_formants = zeros(1,3);
n = 1;

% A crude test to calculate the first 3 formants. The threshold is set to
% 180Hz in order to reject any potential false readings
for i=1:length(formants)
    if(formants(i)>180)
        first_three_formants(n) = round(formants(i));
        n = n+1;
        if(n>3)
            break
        end
    end
end