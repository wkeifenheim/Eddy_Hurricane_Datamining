%Script for generating northern/souther hemisphere plots
disp_25 = prctile(IBTr_eddies.Displacement_d1(:),25);
disp_50 = prctile(IBTr_eddies.Displacement_d1(:),50);
disp_75 = prctile(IBTr_eddies.Displacement_d1(:),75);
disp_100 = max(IBTr_eddies.Displacement_d1(:));

disp_25_idx = IBTrACS_1992_2010.Displacement_d1(:) < disp_25;
disp_50_idx = bitand(IBTrACS_1992_2010.Displacement_d1(:) >= disp_25,...
    IBTrACS_1992_2010.Displacement_d1(:) < disp_50);
disp_75_idx = bitand(IBTrACS_1992_2010.Displacement_d1(:) >= disp_50,...
    IBTrACS_1992_2010.Displacement_d1(:) < disp_75);
disp_100_idx = bitand(IBTrACS_1992_2010.Displacement_d1(:) >= disp_75,...
    IBTrACS_1992_2010.Displacement_d1(:) <= disp_100);

subset_idx = disp_25_idx;
cyc_n_idx = bitand(bitand(bitand(IBTrACS_1992_2010.EddyClass(:) == -1, IBTrACS_1992_2010.Latitude_for_mapping(:) > 0),...
    subset_idx),IBTrACS_1992_2010.one_only(:));
acyc_n_idx = bitand(bitand(bitand(IBTrACS_1992_2010.EddyClass(:) == 1, IBTrACS_1992_2010.Latitude_for_mapping(:) > 0),...
    subset_idx),IBTrACS_1992_2010.one_only(:));
acyc_s_idx = bitand(bitand(bitand(IBTrACS_1992_2010.EddyClass(:) == 1, IBTrACS_1992_2010.Latitude_for_mapping(:) < 0),...
    subset_idx),IBTrACS_1992_2010.one_only(:));
cyc_s_idx = bitand(bitand(bitand(IBTrACS_1992_2010.EddyClass(:) == -1, IBTrACS_1992_2010.Latitude_for_mapping(:) < 0),...
    subset_idx),IBTrACS_1992_2010.one_only(:));

lower_bound = 25;
upper_bound = 50;
bound_idx = bitand(pass_dist_25.Pass_dist(:) > lower_bound,...
    pass_dist_25.Pass_dist(:) <= upper_bound);
outside_idx = bitand(bitand(~bound_idx,~isnan(pass_dist_25.Pass(:))), pass_dist_25.Pass_dist(:) > 50);
inside_idx = bitand(bitand(~bound_idx,~isnan(pass_dist_25.Pass(:))), pass_dist_25.Pass_dist(:) <= 25);

%further subset north/south - cyc/acyc indices...
sub = bound_idx;
cyc_n_idx = bitand(cyc_n_idx,sub);
acyc_n_idx = bitand(acyc_n_idx,sub);
cyc_s_idx = bitand(cyc_s_idx,sub);
acyc_s_idx = bitand(acyc_s_idx,sub);


figure;
set(gcf,'Name','Subset of 0-25th percentile of hurricane translation speed');
subplot(2,1,1);
cyc_n_res = results(cyc_n_idx);
acyc_n_res = results(acyc_n_idx);
cyc_n_hist = histc(cyc_n_res,[-1 1]);
acyc_n_hist = histc(acyc_n_res, [-1 1]);
n_tots = [cyc_n_hist, acyc_n_hist];
bar([-1 1],n_tots,'histc')
%legend('cyclonic','anticyclonic', 'Location','North')
%xlabel('<-Left Passes || Center Passes || Right Passes ->')
ylabel('Count')
title('Northern Hemisphere | 25km-50km threshold')

subplot(2,1,2);
cyc_s_res = results(cyc_s_idx);
acyc_s_res = results(acyc_s_idx);
cyc_s_hist = histc(cyc_s_res,[-1 1]);
acyc_s_hist = histc(acyc_s_res, [-1 1]);
s_tots = [cyc_s_hist, acyc_s_hist];
bar([-1 1],s_tots,'histc')
%legend('cyclonic','anticyclonic', 'Location','North')
xlabel('<-Left Passes || Center Passes || Right Passes ->')
ylabel('Count')
title('Southern Hemisphere | 25km-50km threshold')