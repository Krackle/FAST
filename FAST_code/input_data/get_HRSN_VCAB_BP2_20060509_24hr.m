function [t, x, Fs] = get_HRSN_VCAB_BP2_20060509_24hr()

% Read in data from HRSN, station VCAB, channel BP2, 20060509, 24 hr
% Band pass 2-8 Hz
path(path,'./MatSAC');
[t, x, SAChdr] = fget_sac('../data/hrsn/2006.129.00.00.00.0090.BP.VCAB..BP2.Q.SAC.bp2to8');
Fs = round(1.0 / SAChdr.times.delta); % sampling rate

% Pad by one element
t = [t; t(end)+SAChdr.times.delta];
x = [x; 0];

end
