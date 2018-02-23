function [synthesis,noise_out,impulse] = synthesise_sound(mean_f0,lpc_coefficients,Fs,y,attack_decay)

% By calculating the pitch, the impulse train can be calculated. The number
% generated will be the amount of 0 between the impulses - 1
pitch_sample_time = 1/mean_f0;
no_samples_impulse = round(pitch_sample_time * Fs);

% Re-calculates some variables to be used in the rest of the function
ly = length(y);
impulse = zeros(1,round((ly/no_samples_impulse)*no_samples_impulse*1.2));
if (attack_decay == 0)
    impulse(1:no_samples_impulse:end) = 1;
else
    k = 1;
    asdl_amount = round(ly/no_samples_impulse)*2;
    asdl_start = 0:0.25:1;
    asdl_end = 1:-0.25:0;
    asdl_mid = ones(1,asdl_amount-(length(asdl_start)*2));
    asdl = [asdl_start,asdl_mid,asdl_end];
    for i=1:asdl_amount
       impulse(k) = asdl(i);
       k = k+no_samples_impulse-1;
    end
end

% This is to create gaussian white noise
y1 = wgn(round(ly*1.5),1,0);

% Filter the LPC coefficients with the impulse train in order to generate a
% synthesis of the sampled data. This is also normalised
synthesis = filter(1,lpc_coefficients,impulse);
synthesis = synthesis/max(abs(synthesis));

% The same procedure as above but this time using noise as our source
% instead of an impulse train.
noise_out = filter(1,lpc_coefficients,y1);
noise_out = noise_out/max(abs(noise_out));