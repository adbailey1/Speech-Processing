close all;
clear all;

% Set the variables to be used throughout this program
% PLEASE REMEMBER TO KEEP THE GENDER CONSISTENT WITH THE SAMPLE CHOICE
male = 1;
female = 2;
window_length_f = 0.08;
window_length_m = 0.08;
p_factor_f = 21;
p_factor_m = 23;
% Turn attack sustain decay release on or off
attack_decay = 1;

% This first section analyses the female samples
file_f = 4;
g = female;

[y_f,Fs,est_f0_f,start_f,end_sample_f] = get_fundamental_f0(file_f,g,window_length_f,p_factor_f);

fprintf('Average F0 female estimate is %3.2f Hz.\n',est_f0_f)

[formants_f,LPC_coefficients_f,formants_all_f] = get_formant(y_f,Fs,p_factor_f,g,window_length_f);
fprintf('\n First Formant : %3.2f\n', formants_f(1))
fprintf('\n Second Formant : %3.2f\n', formants_f(2))
fprintf('\n Third Formant : %3.2f\n', formants_f(3))

[output_f,noise_f,impulse_f] = synthesise_sound(est_f0_f,LPC_coefficients_f,Fs,y_f,attack_decay);
sound(y_f,Fs);
pause;
sound(output_f,Fs);
pause;
sound(noise_f,Fs);

filename = 'had_f_synthesised_8.wav';
audiowrite(filename,output_f,Fs);
filename = 'had_f_synthesised2_8.wav';
audiowrite(filename,noise_f,Fs);

spectrogram(output_f(1:length(y_f)),100,95,[],Fs,'yaxis')
title 'Output Female "Had"'
pause;
plot(output_f(1:length(y_f)))
title 'Output Female "Had"'
xlabel 'Samples', ylabel 'Amplitude'
pause;
close all;
t_f = (1:size(y_f))/Fs;
plot(t_f,y_f,t_f,output_f(1:length(y_f)),'--')
title 'Female "Had" Original Signal vs. LPC Estimate'
xlabel 'Time (ms)', ylabel 'Amplitude'
legend('Original signal','LPC estimate')
pause;

erorr = y_f-(output_f(1:length(y_f)))';
[C,lags] = xcorr(erorr,'coeff');
plot(lags,C), grid
title 'Female "Had" Autocorrelation of the Prediction Error'
xlabel 'Lags', ylabel 'Normalized value'
pause;

[f_Y_f,P1_Y_f,f_S_f,P1_S_f] = amplitude_spectrum(y_f,Fs,output_f,g);

pause;

% This first section analyses the female samples
file_m = 6;
g = male;

[y_m,Fs,est_f0_m,start_m,end_sample_m] = get_fundamental_f0(file_m,g,window_length_m,p_factor_m);

fprintf('Average F0 male estimate is %3.2f Hz.\n',est_f0_m)

[formants_m,LPC_coefficients_m,formants_all_m] = get_formant(y_m,Fs,p_factor_m,g,window_length_m);
fprintf('\n First Formant : %3.2f\n', formants_m(1))
fprintf('\n Second Formant : %3.2f\n', formants_m(2))
fprintf('\n Third Formant : %3.2f\n', formants_m(3))

[output_m,noise_m,impulse_m] = synthesise_sound(est_f0_m,LPC_coefficients_m,Fs,y_m,attack_decay);
sound(y_m,Fs);
pause;
sound(output_m,Fs);
pause;
sound(noise_m,Fs);

filename = 'had_m_synthesised_8.wav';
audiowrite(filename,output_m,Fs);
filename = 'had_m_synthesised2_8.wav';
audiowrite(filename,noise_m,Fs);

spectrogram(output_m(1:length(y_m)),100,95,[],Fs,'yaxis')
title 'Output Male "Had"'
pause;
plot(output_m(1:length(y_m)))
pause;
close all;
t_m = (1:size(y_m))/Fs;
plot(t_m,y_m,t_m,output_m(1:length(y_m)),'--')
title 'Male "Had" Original Signal vs. LPC Estimate'
xlabel 'Time (ms)', ylabel 'Amplitude'
legend('Original signal','LPC estimate')
pause;

erorr_m = y_m-(output_m(1:length(y_m)))';
[C_m,lags_m] = xcorr(erorr_m,'coeff');
plot(lags_m,C_m), grid
title 'Male "Had" Autocorrelation of the Prediction Error'
xlabel 'Lags', ylabel 'Normalized value'
pause;

[f_Y_m,P1_Y_m,f_S_m,P1_S_m] = amplitude_spectrum(y_m,Fs,output_m,g);
pause;
close all;