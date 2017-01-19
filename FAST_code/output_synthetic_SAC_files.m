close all
clear

% Script to output synthetic data SAC files with different parameters

% Read in data from NCSN, station CCOB, channel EHN, 1 week, decimated 5 times
% Band pass filter 4-10 Hz
path(path,'./MatSAC');
[t_all,x_all,SAChdr] = fget_sac('../data/ncsn/1week.2011.008.00.00.00.0000.deci5.NC.CCOB..EHN.D.SAC.bp4to10');
Fs = 20;

% scale factor for signal
% amp_factor = 1.0;
% amp_factor = 0.5;
% amp_factor = 0.1;
% amp_factor = 0.05;
amp_factor = 0.04;
% amp_factor = 0.03;
% amp_factor = 0.02;
% amp_factor = 0.01;

% "noise" section: between hours 24 and 36 (low noise level)
noise_hr_start = 24;
noise_hr_end = 36;

% % "noise" section: between hours 69 and 81 (high noise level)
% noise_hr_start = 69;
% noise_hr_end = 81;


% Create synthetic data
[t, x, time_repeat, time_nonrepeat, snr_output] = generate_synthetic_data(...
    t_all, x_all, Fs, noise_hr_start, noise_hr_end, amp_factor);

% Create new SAC header
N = length(x);
dt = 1.0/Fs; % sample spacing
tstart = t(1); % start time
newhdr = newSacHeader(N,dt,tstart);

% Write combined data to SAC file
outdir = '../data/ncsn/';
outfile = strcat('synthetic.deci5.12hr.', num2str(noise_hr_start), '.', ...
    num2str(noise_hr_end), '.amp', num2str(amp_factor), ...
    '.NC.CCOB.EHN.D.SAC.bp4to10');

outputFile = strcat(outdir, '/', outfile);
wtSac(outputFile, newhdr, x);