% Script for generating northern/souther hemisphere plots


% cyc_n_idx = bitand(IBTrACS_1992_2010.EddyClass(:) == -1, IBTrACS_1992_2010.Latitude_for_mapping(:) > 0);
% acyc_n_idx = bitand(IBTrACS_1992_2010.EddyClass(:) == 1, IBTrACS_1992_2010.Latitude_for_mapping(:) > 0);
% acyc_s_idx = bitand(IBTrACS_1992_2010.EddyClass(:) == 1, IBTrACS_1992_2010.Latitude_for_mapping(:) < 0);
% cyc_s_idx = bitand(IBTrACS_1992_2010.EddyClass(:) == -1, IBTrACS_1992_2010.Latitude_for_mapping(:) < 0);


figure;
subplot(2,1,1);
cyc_n_res = results(cyc_n_idx);
acyc_n_res = results(acyc_n_idx);
cyc_n_hist = histc(cyc_n_res,[-1 0 1]);
acyc_n_hist = histc(acyc_n_res, [-1 0 1]);
n_tots = [cyc_n_hist, acyc_n_hist];
bar([-1 0 1],n_tots,'histc')
legend('cyclonic','anticyclonic', 'Location','North')
%xlabel('<-Left Passes || Center Passes || Right Passes ->')
ylabel('Count')
title('Northern Hemisphere | 50km threshold')

subplot(2,1,2);
cyc_s_res = results(cyc_s_idx);
acyc_s_res = results(acyc_s_idx);
cyc_s_hist = histc(cyc_s_res,[-1 0 1]);
acyc_s_hist = histc(acyc_s_res, [-1 0 1]);
s_tots = [cyc_s_hist, acyc_s_hist];
bar([-1 0 1],s_tots,'histc')
legend('cyclonic','anticyclonic', 'Location','North')
xlabel('<-Left Passes || Center Passes || Right Passes ->')
ylabel('Count')
title('Southern Hemisphere | 50km threshold')