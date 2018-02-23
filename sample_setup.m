function [y_w,Fs,y] = sample_setup(file)

% Takes in the file and returns the sampled data, y, and the sampling rate
file_selected = fileSelection(file);
[y,Fs] = audioread(file_selected);

% Apply a hamming window and pre-emphasis filter to the section
y_w = y.*hamming(length(y));
preemph = [1,0.63];
y_w = filter(1,preemph,y_w);