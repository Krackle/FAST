function [t, x, Fs] = get_HRSN_JCSB_BP3_20071026_24hr()

% Read in data from HRSN, station JCSB, channel BP3, 20071026, 24 hr
% Band pass 2-8 Hz
path(path,'./MatSAC');
[t, x, SAChdr] = fget_sac('../data/hrsn/2007.299.00.00.00.0078.BP.JCSB..BP3.Q.SAC.bp2to8');
Fs = round(1.0 / SAChdr.times.delta); % sampling rate

end
