%plot hurricane characteristic vs. eddy age on the same plot

bins = 1:10:151;
[cyc_age_hist, cyc_age_idx] = histc(IBTrACS_1992_2010_NewI.EddyTrackLength(cyc_idx),bins);
[acyc_age_hist, acyc_age_idx] = histc(IBTrACS_1992_2010_NewI.EddyTrackLength(acyc_idx),bins);

