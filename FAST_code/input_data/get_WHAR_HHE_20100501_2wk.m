function [t, x, Fs] = get_WHAR_HHE_20100501_2wk()

% Read in data from station WHAR, channel HHE, 20100501, last 2 weeks
path(path,'./MatSAC');
[t,x,SAChdr] = fget_sac('../data/GuyArkansas/201005_HHE_BP_1_30.SAC');
Fs = 100;

% Filter data 1-20 Hz, normalize (from Yihe's scripts)
[x] = filter_taper_guy_data(x, Fs);

end
