% Code altered from Matlab's example found at
% https://uk.mathworks.com/help/matlab/ref/fft.html
function [f_Y,P1_Y,f_S,P1_S] = amplitude_spectrum(y,Fs,synthesis,g)
lngth = length(y);

% Calculate the FFT of the 2 signals, y (original) and s (synthesised)
Y = fft(y);
S = fft(synthesis(1:lngth));

% Compute the 2 sided spectrum and from this compute the 1 sided spectrum
P2_Y = abs(Y/lngth);
P1_Y = P2_Y(1:lngth/2+1);
P1_Y(2:end-1) = 2*P1_Y(2:end-1);

P2_S = abs(S/lngth);
P1_S = P2_S(1:lngth/2+1);
P1_S(2:end-1) = 2*P1_S(2:end-1);

% Define the frequency domain and plot the one sided spectrum
f_Y = Fs*(0:(lngth/2))/lngth;
plot(f_Y,P1_Y) 
if (g==1)
    title('Male "Had" Single-Sided Amplitude Spectrum Original')
else
    title('Female "Had" Single-Sided Amplitude Spectrum Original')
end
xlabel('f (Hz)')
ylabel('Amplitude (dB)')

pause;

f_S = Fs*(0:(lngth/2))/lngth;
plot(f_S,P1_S) 
if (g==1)
    title('Male "Had" Single-Sided Amplitude Spectrum Synthesised')
else
    title('Female "Had" Single-Sided Amplitude Spectrum Synthesised')
end
xlabel('f (Hz)')
ylabel('Amplitude (dB)')