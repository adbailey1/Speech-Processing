function [y,Fs,est_f0,start,end_sample] = get_fundamental_f0(file,g,window_length,p_factor)

% Takes in the file and returns the sampled data, y, and the sampling rate
file_selected = fileSelection(file);
[y,Fs] = audioread(file_selected);

% If the gender variable is set to 1 then the samples will be male,
% therefore set the maximum frequency threshold accordingly
if (g==1)
    freq = 200;
else
    freq = 350;
end

% Work out the length of the sample in seconds. Calculate the start and end
% points by working out the first and last quarter.
time_sample = length(y)/Fs;
half_time = time_sample/2;
start = half_time/2;
start = round(start*Fs);
window_length_sample = round(window_length*Fs);
end_sample = half_time+(half_time/2);
end_sample = round(end_sample*Fs)-window_length_sample;
end_of_loop = end_sample-start;

% Plot the sampled data in terms of time
t = 0:(1/Fs):length(y)*(1/Fs)-(1/Fs);
plot(t,y);
if (g==1)
    title('Male "Had" Amplitude per sample plot')
else
    title('Female "Had" Amplitude per sample plot')
end
xlabel('Time (ms)') % x-axis label
ylabel('Amplitude (dB)') % y-axis label
pause;

% Plot a spectrogram with a window length of 100ms and an overlap of 95%
spectrogram(y,100,95,[],Fs,'yaxis')
if (g==1)
    title('Male "Had" Spectrogram')
else
    title('Female "Had" Spectrogram')
end
pause;
close all;

% Plot an example of the sampled data y with the specified window length
example = y(start:start+window_length_sample);
t = 0:(1/Fs):length(example)*(1/Fs)-(1/Fs);
plot(t,example);
if (g==1)
    title('Male "Had" Amplitude per sample plot')
else
    title('Female "Had" Amplitude per sample plot')
end
xlabel('Time (ms)') % x-axis label
ylabel('Amplitude (dB)') % y-axis label
pause;
close all;

% Create a loop that works out the fundamental frequency at various points
% throughout the sampled data. Use Cepstrum to obtain the fundamantal
y_w = y(start:start+window_length_sample);
% Apply a hamming window and pre-emphasis filter to the section
y_w = y_w.*hamming(length(y_w));
preemph = [1,0.63];
y_w_s = filter(1,preemph,y_w);
    
cepstrum = rceps(y_w_s);
    
% Create a vector t that is of length x1 and starts at 0 and increments
% by 1/sampling frequency
dt = 1/Fs;
t = 0:dt:length(y_w_s)*dt-dt;
% Filter out any values that are not within the threshold paramenters.
% These will differ depending on the gender of the sample
time_range = t(t>=(1/freq) & t<=(1/75));
cepstrum_range = cepstrum(t>=(1/freq) & t<=(1/75));

% Calculate the peak in the cepstrum range of values, find its position
% in the time range and obtain the fundamental frequency
[~,I] = max(cepstrum_range);
est_f0 = 1/time_range(I);