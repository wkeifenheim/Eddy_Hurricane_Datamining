%% DAILY plot figures of eddy characteristic segmented by hurricane displacement

load('/panfs/roc/groups/6/kumarv/keifenhe/Documents/Datasets/IBTrACS_1992_2010_bu_all_working.mat')


disp_25 = prctile(IBTrACS_1992_2010.Displacement_d1(~isnan(IBTrACS_1992_2010.EddyClass(:))),25);
disp_50 = prctile(IBTrACS_1992_2010.Displacement_d1(~isnan(IBTrACS_1992_2010.EddyClass(:))),50);
disp_75 = prctile(IBTrACS_1992_2010.Displacement_d1(~isnan(IBTrACS_1992_2010.EddyClass(:))),75);
disp_100 = max(IBTrACS_1992_2010.Displacement_d1(~isnan(IBTrACS_1992_2010.EddyClass(:))));

disp_25_idx = bitand(IBTrACS_1992_2010.Displacement_d1(:) <= disp_25, ~isnan(IBTrACS_1992_2010.EddyClass(:)));
disp_50_idx = bitand(bitand(IBTrACS_1992_2010.Displacement_d1(:) > disp_25,...
    IBTrACS_1992_2010.Displacement_d1(:) <= disp_50), ~isnan(IBTrACS_1992_2010.EddyClass(:)));
disp_75_idx = bitand(bitand(IBTrACS_1992_2010.Displacement_d1(:) > disp_50,...
    IBTrACS_1992_2010.Displacement_d1(:) <= disp_75), ~isnan(IBTrACS_1992_2010.EddyClass(:)));
disp_100_idx = bitand(bitand(IBTrACS_1992_2010.Displacement_d1(:) > disp_75,...
    IBTrACS_1992_2010.Displacement_d1(:) <= disp_100), ~isnan(IBTrACS_1992_2010.EddyClass(:)));

cyc_n_idx = bitand(IBTrACS_1992_2010.EddyClass(:) == -1, IBTrACS_1992_2010.Latitude_for_mapping(:) > 0);
acyc_n_idx = bitand(IBTrACS_1992_2010.EddyClass(:) == 1, IBTrACS_1992_2010.Latitude_for_mapping(:) > 0);
acyc_s_idx = bitand(IBTrACS_1992_2010.EddyClass(:) == 1, IBTrACS_1992_2010.Latitude_for_mapping(:) < 0);
cyc_s_idx = bitand(IBTrACS_1992_2010.EddyClass(:) == -1, IBTrACS_1992_2010.Latitude_for_mapping(:) < 0);

%% Comment/Uncomment to display left/right passes by hemisphere
% lower_bound = 25;
% upper_bound = 50;
% bound_idx = bitand(IBTrACS_1992_2010.dist_hurr_traj_eddy_center(:) > lower_bound,...
%     IBTrACS_1992_2010.dist_hurr_traj_eddy_center(:) <= upper_bound);
% outside_idx = bitand(bitand(~bound_idx,~isnan(IBTrACS_1992_2010.dist_hurr_traj_eddy_center(:))),...
%     IBTrACS_1992_2010.dist_hurr_traj_eddy_center(:) > 50);
% inside_idx = bitand(bitand(~bound_idx,~isnan(IBTrACS_1992_2010.dist_hurr_traj_eddy_center(:))),...
%     IBTrACS_1992_2010.dist_hurr_traj_eddy_center(:) <= 25);
% 
% %% further subset north/south - cyc/acyc indices by [bound_idx, outside_idx,
% %% inside_idx]
% sub = inside_idx;
% 
% %% Display 1st-25th displacement results
% subset_idx = disp_25_idx;
% cyc_n_idx = bitand(bitand(IBTrACS_1992_2010.EddyClass(:) == -1, IBTrACS_1992_2010.Latitude_for_mapping(:) > 0),...
%     subset_idx);
% acyc_n_idx = bitand(bitand(IBTrACS_1992_2010.EddyClass(:) == 1, IBTrACS_1992_2010.Latitude_for_mapping(:) > 0),...
%     subset_idx);
% acyc_s_idx = bitand(bitand(IBTrACS_1992_2010.EddyClass(:) == 1, IBTrACS_1992_2010.Latitude_for_mapping(:) < 0),...
%     subset_idx);
% cyc_s_idx = bitand(bitand(IBTrACS_1992_2010.EddyClass(:) == -1, IBTrACS_1992_2010.Latitude_for_mapping(:) < 0),...
%     subset_idx);
% 
% cyc_n_idx = bitand(cyc_n_idx,sub);
% acyc_n_idx = bitand(acyc_n_idx,sub);
% cyc_s_idx = bitand(cyc_s_idx,sub);
% acyc_s_idx = bitand(acyc_s_idx,sub);
% 
% 
% figure;
% set(gcf,'Name','Subset of 1st-25th percentile of hurricane translation speed');
% subplot(2,1,1);
% cyc_n_res = IBTrACS_1992_2010.left_center_right_pass(cyc_n_idx);
% acyc_n_res = IBTrACS_1992_2010.left_center_right_pass(acyc_n_idx);
% cyc_n_hist = histc(cyc_n_res,[-1 1]);
% acyc_n_hist = histc(acyc_n_res, [-1 1]);
% n_tots = [cyc_n_hist, acyc_n_hist];
% bar([-1 1],n_tots,'histc')
% %legend(strcat('cyclonic (mean:',num2str(c_mean),')'),...     strcat('anticyclonic (mean:',num2str(a_mean),')'), 'Location','North')
% %xlabel('<-Left Passes || Center Passes || Right Passes ->')
% ylabel('Count')
% title('Northern Hemisphere |  <= 25km threshold')
% 
% subplot(2,1,2);
% cyc_s_res = IBTrACS_1992_2010.left_center_right_pass(cyc_s_idx);
% acyc_s_res = IBTrACS_1992_2010.left_center_right_pass(acyc_s_idx);
% cyc_s_hist = histc(cyc_s_res,[-1 1]);
% acyc_s_hist = histc(acyc_s_res, [-1 1]);
% s_tots = [cyc_s_hist, acyc_s_hist];
% bar([-1 1],s_tots,'histc')
% %legend(strcat('cyclonic (mean:',num2str(c_mean),')'),...     strcat('anticyclonic (mean:',num2str(a_mean),')'), 'Location','North')
% xlabel('<-Left Passes || Center Passes || Right Passes ->')
% ylabel('Count')
% title('Southern Hemisphere |  <= 25km threshold')
% 
%% Display 26th-50th displacement results
% subset_idx = disp_50_idx;
% cyc_n_idx = bitand(bitand(IBTrACS_1992_2010.EddyClass(:) == -1, IBTrACS_1992_2010.Latitude_for_mapping(:) > 0),...
%     subset_idx);
% acyc_n_idx = bitand(bitand(IBTrACS_1992_2010.EddyClass(:) == 1, IBTrACS_1992_2010.Latitude_for_mapping(:) > 0),...
%     subset_idx);
% acyc_s_idx = bitand(bitand(IBTrACS_1992_2010.EddyClass(:) == 1, IBTrACS_1992_2010.Latitude_for_mapping(:) < 0),...
%     subset_idx);
% cyc_s_idx = bitand(bitand(IBTrACS_1992_2010.EddyClass(:) == -1, IBTrACS_1992_2010.Latitude_for_mapping(:) < 0),...
%     subset_idx);
% 
% cyc_n_idx = bitand(cyc_n_idx,sub);
% acyc_n_idx = bitand(acyc_n_idx,sub);
% cyc_s_idx = bitand(cyc_s_idx,sub);
% acyc_s_idx = bitand(acyc_s_idx,sub);
% 
% 
% figure;
% set(gcf,'Name','Subset of 26th-50th percentile of hurricane translation speed');
% subplot(2,1,1);
% cyc_n_res = IBTrACS_1992_2010.left_center_right_pass(cyc_n_idx);
% acyc_n_res = IBTrACS_1992_2010.left_center_right_pass(acyc_n_idx);
% cyc_n_hist = histc(cyc_n_res,[-1 1]);
% acyc_n_hist = histc(acyc_n_res, [-1 1]);
% n_tots = [cyc_n_hist, acyc_n_hist];
% bar([-1 1],n_tots,'histc')
% %legend(strcat('cyclonic (mean:',num2str(c_mean),')'),...     strcat('anticyclonic (mean:',num2str(a_mean),')'), 'Location','North')
% %xlabel('<-Left Passes || Center Passes || Right Passes ->')
% ylabel('Count')
% title('Northern Hemisphere |  <= 25km threshold')
% 
% subplot(2,1,2);
% cyc_s_res = IBTrACS_1992_2010.left_center_right_pass(cyc_s_idx);
% acyc_s_res = IBTrACS_1992_2010.left_center_right_pass(acyc_s_idx);
% cyc_s_hist = histc(cyc_s_res,[-1 1]);
% acyc_s_hist = histc(acyc_s_res, [-1 1]);
% s_tots = [cyc_s_hist, acyc_s_hist];
% bar([-1 1],s_tots,'histc')
% %legend(strcat('cyclonic (mean:',num2str(c_mean),')'),...     strcat('anticyclonic (mean:',num2str(a_mean),')'), 'Location','North')
% xlabel('<-Left Passes || Center Passes || Right Passes ->')
% ylabel('Count')
% title('Southern Hemisphere |  <= 25km threshold')
% 
% %% Display 51st-75th displacement results
% subset_idx = disp_75_idx;
% cyc_n_idx = bitand(bitand(IBTrACS_1992_2010.EddyClass(:) == -1, IBTrACS_1992_2010.Latitude_for_mapping(:) > 0),...
%     subset_idx);
% acyc_n_idx = bitand(bitand(IBTrACS_1992_2010.EddyClass(:) == 1, IBTrACS_1992_2010.Latitude_for_mapping(:) > 0),...
%     subset_idx);
% acyc_s_idx = bitand(bitand(IBTrACS_1992_2010.EddyClass(:) == 1, IBTrACS_1992_2010.Latitude_for_mapping(:) < 0),...
%     subset_idx);
% cyc_s_idx = bitand(bitand(IBTrACS_1992_2010.EddyClass(:) == -1, IBTrACS_1992_2010.Latitude_for_mapping(:) < 0),...
%     subset_idx);
% 
% cyc_n_idx = bitand(cyc_n_idx,sub);
% acyc_n_idx = bitand(acyc_n_idx,sub);
% cyc_s_idx = bitand(cyc_s_idx,sub);
% acyc_s_idx = bitand(acyc_s_idx,sub);
% 
% 
% figure;
% set(gcf,'Name','Subset of 51st-75th percentile of hurricane translation speed');
% subplot(2,1,1);
% cyc_n_res = IBTrACS_1992_2010.left_center_right_pass(cyc_n_idx);
% acyc_n_res = IBTrACS_1992_2010.left_center_right_pass(acyc_n_idx);
% cyc_n_hist = histc(cyc_n_res,[-1 1]);
% acyc_n_hist = histc(acyc_n_res, [-1 1]);
% n_tots = [cyc_n_hist, acyc_n_hist];
% bar([-1 1],n_tots,'histc')
% %legend(strcat('cyclonic (mean:',num2str(c_mean),')'),...     strcat('anticyclonic (mean:',num2str(a_mean),')'), 'Location','North')
% %xlabel('<-Left Passes || Center Passes || Right Passes ->')
% ylabel('Count')
% title('Northern Hemisphere |  <= 25km threshold')
% 
% subplot(2,1,2);
% cyc_s_res = IBTrACS_1992_2010.left_center_right_pass(cyc_s_idx);
% acyc_s_res = IBTrACS_1992_2010.left_center_right_pass(acyc_s_idx);
% cyc_s_hist = histc(cyc_s_res,[-1 1]);
% acyc_s_hist = histc(acyc_s_res, [-1 1]);
% s_tots = [cyc_s_hist, acyc_s_hist];
% bar([-1 1],s_tots,'histc')
% %legend(strcat('cyclonic (mean:',num2str(c_mean),')'),...     strcat('anticyclonic (mean:',num2str(a_mean),')'), 'Location','North')
% xlabel('<-Left Passes || Center Passes || Right Passes ->')
% ylabel('Count')
% title('Southern Hemisphere |  <= 25km threshold')
% 
% %% Display 76th-100th displacement results
% subset_idx = disp_100_idx;
% cyc_n_idx = bitand(bitand(IBTrACS_1992_2010.EddyClass(:) == -1, IBTrACS_1992_2010.Latitude_for_mapping(:) > 0),...
%     subset_idx);
% acyc_n_idx = bitand(bitand(IBTrACS_1992_2010.EddyClass(:) == 1, IBTrACS_1992_2010.Latitude_for_mapping(:) > 0),...
%     subset_idx);
% acyc_s_idx = bitand(bitand(IBTrACS_1992_2010.EddyClass(:) == 1, IBTrACS_1992_2010.Latitude_for_mapping(:) < 0),...
%     subset_idx);
% cyc_s_idx = bitand(bitand(IBTrACS_1992_2010.EddyClass(:) == -1, IBTrACS_1992_2010.Latitude_for_mapping(:) < 0),...
%     subset_idx);
% 
% cyc_n_idx = bitand(cyc_n_idx,sub);
% acyc_n_idx = bitand(acyc_n_idx,sub);
% cyc_s_idx = bitand(cyc_s_idx,sub);
% acyc_s_idx = bitand(acyc_s_idx,sub);
% 
% 
% figure;
% set(gcf,'Name','Subset of 76th-100th percentile of hurricane translation speed');
% subplot(2,1,1);
% cyc_n_res = IBTrACS_1992_2010.left_center_right_pass(cyc_n_idx);
% acyc_n_res = IBTrACS_1992_2010.left_center_right_pass(acyc_n_idx);
% cyc_n_hist = histc(cyc_n_res,[-1 1]);
% acyc_n_hist = histc(acyc_n_res, [-1 1]);
% n_tots = [cyc_n_hist, acyc_n_hist];
% bar([-1 1],n_tots,'histc')
% %legend(strcat('cyclonic (mean:',num2str(c_mean),')'),...     strcat('anticyclonic (mean:',num2str(a_mean),')'), 'Location','North')
% %xlabel('<-Left Passes || Center Passes || Right Passes ->')
% ylabel('Count')
% title('Northern Hemisphere |  <= 25km threshold')
% 
% subplot(2,1,2);
% cyc_s_res = IBTrACS_1992_2010.left_center_right_pass(cyc_s_idx);
% acyc_s_res = IBTrACS_1992_2010.left_center_right_pass(acyc_s_idx);
% cyc_s_hist = histc(cyc_s_res,[-1 1]);
% acyc_s_hist = histc(acyc_s_res, [-1 1]);
% s_tots = [cyc_s_hist, acyc_s_hist];
% bar([-1 1],s_tots,'histc')
% %legend(strcat('cyclonic (mean:',num2str(c_mean),')'),...     strcat('anticyclonic (mean:',num2str(a_mean),')'), 'Location','North')
% xlabel('<-Left Passes || Center Passes || Right Passes ->')
% ylabel('Count')
% title('Southern Hemisphere |  <= 25km threshold')

%% Plot eddy age by cyc/acyc and by hurricane displacement
% cyc_n_idx = bitand(IBTrACS_1992_2010.EddyClass(:) == -1, IBTrACS_1992_2010.Latitude_for_mapping(:) > 0);
% acyc_n_idx = bitand(IBTrACS_1992_2010.EddyClass(:) == 1, IBTrACS_1992_2010.Latitude_for_mapping(:) > 0);
% acyc_s_idx = bitand(IBTrACS_1992_2010.EddyClass(:) == 1, IBTrACS_1992_2010.Latitude_for_mapping(:) < 0);
% cyc_s_idx = bitand(IBTrACS_1992_2010.EddyClass(:) == -1, IBTrACS_1992_2010.Latitude_for_mapping(:) < 0);

a = min(IBTrACS_1992_2010.EddyAge);
b = prctile(IBTrACS_1992_2010.EddyAge, 99);
bins = (a:1:b);
%% 1st-25th displacements
cyc_n = bitand(cyc_n_idx, disp_25_idx);
acyc_n = bitand(acyc_n_idx, disp_25_idx);
cyc_s = bitand(cyc_s_idx, disp_25_idx);
acyc_s = bitand(acyc_s_idx, disp_25_idx);

%remove outliers > b
cyc_n = bitand(cyc_n,IBTrACS_1992_2010.EddyAge < b);
acyc_n = bitand(acyc_n,IBTrACS_1992_2010.EddyAge < b);
cyc_s = bitand(cyc_s, IBTrACS_1992_2010.EddyAge < b);
acyc_s = bitand(acyc_s, IBTrACS_1992_2010.EddyAge < b);

f(1) = figure;
set(gcf,'Name','Subset of 1st-25th percentile of hurricane translation speed');
subplot(2,1,1);
cyc_n_res = IBTrACS_1992_2010.EddyAge(cyc_n);
acyc_n_res = IBTrACS_1992_2010.EddyAge(acyc_n);
c_mean = nanmean(cyc_n_res);
a_mean = nanmean(acyc_n_res);
cyc_n_hist = histc(cyc_n_res,bins);
acyc_n_hist = histc(acyc_n_res, bins);
% n_tots = [cyc_n_hist, acyc_n_hist];
plot(bins, cyc_n_hist)
hold on
plot(bins, acyc_n_hist, 'r')
legend(strcat('cyclonic (mean:',num2str(c_mean),')'),...
    strcat('anticyclonic (mean:',num2str(a_mean),')'), 'Location','North')
xlabel('Eddy Age (weeks)')
ylabel('Count')
title('Northern Hemisphere')

subplot(2,1,2);
cyc_s_res = IBTrACS_1992_2010.EddyAge(cyc_s);
acyc_s_res = IBTrACS_1992_2010.EddyAge(acyc_s);
c_mean = nanmean(cyc_s_res);
a_mean = nanmean(acyc_s_res);
cyc_s_hist = histc(cyc_s_res,bins);
acyc_s_hist = histc(acyc_s_res, bins);
% s_tots = [cyc_s_hist, acyc_s_hist];
plot(bins, cyc_s_hist)
hold on
plot(bins, acyc_s_hist, 'r')
legend(strcat('cyclonic (mean:',num2str(c_mean),')'),...
    strcat('anticyclonic (mean:',num2str(a_mean),')'), 'Location','North')
xlabel('Eddy Age (weeks)')
ylabel('Count')
title('Southern Hemisphere')
saveas(f(1),strcat('eddy_','age','_25.eps'),'epsc');

%% 26th-50th displacements
cyc_n = bitand(cyc_n_idx, disp_50_idx);
acyc_n = bitand(acyc_n_idx, disp_50_idx);
cyc_s = bitand(cyc_s_idx, disp_50_idx);
acyc_s = bitand(acyc_s_idx, disp_50_idx);

%remove outliers > b
cyc_n = bitand(cyc_n,IBTrACS_1992_2010.EddyAge < b);
acyc_n = bitand(acyc_n,IBTrACS_1992_2010.EddyAge < b);
cyc_s = bitand(cyc_s, IBTrACS_1992_2010.EddyAge < b);
acyc_s = bitand(acyc_s, IBTrACS_1992_2010.EddyAge < b);

f(2) = figure;
set(gcf,'Name','Subset of 26th-50th percentile of hurricane translation speed');
subplot(2,1,1);
cyc_n_res = IBTrACS_1992_2010.EddyAge(cyc_n);
acyc_n_res = IBTrACS_1992_2010.EddyAge(acyc_n);
c_mean = nanmean(cyc_n_res);
a_mean = nanmean(acyc_n_res);
cyc_n_hist = histc(cyc_n_res,bins);
acyc_n_hist = histc(acyc_n_res, bins);
% n_tots = [cyc_n_hist, acyc_n_hist];
plot(bins, cyc_n_hist)
hold on
plot(bins, acyc_n_hist, 'r')
legend(strcat('cyclonic (mean:',num2str(c_mean),')'),...
    strcat('anticyclonic (mean:',num2str(a_mean),')'), 'Location','North')
xlabel('Eddy Age (weeks)')
ylabel('Count')
title('Northern Hemisphere')

subplot(2,1,2);
cyc_s_res = IBTrACS_1992_2010.EddyAge(cyc_s);
acyc_s_res = IBTrACS_1992_2010.EddyAge(acyc_s);
c_mean = nanmean(cyc_s_res);
a_mean = nanmean(acyc_s_res);
cyc_s_hist = histc(cyc_s_res,bins);
acyc_s_hist = histc(acyc_s_res, bins);
% s_tots = [cyc_s_hist, acyc_s_hist];
plot(bins, cyc_s_hist)
hold on
plot(bins, acyc_s_hist, 'r')
legend(strcat('cyclonic (mean:',num2str(c_mean),')'),...
    strcat('anticyclonic (mean:',num2str(a_mean),')'), 'Location','North')
xlabel('Eddy Age (weeks)')
ylabel('Count')
title('Southern Hemisphere')
saveas(f(2),strcat('eddy_','age','_50.eps'),'epsc');

%% 51st-75th displacements
cyc_n = bitand(cyc_n_idx, disp_75_idx);
acyc_n = bitand(acyc_n_idx, disp_75_idx);
cyc_s = bitand(cyc_s_idx, disp_75_idx);
acyc_s = bitand(acyc_s_idx, disp_75_idx);

%remove outliers > b
cyc_n = bitand(cyc_n,IBTrACS_1992_2010.EddyAge < b);
acyc_n = bitand(acyc_n,IBTrACS_1992_2010.EddyAge < b);
cyc_s = bitand(cyc_s, IBTrACS_1992_2010.EddyAge < b);
acyc_s = bitand(acyc_s, IBTrACS_1992_2010.EddyAge < b);

f(3) = figure;
set(gcf,'Name','Subset of 51st-75th percentile of hurricane translation speed');
subplot(2,1,1);
cyc_n_res = IBTrACS_1992_2010.EddyAge(cyc_n);
acyc_n_res = IBTrACS_1992_2010.EddyAge(acyc_n);
c_mean = nanmean(cyc_n_res);
a_mean = nanmean(acyc_n_res);
cyc_n_hist = histc(cyc_n_res,bins);
acyc_n_hist = histc(acyc_n_res, bins);
% n_tots = [cyc_n_hist, acyc_n_hist];
plot(bins, cyc_n_hist)
hold on
plot(bins, acyc_n_hist, 'r')
legend(strcat('cyclonic (mean:',num2str(c_mean),')'),...
    strcat('anticyclonic (mean:',num2str(a_mean),')'), 'Location','North')
xlabel('Eddy Age (weeks)')
ylabel('Count')
title('Northern Hemisphere')

subplot(2,1,2);
cyc_s_res = IBTrACS_1992_2010.EddyAge(cyc_s);
acyc_s_res = IBTrACS_1992_2010.EddyAge(acyc_s);
c_mean = nanmean(cyc_s_res);
a_mean = nanmean(acyc_s_res);
cyc_s_hist = histc(cyc_s_res,bins);
acyc_s_hist = histc(acyc_s_res, bins);
% s_tots = [cyc_s_hist, acyc_s_hist];
plot(bins, cyc_s_hist)
hold on
plot(bins, acyc_s_hist, 'r')
legend(strcat('cyclonic (mean:',num2str(c_mean),')'),...
    strcat('anticyclonic (mean:',num2str(a_mean),')'), 'Location','North')
xlabel('Eddy Age (weeks)')
ylabel('Count')
title('Southern Hemisphere')
saveas(f(3),strcat('eddy_','age','_75.eps'),'epsc');

%% 76th-100th displacements
cyc_n = bitand(cyc_n_idx, disp_100_idx);
acyc_n = bitand(acyc_n_idx, disp_100_idx);
cyc_s = bitand(cyc_s_idx, disp_100_idx);
acyc_s = bitand(acyc_s_idx, disp_100_idx);

%remove outliers > b
cyc_n = bitand(cyc_n,IBTrACS_1992_2010.EddyAge < b);
acyc_n = bitand(acyc_n,IBTrACS_1992_2010.EddyAge < b);
cyc_s = bitand(cyc_s, IBTrACS_1992_2010.EddyAge < b);
acyc_s = bitand(acyc_s, IBTrACS_1992_2010.EddyAge < b);

f(4) = figure;
set(gcf,'Name','Subset of 76th-100th percentile of hurricane translation speed');
subplot(2,1,1);
cyc_n_res = IBTrACS_1992_2010.EddyAge(cyc_n);
acyc_n_res = IBTrACS_1992_2010.EddyAge(acyc_n);
c_mean = nanmean(cyc_n_res);
a_mean = nanmean(acyc_n_res);
cyc_n_hist = histc(cyc_n_res,bins);
acyc_n_hist = histc(acyc_n_res, bins);
% n_tots = [cyc_n_hist, acyc_n_hist];
plot(bins, cyc_n_hist)
hold on
plot(bins, acyc_n_hist, 'r')
legend(strcat('cyclonic (mean:',num2str(c_mean),')'),...
    strcat('anticyclonic (mean:',num2str(a_mean),')'), 'Location','North')
xlabel('Eddy Age (weeks)')
ylabel('Count')
title('Northern Hemisphere')

subplot(2,1,2);
cyc_s_res = IBTrACS_1992_2010.EddyAge(cyc_s);
acyc_s_res = IBTrACS_1992_2010.EddyAge(acyc_s);
c_mean = nanmean(cyc_s_res);
a_mean = nanmean(acyc_s_res);
cyc_s_hist = histc(cyc_s_res,bins);
acyc_s_hist = histc(acyc_s_res, bins);
% s_tots = [cyc_s_hist, acyc_s_hist];
plot(bins, cyc_s_hist)
hold on
plot(bins, acyc_s_hist, 'r')
legend(strcat('cyclonic (mean:',num2str(c_mean),')'),...
    strcat('anticyclonic (mean:',num2str(a_mean),')'), 'Location','North')
xlabel('Eddy Age (weeks)')
ylabel('Count')
title('Southern Hemisphere')
saveas(f(4),strcat('eddy_','age','_100.eps'),'epsc');

%% Plot eddy lifetime by cyc/acyc and by hurricane displacement
% cyc_n_idx = bitand(IBTrACS_1992_2010.EddyClass(:) == -1, IBTrACS_1992_2010.Latitude_for_mapping(:) > 0);
% acyc_n_idx = bitand(IBTrACS_1992_2010.EddyClass(:) == 1, IBTrACS_1992_2010.Latitude_for_mapping(:) > 0);
% acyc_s_idx = bitand(IBTrACS_1992_2010.EddyClass(:) == 1, IBTrACS_1992_2010.Latitude_for_mapping(:) < 0);
% cyc_s_idx = bitand(IBTrACS_1992_2010.EddyClass(:) == -1, IBTrACS_1992_2010.Latitude_for_mapping(:) < 0);

a = min(IBTrACS_1992_2010.EddyTrackLength);
b = prctile(IBTrACS_1992_2010.EddyTrackLength,99);
bins = (a:1:b);
%% 1st-25th displacements
cyc_n = bitand(cyc_n_idx, disp_25_idx);
acyc_n = bitand(acyc_n_idx, disp_25_idx);
cyc_s = bitand(cyc_s_idx, disp_25_idx);
acyc_s = bitand(acyc_s_idx, disp_25_idx);

%remove outliers > b
cyc_n = bitand(cyc_n,IBTrACS_1992_2010.EddyTrackLength < b);
acyc_n = bitand(acyc_n,IBTrACS_1992_2010.EddyTrackLength < b);
cyc_s = bitand(cyc_s, IBTrACS_1992_2010.EddyTrackLength < b);
acyc_s = bitand(acyc_s, IBTrACS_1992_2010.EddyTrackLength < b);

f(5) = figure;
set(gcf,'Name','Subset of 1st-25th percentile of hurricane translation speed');
subplot(2,1,1);
cyc_n_res = IBTrACS_1992_2010.EddyTrackLength(cyc_n);
acyc_n_res = IBTrACS_1992_2010.EddyTrackLength(acyc_n);
c_mean = nanmean(cyc_n_res);
a_mean = nanmean(acyc_n_res);
cyc_n_hist = histc(cyc_n_res,bins);
acyc_n_hist = histc(acyc_n_res, bins);
% n_tots = [cyc_n_hist, acyc_n_hist];
plot(bins, cyc_n_hist)
hold on
plot(bins, acyc_n_hist, 'r')
legend(strcat('cyclonic (mean:',num2str(c_mean),')'),...
    strcat('anticyclonic (mean:',num2str(a_mean),')'), 'Location','North')
xlabel('Eddy Lifetime (weeks)')
ylabel('Count')
title('Northern Hemisphere')

subplot(2,1,2);
cyc_s_res = IBTrACS_1992_2010.EddyTrackLength(cyc_s);
acyc_s_res = IBTrACS_1992_2010.EddyTrackLength(acyc_s);
c_mean = nanmean(cyc_s_res);
a_mean = nanmean(acyc_s_res);
cyc_s_hist = histc(cyc_s_res,bins);
acyc_s_hist = histc(acyc_s_res, bins);
% s_tots = [cyc_s_hist, acyc_s_hist];
plot(bins, cyc_s_hist)
hold on
plot(bins, acyc_s_hist, 'r')
legend(strcat('cyclonic (mean:',num2str(c_mean),')'),...
    strcat('anticyclonic (mean:',num2str(a_mean),')'), 'Location','North')
xlabel('Eddy Lifetime (weeks)')
ylabel('Count')
title('Southern Hemisphere')
saveas(f(5),strcat('eddy_','lifetime','_25.eps'),'epsc');

%% 26th-50th displacements
cyc_n = bitand(cyc_n_idx, disp_50_idx);
acyc_n = bitand(acyc_n_idx, disp_50_idx);
cyc_s = bitand(cyc_s_idx, disp_50_idx);
acyc_s = bitand(acyc_s_idx, disp_50_idx);

%remove outliers > b
cyc_n = bitand(cyc_n,IBTrACS_1992_2010.EddyTrackLength < b);
acyc_n = bitand(acyc_n,IBTrACS_1992_2010.EddyTrackLength < b);
cyc_s = bitand(cyc_s, IBTrACS_1992_2010.EddyTrackLength < b);
acyc_s = bitand(acyc_s, IBTrACS_1992_2010.EddyTrackLength < b);

f(6) = figure;
set(gcf,'Name','Subset of 26th-50th percentile of hurricane translation speed');
subplot(2,1,1);
cyc_n_res = IBTrACS_1992_2010.EddyTrackLength(cyc_n);
acyc_n_res = IBTrACS_1992_2010.EddyTrackLength(acyc_n);
c_mean = nanmean(cyc_n_res);
a_mean = nanmean(acyc_n_res);
cyc_n_hist = histc(cyc_n_res,bins);
acyc_n_hist = histc(acyc_n_res, bins);
% n_tots = [cyc_n_hist, acyc_n_hist];
plot(bins, cyc_n_hist)
hold on
plot(bins, acyc_n_hist, 'r')
legend(strcat('cyclonic (mean:',num2str(c_mean),')'),...
    strcat('anticyclonic (mean:',num2str(a_mean),')'), 'Location','North')
xlabel('Eddy Lifetime (weeks)')
ylabel('Count')
title('Northern Hemisphere')

subplot(2,1,2);
cyc_s_res = IBTrACS_1992_2010.EddyTrackLength(cyc_s);
acyc_s_res = IBTrACS_1992_2010.EddyTrackLength(acyc_s);
c_mean = nanmean(cyc_s_res);
a_mean = nanmean(acyc_s_res);
cyc_s_hist = histc(cyc_s_res,bins);
acyc_s_hist = histc(acyc_s_res, bins);
% s_tots = [cyc_s_hist, acyc_s_hist];
plot(bins, cyc_s_hist)
hold on
plot(bins, acyc_s_hist, 'r')
legend(strcat('cyclonic (mean:',num2str(c_mean),')'),...
    strcat('anticyclonic (mean:',num2str(a_mean),')'), 'Location','North')
xlabel('Eddy Lifetime (weeks)')
ylabel('Count')
title('Southern Hemisphere')
saveas(f(6),strcat('eddy_','lifetime','_50.eps'),'epsc');

%% 51st-75th displacements
cyc_n = bitand(cyc_n_idx, disp_75_idx);
acyc_n = bitand(acyc_n_idx, disp_75_idx);
cyc_s = bitand(cyc_s_idx, disp_75_idx);
acyc_s = bitand(acyc_s_idx, disp_75_idx);

%remove outliers > b
cyc_n = bitand(cyc_n,IBTrACS_1992_2010.EddyTrackLength < b);
acyc_n = bitand(acyc_n,IBTrACS_1992_2010.EddyTrackLength < b);
cyc_s = bitand(cyc_s, IBTrACS_1992_2010.EddyTrackLength < b);
acyc_s = bitand(acyc_s, IBTrACS_1992_2010.EddyTrackLength < b);

f(7) = figure;
set(gcf,'Name','Subset of 51st-75th percentile of hurricane translation speed');
subplot(2,1,1);
cyc_n_res = IBTrACS_1992_2010.EddyTrackLength(cyc_n);
acyc_n_res = IBTrACS_1992_2010.EddyTrackLength(acyc_n);
c_mean = nanmean(cyc_n_res);
a_mean = nanmean(acyc_n_res);
cyc_n_hist = histc(cyc_n_res,bins);
acyc_n_hist = histc(acyc_n_res, bins);
% n_tots = [cyc_n_hist, acyc_n_hist];
plot(bins, cyc_n_hist)
hold on
plot(bins, acyc_n_hist, 'r')
legend(strcat('cyclonic (mean:',num2str(c_mean),')'),...
    strcat('anticyclonic (mean:',num2str(a_mean),')'), 'Location','North')
xlabel('Eddy Lifetime (weeks)')
ylabel('Count')
title('Northern Hemisphere')

subplot(2,1,2);
cyc_s_res = IBTrACS_1992_2010.EddyTrackLength(cyc_s);
acyc_s_res = IBTrACS_1992_2010.EddyTrackLength(acyc_s);
c_mean = nanmean(cyc_s_res);
a_mean = nanmean(acyc_s_res);
cyc_s_hist = histc(cyc_s_res,bins);
acyc_s_hist = histc(acyc_s_res, bins);
% s_tots = [cyc_s_hist, acyc_s_hist];
plot(bins, cyc_s_hist)
hold on
plot(bins, acyc_s_hist, 'r')
legend(strcat('cyclonic (mean:',num2str(c_mean),')'),...
    strcat('anticyclonic (mean:',num2str(a_mean),')'), 'Location','North')
xlabel('Eddy Lifetime (weeks)')
ylabel('Count')
title('Southern Hemisphere')
saveas(f(7),strcat('eddy_','lifetime','_75.eps'),'epsc');

%% 76th-100th displacements
cyc_n = bitand(cyc_n_idx, disp_100_idx);
acyc_n = bitand(acyc_n_idx, disp_100_idx);
cyc_s = bitand(cyc_s_idx, disp_100_idx);
acyc_s = bitand(acyc_s_idx, disp_100_idx);

%remove outliers > b
cyc_n = bitand(cyc_n,IBTrACS_1992_2010.EddyTrackLength < b);
acyc_n = bitand(acyc_n,IBTrACS_1992_2010.EddyTrackLength < b);
cyc_s = bitand(cyc_s, IBTrACS_1992_2010.EddyTrackLength < b);
acyc_s = bitand(acyc_s, IBTrACS_1992_2010.EddyTrackLength < b);

f(8) = figure;
set(gcf,'Name','Subset of 76th-100th percentile of hurricane translation speed');
subplot(2,1,1);
cyc_n_res = IBTrACS_1992_2010.EddyTrackLength(cyc_n);
acyc_n_res = IBTrACS_1992_2010.EddyTrackLength(acyc_n);
c_mean = nanmean(cyc_n_res);
a_mean = nanmean(acyc_n_res);
cyc_n_hist = histc(cyc_n_res,bins);
acyc_n_hist = histc(acyc_n_res, bins);
n_tots = [cyc_n_hist, acyc_n_hist];
plot(bins, cyc_n_hist)
hold on
plot(bins, acyc_n_hist, 'r')
legend(strcat('cyclonic (mean:',num2str(c_mean),')'),...
    strcat('anticyclonic (mean:',num2str(a_mean),')'), 'Location','North')
xlabel('Eddy Lifetime (weeks)')
ylabel('Count')
title('Northern Hemisphere')

subplot(2,1,2);
cyc_s_res = IBTrACS_1992_2010.EddyTrackLength(cyc_s);
acyc_s_res = IBTrACS_1992_2010.EddyTrackLength(acyc_s);
c_mean = nanmean(cyc_s_res);
a_mean = nanmean(acyc_s_res);
cyc_s_hist = histc(cyc_s_res,bins);
acyc_s_hist = histc(acyc_s_res, bins);
s_tots = [cyc_s_hist, acyc_s_hist];
plot(bins, cyc_s_hist)
hold on
plot(bins, acyc_s_hist, 'r')
legend(strcat('cyclonic (mean:',num2str(c_mean),')'),...
    strcat('anticyclonic (mean:',num2str(a_mean),')'), 'Location','North')
xlabel('Eddy Lifetime (weeks)')
ylabel('Count')
title('Southern Hemisphere')
saveas(f(8),strcat('eddy_','lifetime','_100.eps'),'epsc');

%% Plot eddy amplitude by cyc/acyc and by hurricane displacement
% cyc_n_idx = bitand(IBTrACS_1992_2010.EddyClass(:) == -1, IBTrACS_1992_2010.Latitude_for_mapping(:) > 0);
% acyc_n_idx = bitand(IBTrACS_1992_2010.EddyClass(:) == 1, IBTrACS_1992_2010.Latitude_for_mapping(:) > 0);
% acyc_s_idx = bitand(IBTrACS_1992_2010.EddyClass(:) == 1, IBTrACS_1992_2010.Latitude_for_mapping(:) < 0);
% cyc_s_idx = bitand(IBTrACS_1992_2010.EddyClass(:) == -1, IBTrACS_1992_2010.Latitude_for_mapping(:) < 0);

% a = min(IBTrACS_1992_2010.EddyAmp);
b = prctile(IBTrACS_1992_2010.EddyAmp,99);
bins = (1:1:b);
%% 1st-25th displacements
cyc_n = bitand(cyc_n_idx, disp_25_idx);
acyc_n = bitand(acyc_n_idx, disp_25_idx);
cyc_s = bitand(cyc_s_idx, disp_25_idx);
acyc_s = bitand(acyc_s_idx, disp_25_idx);

%remove outliers > b
cyc_n = bitand(cyc_n,IBTrACS_1992_2010.EddyAmp < b);
acyc_n = bitand(acyc_n,IBTrACS_1992_2010.EddyAmp < b);
cyc_s = bitand(cyc_s, IBTrACS_1992_2010.EddyAmp < b);
acyc_s = bitand(acyc_s, IBTrACS_1992_2010.EddyAmp < b);

f(9) = figure;
set(gcf,'Name','Subset of 1st-25th percentile of hurricane translation speed');
subplot(2,1,1);
cyc_n_res = IBTrACS_1992_2010.EddyAmp(cyc_n);
acyc_n_res = IBTrACS_1992_2010.EddyAmp(acyc_n);
c_mean = nanmean(cyc_n_res);
a_mean = nanmean(acyc_n_res);
cyc_n_hist = histc(cyc_n_res,bins);
acyc_n_hist = histc(acyc_n_res, bins);
% n_tots = [cyc_n_hist, acyc_n_hist];
plot(bins, cyc_n_hist)
hold on
plot(bins, acyc_n_hist, 'r')
legend(strcat('cyclonic (mean:',num2str(c_mean),')'),...
    strcat('anticyclonic (mean:',num2str(a_mean),')'), 'Location','North')
xlabel('Eddy Amplitude')
ylabel('Count')
title('Northern Hemisphere')

subplot(2,1,2);
cyc_s_res = IBTrACS_1992_2010.EddyAmp(cyc_s);
acyc_s_res = IBTrACS_1992_2010.EddyAmp(acyc_s);
c_mean = nanmean(cyc_s_res);
a_mean = nanmean(acyc_s_res);
cyc_s_hist = histc(cyc_s_res,bins);
acyc_s_hist = histc(acyc_s_res, bins);
% s_tots = [cyc_s_hist, acyc_s_hist];
plot(bins, cyc_s_hist)
hold on
plot(bins, acyc_s_hist, 'r')
legend(strcat('cyclonic (mean:',num2str(c_mean),')'),...
    strcat('anticyclonic (mean:',num2str(a_mean),')'), 'Location','North')
xlabel('Eddy Amplitude')
ylabel('Count')
title('Southern Hemisphere')
saveas(f(9),strcat('eddy_','amp','_25.eps'),'epsc');

%% 26th-50th displacements
cyc_n = bitand(cyc_n_idx, disp_50_idx);
acyc_n = bitand(acyc_n_idx, disp_50_idx);
cyc_s = bitand(cyc_s_idx, disp_50_idx);
acyc_s = bitand(acyc_s_idx, disp_50_idx);

%remove outliers > b
cyc_n = bitand(cyc_n,IBTrACS_1992_2010.EddyAmp < b);
acyc_n = bitand(acyc_n,IBTrACS_1992_2010.EddyAmp < b);
cyc_s = bitand(cyc_s, IBTrACS_1992_2010.EddyAmp < b);
acyc_s = bitand(acyc_s, IBTrACS_1992_2010.EddyAmp < b);

f(10) = figure;
set(gcf,'Name','Subset of 26th-50th percentile of hurricane translation speed');
subplot(2,1,1);
cyc_n_res = IBTrACS_1992_2010.EddyAmp(cyc_n);
acyc_n_res = IBTrACS_1992_2010.EddyAmp(acyc_n);
c_mean = nanmean(cyc_n_res);
a_mean = nanmean(acyc_n_res);
cyc_n_hist = histc(cyc_n_res,bins);
acyc_n_hist = histc(acyc_n_res, bins);
% n_tots = [cyc_n_hist, acyc_n_hist];
plot(bins, cyc_n_hist)
hold on
plot(bins, acyc_n_hist, 'r')
legend(strcat('cyclonic (mean:',num2str(c_mean),')'),...
    strcat('anticyclonic (mean:',num2str(a_mean),')'), 'Location','North')
xlabel('Eddy Amplitude')
ylabel('Count')
title('Northern Hemisphere')

subplot(2,1,2);
cyc_s_res = IBTrACS_1992_2010.EddyAmp(cyc_s);
acyc_s_res = IBTrACS_1992_2010.EddyAmp(acyc_s);
c_mean = nanmean(cyc_s_res);
a_mean = nanmean(acyc_s_res);
cyc_s_hist = histc(cyc_s_res,bins);
acyc_s_hist = histc(acyc_s_res, bins);
% s_tots = [cyc_s_hist, acyc_s_hist];
plot(bins, cyc_s_hist)
hold on
plot(bins, acyc_s_hist, 'r')
legend(strcat('cyclonic (mean:',num2str(c_mean),')'),...
    strcat('anticyclonic (mean:',num2str(a_mean),')'), 'Location','North')
xlabel('Eddy Amplitude')
ylabel('Count')
title('Southern Hemisphere')
saveas(f(10),strcat('eddy_','amp','_50.eps'),'epsc');

%% 51st-75th displacements
cyc_n = bitand(cyc_n_idx, disp_75_idx);
acyc_n = bitand(acyc_n_idx, disp_75_idx);
cyc_s = bitand(cyc_s_idx, disp_75_idx);
acyc_s = bitand(acyc_s_idx, disp_75_idx);

%remove outliers > b
cyc_n = bitand(cyc_n,IBTrACS_1992_2010.EddyAmp < b);
acyc_n = bitand(acyc_n,IBTrACS_1992_2010.EddyAmp < b);
cyc_s = bitand(cyc_s, IBTrACS_1992_2010.EddyAmp < b);
acyc_s = bitand(acyc_s, IBTrACS_1992_2010.EddyAmp < b);

f(11) = figure;
set(gcf,'Name','Subset of 51st-75th percentile of hurricane translation speed');
subplot(2,1,1);
cyc_n_res = IBTrACS_1992_2010.EddyAmp(cyc_n);
acyc_n_res = IBTrACS_1992_2010.EddyAmp(acyc_n);
c_mean = nanmean(cyc_n_res);
a_mean = nanmean(acyc_n_res);
cyc_n_hist = histc(cyc_n_res,bins);
acyc_n_hist = histc(acyc_n_res, bins);
% n_tots = [cyc_n_hist, acyc_n_hist];
plot(bins, cyc_n_hist)
hold on
plot(bins, acyc_n_hist, 'r')
legend(strcat('cyclonic (mean:',num2str(c_mean),')'),...
    strcat('anticyclonic (mean:',num2str(a_mean),')'), 'Location','North')
xlabel('Eddy Amplitude')
ylabel('Count')
title('Northern Hemisphere')

subplot(2,1,2);
cyc_s_res = IBTrACS_1992_2010.EddyAmp(cyc_s);
acyc_s_res = IBTrACS_1992_2010.EddyAmp(acyc_s);
c_mean = nanmean(cyc_s_res);
a_mean = nanmean(acyc_s_res);
cyc_s_hist = histc(cyc_s_res,bins);
acyc_s_hist = histc(acyc_s_res, bins);
% s_tots = [cyc_s_hist, acyc_s_hist];
plot(bins, cyc_s_hist)
hold on
plot(bins, acyc_s_hist, 'r')
legend(strcat('cyclonic (mean:',num2str(c_mean),')'),...
    strcat('anticyclonic (mean:',num2str(a_mean),')'), 'Location','North')
xlabel('Eddy Amplitude')
ylabel('Count')
title('Southern Hemisphere')
saveas(f(11),strcat('eddy_','amp','_75.eps'),'epsc');

%% 76th-100th displacements
cyc_n = bitand(cyc_n_idx, disp_100_idx);
acyc_n = bitand(acyc_n_idx, disp_100_idx);
cyc_s = bitand(cyc_s_idx, disp_100_idx);
acyc_s = bitand(acyc_s_idx, disp_100_idx);

%remove outliers > b
cyc_n = bitand(cyc_n,IBTrACS_1992_2010.EddyAmp < b);
acyc_n = bitand(acyc_n,IBTrACS_1992_2010.EddyAmp < b);
cyc_s = bitand(cyc_s, IBTrACS_1992_2010.EddyAmp < b);
acyc_s = bitand(acyc_s, IBTrACS_1992_2010.EddyAmp < b);

f(12) = figure;
set(gcf,'Name','Subset of 76th-100th percentile of hurricane translation speed');
subplot(2,1,1);
cyc_n_res = IBTrACS_1992_2010.EddyAmp(cyc_n);
acyc_n_res = IBTrACS_1992_2010.EddyAmp(acyc_n);
c_mean = nanmean(cyc_n_res);
a_mean = nanmean(acyc_n_res);
cyc_n_hist = histc(cyc_n_res,bins);
acyc_n_hist = histc(acyc_n_res, bins);
% n_tots = [cyc_n_hist, acyc_n_hist];
plot(bins, cyc_n_hist)
hold on
plot(bins, acyc_n_hist, 'r')
legend(strcat('cyclonic (mean:',num2str(c_mean),')'),...
    strcat('anticyclonic (mean:',num2str(a_mean),')'), 'Location','North')
xlabel('Eddy Amplitude')
ylabel('Count')
title('Northern Hemisphere')

subplot(2,1,2);
cyc_s_res = IBTrACS_1992_2010.EddyAmp(cyc_s);
acyc_s_res = IBTrACS_1992_2010.EddyAmp(acyc_s);
c_mean = nanmean(cyc_s_res);
a_mean = nanmean(acyc_s_res);
cyc_s_hist = histc(cyc_s_res,bins);
acyc_s_hist = histc(acyc_s_res, bins);
% s_tots = [cyc_s_hist, acyc_s_hist];
plot(bins, cyc_s_hist)
hold on
plot(bins, acyc_s_hist, 'r')
legend(strcat('cyclonic (mean:',num2str(c_mean),')'),...
    strcat('anticyclonic (mean:',num2str(a_mean),')'), 'Location','North')
xlabel('Eddy Amplitude')
ylabel('Count')
title('Southern Hemisphere')
saveas(f(12),strcat('eddy_','amp','_100.eps'),'epsc');

%% Plot eddy geospeed by cyc/acyc and by hurricane displacement
% cyc_n_idx = bitand(IBTrACS_1992_2010.EddyClass(:) == -1, IBTrACS_1992_2010.Latitude_for_mapping(:) > 0);
% acyc_n_idx = bitand(IBTrACS_1992_2010.EddyClass(:) == 1, IBTrACS_1992_2010.Latitude_for_mapping(:) > 0);
% acyc_s_idx = bitand(IBTrACS_1992_2010.EddyClass(:) == 1, IBTrACS_1992_2010.Latitude_for_mapping(:) < 0);
% cyc_s_idx = bitand(IBTrACS_1992_2010.EddyClass(:) == -1, IBTrACS_1992_2010.Latitude_for_mapping(:) < 0);

a = min(IBTrACS_1992_2010.EddyGeoSpeed);
b = prctile(IBTrACS_1992_2010.EddyGeoSpeed,99);
bins = (a:1:b);
%% 1st-25th displacements
cyc_n = bitand(cyc_n_idx, disp_25_idx);
acyc_n = bitand(acyc_n_idx, disp_25_idx);
cyc_s = bitand(cyc_s_idx, disp_25_idx);
acyc_s = bitand(acyc_s_idx, disp_25_idx);

%remove outliers > b
cyc_n = bitand(cyc_n,IBTrACS_1992_2010.EddyGeoSpeed < b);
acyc_n = bitand(acyc_n,IBTrACS_1992_2010.EddyGeoSpeed < b);
cyc_s = bitand(cyc_s, IBTrACS_1992_2010.EddyGeoSpeed < b);
acyc_s = bitand(acyc_s, IBTrACS_1992_2010.EddyGeoSpeed < b);

f(13) = figure;
set(gcf,'Name','Subset of 1st-25th percentile of hurricane translation speed');
subplot(2,1,1);
cyc_n_res = IBTrACS_1992_2010.EddyGeoSpeed(cyc_n);
acyc_n_res = IBTrACS_1992_2010.EddyGeoSpeed(acyc_n);
c_mean = nanmean(cyc_n_res);
a_mean = nanmean(acyc_n_res);
cyc_n_hist = histc(cyc_n_res,bins);
acyc_n_hist = histc(acyc_n_res, bins);
% n_tots = [cyc_n_hist, acyc_n_hist];
plot(bins, cyc_n_hist)
hold on
plot(bins, acyc_n_hist, 'r')
legend(strcat('cyclonic (mean:',num2str(c_mean),')'),...
    strcat('anticyclonic (mean:',num2str(a_mean),')'), 'Location','North')
xlabel('Eddy Mean Geo-speed')
ylabel('Count')
title('Northern Hemisphere')

subplot(2,1,2);
cyc_s_res = IBTrACS_1992_2010.EddyGeoSpeed(cyc_s);
acyc_s_res = IBTrACS_1992_2010.EddyGeoSpeed(acyc_s);
c_mean = nanmean(cyc_s_res);
a_mean = nanmean(acyc_s_res);
cyc_s_hist = histc(cyc_s_res,bins);
acyc_s_hist = histc(acyc_s_res, bins);
% s_tots = [cyc_s_hist, acyc_s_hist];
plot(bins, cyc_s_hist)
hold on
plot(bins, acyc_s_hist, 'r')
legend(strcat('cyclonic (mean:',num2str(c_mean),')'),...
    strcat('anticyclonic (mean:',num2str(a_mean),')'), 'Location','North')
xlabel('Eddy Mean Geo-speed')
ylabel('Count')
title('Southern Hemisphere')
saveas(f(13),strcat('eddy_','geospeed','_25.eps'),'epsc');

%% 26th-50th displacements
cyc_n = bitand(cyc_n_idx, disp_50_idx);
acyc_n = bitand(acyc_n_idx, disp_50_idx);
cyc_s = bitand(cyc_s_idx, disp_50_idx);
acyc_s = bitand(acyc_s_idx, disp_50_idx);

%remove outliers > b
cyc_n = bitand(cyc_n,IBTrACS_1992_2010.EddyGeoSpeed < b);
acyc_n = bitand(acyc_n,IBTrACS_1992_2010.EddyGeoSpeed < b);
cyc_s = bitand(cyc_s, IBTrACS_1992_2010.EddyGeoSpeed < b);
acyc_s = bitand(acyc_s, IBTrACS_1992_2010.EddyGeoSpeed < b);

f(14) = figure;
set(gcf,'Name','Subset of 26th-50th percentile of hurricane translation speed');
subplot(2,1,1);
cyc_n_res = IBTrACS_1992_2010.EddyGeoSpeed(cyc_n);
acyc_n_res = IBTrACS_1992_2010.EddyGeoSpeed(acyc_n);
c_mean = nanmean(cyc_n_res);
a_mean = nanmean(acyc_n_res);
cyc_n_hist = histc(cyc_n_res,bins);
acyc_n_hist = histc(acyc_n_res, bins);
% n_tots = [cyc_n_hist, acyc_n_hist];
plot(bins, cyc_n_hist)
hold on
plot(bins, acyc_n_hist, 'r')
legend(strcat('cyclonic (mean:',num2str(c_mean),')'),...
    strcat('anticyclonic (mean:',num2str(a_mean),')'), 'Location','North')
xlabel('Eddy Mean Geo-speed')
ylabel('Count')
title('Northern Hemisphere')

subplot(2,1,2);
cyc_s_res = IBTrACS_1992_2010.EddyGeoSpeed(cyc_s);
acyc_s_res = IBTrACS_1992_2010.EddyGeoSpeed(acyc_s);
c_mean = nanmean(cyc_s_res);
a_mean = nanmean(acyc_s_res);
cyc_s_hist = histc(cyc_s_res,bins);
acyc_s_hist = histc(acyc_s_res, bins);
% s_tots = [cyc_s_hist, acyc_s_hist];
plot(bins, cyc_s_hist)
hold on
plot(bins, acyc_s_hist, 'r')
legend(strcat('cyclonic (mean:',num2str(c_mean),')'),...
    strcat('anticyclonic (mean:',num2str(a_mean),')'), 'Location','North')
xlabel('Eddy Mean Geo-speed')
ylabel('Count')
title('Southern Hemisphere')
saveas(f(14),strcat('eddy_','geospeed','_50.eps'),'epsc');

%% 51st-75th displacements
cyc_n = bitand(cyc_n_idx, disp_75_idx);
acyc_n = bitand(acyc_n_idx, disp_75_idx);
cyc_s = bitand(cyc_s_idx, disp_75_idx);
acyc_s = bitand(acyc_s_idx, disp_75_idx);

%remove outliers > b
cyc_n = bitand(cyc_n,IBTrACS_1992_2010.EddyGeoSpeed < b);
acyc_n = bitand(acyc_n,IBTrACS_1992_2010.EddyGeoSpeed < b);
cyc_s = bitand(cyc_s, IBTrACS_1992_2010.EddyGeoSpeed < b);
acyc_s = bitand(acyc_s, IBTrACS_1992_2010.EddyGeoSpeed < b);

f(15) = figure;
set(gcf,'Name','Subset of 51st-75th percentile of hurricane translation speed');
subplot(2,1,1);
cyc_n_res = IBTrACS_1992_2010.EddyGeoSpeed(cyc_n);
acyc_n_res = IBTrACS_1992_2010.EddyGeoSpeed(acyc_n);
c_mean = nanmean(cyc_n_res);
a_mean = nanmean(acyc_n_res);
cyc_n_hist = histc(cyc_n_res,bins);
acyc_n_hist = histc(acyc_n_res, bins);
% n_tots = [cyc_n_hist, acyc_n_hist];
plot(bins, cyc_n_hist)
hold on
plot(bins, acyc_n_hist, 'r')
legend(strcat('cyclonic (mean:',num2str(c_mean),')'),...
    strcat('anticyclonic (mean:',num2str(a_mean),')'), 'Location','North')
xlabel('Eddy Mean Geo-speed')
ylabel('Count')
title('Northern Hemisphere')

subplot(2,1,2);
cyc_s_res = IBTrACS_1992_2010.EddyGeoSpeed(cyc_s);
acyc_s_res = IBTrACS_1992_2010.EddyGeoSpeed(acyc_s);
c_mean = nanmean(cyc_s_res);
a_mean = nanmean(acyc_s_res);
cyc_s_hist = histc(cyc_s_res,bins);
acyc_s_hist = histc(acyc_s_res, bins);
% s_tots = [cyc_s_hist, acyc_s_hist];
plot(bins, cyc_s_hist)
hold on
plot(bins, acyc_s_hist, 'r')
legend(strcat('cyclonic (mean:',num2str(c_mean),')'),...
    strcat('anticyclonic (mean:',num2str(a_mean),')'), 'Location','North')
xlabel('Eddy Mean Geo-speed')
ylabel('Count')
title('Southern Hemisphere')
saveas(f(15),strcat('eddy_','geospeed','_75.eps'),'epsc');

%% 76th-100th displacements
cyc_n = bitand(cyc_n_idx, disp_100_idx);
acyc_n = bitand(acyc_n_idx, disp_100_idx);
cyc_s = bitand(cyc_s_idx, disp_100_idx);
acyc_s = bitand(acyc_s_idx, disp_100_idx);

%remove outliers > b
cyc_n = bitand(cyc_n,IBTrACS_1992_2010.EddyGeoSpeed < b);
acyc_n = bitand(acyc_n,IBTrACS_1992_2010.EddyGeoSpeed < b);
cyc_s = bitand(cyc_s, IBTrACS_1992_2010.EddyGeoSpeed < b);
acyc_s = bitand(acyc_s, IBTrACS_1992_2010.EddyGeoSpeed < b);

f(16) = figure;
set(gcf,'Name','Subset of 76th-100th percentile of hurricane translation speed');
subplot(2,1,1);
cyc_n_res = IBTrACS_1992_2010.EddyGeoSpeed(cyc_n);
acyc_n_res = IBTrACS_1992_2010.EddyGeoSpeed(acyc_n);
c_mean = nanmean(cyc_n_res);
a_mean = nanmean(acyc_n_res);
cyc_n_hist = histc(cyc_n_res,bins);
acyc_n_hist = histc(acyc_n_res, bins);
% n_tots = [cyc_n_hist, acyc_n_hist];
plot(bins, cyc_n_hist)
hold on
plot(bins, acyc_n_hist, 'r')
legend(strcat('cyclonic (mean:',num2str(c_mean),')'),...
   strcat('anticyclonic (mean:',num2str(a_mean),')'), 'Location','North')
xlabel('Eddy Mean Geo-speed')
ylabel('Count')
title('Northern Hemisphere')

subplot(2,1,2);
cyc_s_res = IBTrACS_1992_2010.EddyGeoSpeed(cyc_s);
acyc_s_res = IBTrACS_1992_2010.EddyGeoSpeed(acyc_s);
c_mean = nanmean(cyc_s_res);
a_mean = nanmean(acyc_s_res);
cyc_s_hist = histc(cyc_s_res,bins);
acyc_s_hist = histc(acyc_s_res, bins);
% s_tots = [cyc_s_hist, acyc_s_hist];
plot(bins, cyc_s_hist)
hold on
plot(bins, acyc_s_hist, 'r')
legend(strcat('cyclonic (mean:',num2str(c_mean),')'),...
    strcat('anticyclonic (mean:',num2str(a_mean),')'), 'Location','North')
xlabel('Eddy Mean Geo-speed')
ylabel('Count')
title('Southern Hemisphere')
saveas(f(16),strcat('eddy_','geospeed','_100.eps'),'epsc');

%% Plot eddy pixel count by cyc/acyc and by hurricane displacement
% cyc_n_idx = bitand(IBTrACS_1992_2010.EddyClass(:) == -1, IBTrACS_1992_2010.Latitude_for_mapping(:) > 0);
% acyc_n_idx = bitand(IBTrACS_1992_2010.EddyClass(:) == 1, IBTrACS_1992_2010.Latitude_for_mapping(:) > 0);
% acyc_s_idx = bitand(IBTrACS_1992_2010.EddyClass(:) == 1, IBTrACS_1992_2010.Latitude_for_mapping(:) < 0);
% cyc_s_idx = bitand(IBTrACS_1992_2010.EddyClass(:) == -1, IBTrACS_1992_2010.Latitude_for_mapping(:) < 0);

a = min(IBTrACS_1992_2010.EddyPixelCount);
b = prctile(IBTrACS_1992_2010.EddyPixelCount,99);
bins = (a:10:b);
%% 1st-25th displacements
cyc_n = bitand(cyc_n_idx, disp_25_idx);
acyc_n = bitand(acyc_n_idx, disp_25_idx);
cyc_s = bitand(cyc_s_idx, disp_25_idx);
acyc_s = bitand(acyc_s_idx, disp_25_idx);

%remove outliers > b
cyc_n = bitand(cyc_n,IBTrACS_1992_2010.EddyPixelCount < b);
acyc_n = bitand(acyc_n,IBTrACS_1992_2010.EddyPixelCount < b);
cyc_s = bitand(cyc_s, IBTrACS_1992_2010.EddyPixelCount < b);
acyc_s = bitand(acyc_s, IBTrACS_1992_2010.EddyPixelCount < b);

f(17) = figure;
set(gcf,'Name','Subset of 1st-25th percentile of hurricane translation speed');
subplot(2,1,1);
cyc_n_res = IBTrACS_1992_2010.EddyPixelCount(cyc_n);
acyc_n_res = IBTrACS_1992_2010.EddyPixelCount(acyc_n);
c_mean = nanmean(cyc_n_res);
a_mean = nanmean(acyc_n_res);
cyc_n_hist = histc(cyc_n_res,bins);
acyc_n_hist = histc(acyc_n_res, bins);
% n_tots = [cyc_n_hist, acyc_n_hist];
plot(bins, cyc_n_hist)
hold on
plot(bins, acyc_n_hist, 'r')
legend(strcat('cyclonic (mean:',num2str(c_mean),')'),...
    strcat('anticyclonic (mean:',num2str(a_mean),')'), 'Location','NorthEast')
xlabel('Eddy Pixel Count')
ylabel('Count')
title('Northern Hemisphere')

subplot(2,1,2);
cyc_s_res = IBTrACS_1992_2010.EddyPixelCount(cyc_s);
acyc_s_res = IBTrACS_1992_2010.EddyPixelCount(acyc_s);
c_mean = nanmean(cyc_s_res);
a_mean = nanmean(acyc_s_res);
cyc_s_hist = histc(cyc_s_res,bins);
acyc_s_hist = histc(acyc_s_res, bins);
% s_tots = [cyc_s_hist, acyc_s_hist];
plot(bins, cyc_s_hist)
hold on
plot(bins, acyc_s_hist, 'r')
legend(strcat('cyclonic (mean:',num2str(c_mean),')'),...
    strcat('anticyclonic (mean:',num2str(a_mean),')'), 'Location','NorthEast')
xlabel('Eddy Pixel Count')
ylabel('Count')
title('Southern Hemisphere')
saveas(f(17),strcat('eddy_','pixelcount','_25.eps'),'epsc');

%% 26th-50th displacements
cyc_n = bitand(cyc_n_idx, disp_50_idx);
acyc_n = bitand(acyc_n_idx, disp_50_idx);
cyc_s = bitand(cyc_s_idx, disp_50_idx);
acyc_s = bitand(acyc_s_idx, disp_50_idx);

%remove outliers > b
cyc_n = bitand(cyc_n,IBTrACS_1992_2010.EddyPixelCount < b);
acyc_n = bitand(acyc_n,IBTrACS_1992_2010.EddyPixelCount < b);
cyc_s = bitand(cyc_s, IBTrACS_1992_2010.EddyPixelCount < b);
acyc_s = bitand(acyc_s, IBTrACS_1992_2010.EddyPixelCount < b);

f(18) = figure;
set(gcf,'Name','Subset of 26th-50th percentile of hurricane translation speed');
subplot(2,1,1);
cyc_n_res = IBTrACS_1992_2010.EddyPixelCount(cyc_n);
acyc_n_res = IBTrACS_1992_2010.EddyPixelCount(acyc_n);
c_mean = nanmean(cyc_n_res);
a_mean = nanmean(acyc_n_res);
cyc_n_hist = histc(cyc_n_res,bins);
acyc_n_hist = histc(acyc_n_res, bins);
% n_tots = [cyc_n_hist, acyc_n_hist];
plot(bins, cyc_n_hist)
hold on
plot(bins, acyc_n_hist, 'r')
legend(strcat('cyclonic (mean:',num2str(c_mean),')'),...
    strcat('anticyclonic (mean:',num2str(a_mean),')'), 'Location','NorthEast')
xlabel('Eddy Pixel Count')
ylabel('Count')
title('Northern Hemisphere')

subplot(2,1,2);
cyc_s_res = IBTrACS_1992_2010.EddyPixelCount(cyc_s);
acyc_s_res = IBTrACS_1992_2010.EddyPixelCount(acyc_s);
c_mean = nanmean(cyc_s_res);
a_mean = nanmean(acyc_s_res);
cyc_s_hist = histc(cyc_s_res,bins);
acyc_s_hist = histc(acyc_s_res, bins);
% s_tots = [cyc_s_hist, acyc_s_hist];
plot(bins, cyc_s_hist)
hold on
plot(bins, acyc_s_hist, 'r')
legend(strcat('cyclonic (mean:',num2str(c_mean),')'),...
    strcat('anticyclonic (mean:',num2str(a_mean),')'), 'Location','NorthEast')
xlabel('Eddy Pixel Count')
ylabel('Count')
title('Southern Hemisphere')
saveas(f(18),strcat('eddy_','pixelcount','_50.eps'),'epsc');

%% 51st-75th displacements
cyc_n = bitand(cyc_n_idx, disp_75_idx);
acyc_n = bitand(acyc_n_idx, disp_75_idx);
cyc_s = bitand(cyc_s_idx, disp_75_idx);
acyc_s = bitand(acyc_s_idx, disp_75_idx);

%remove outliers > b
cyc_n = bitand(cyc_n,IBTrACS_1992_2010.EddyPixelCount < b);
acyc_n = bitand(acyc_n,IBTrACS_1992_2010.EddyPixelCount < b);
cyc_s = bitand(cyc_s, IBTrACS_1992_2010.EddyPixelCount < b);
acyc_s = bitand(acyc_s, IBTrACS_1992_2010.EddyPixelCount < b);

f(19) = figure;
set(gcf,'Name','Subset of 51st-75th percentile of hurricane translation speed');
subplot(2,1,1);
cyc_n_res = IBTrACS_1992_2010.EddyPixelCount(cyc_n);
acyc_n_res = IBTrACS_1992_2010.EddyPixelCount(acyc_n);
c_mean = nanmean(cyc_n_res);
a_mean = nanmean(acyc_n_res);
cyc_n_hist = histc(cyc_n_res,bins);
acyc_n_hist = histc(acyc_n_res, bins);
% n_tots = [cyc_n_hist, acyc_n_hist];
plot(bins, cyc_n_hist)
hold on
plot(bins, acyc_n_hist, 'r')
legend(strcat('cyclonic (mean:',num2str(c_mean),')'),...
    strcat('anticyclonic (mean:',num2str(a_mean),')'), 'Location','NorthEast')
xlabel('Eddy Pixel Count')
ylabel('Count')
title('Northern Hemisphere')

subplot(2,1,2);
cyc_s_res = IBTrACS_1992_2010.EddyPixelCount(cyc_s);
acyc_s_res = IBTrACS_1992_2010.EddyPixelCount(acyc_s);
c_mean = nanmean(cyc_s_res);
a_mean = nanmean(acyc_s_res);
cyc_s_hist = histc(cyc_s_res,bins);
acyc_s_hist = histc(acyc_s_res, bins);
% s_tots = [cyc_s_hist, acyc_s_hist];
plot(bins, cyc_s_hist)
hold on
plot(bins, acyc_s_hist, 'r')
legend(strcat('cyclonic (mean:',num2str(c_mean),')'),...
    strcat('anticyclonic (mean:',num2str(a_mean),')'), 'Location','NorthEast')
xlabel('Eddy Pixel Count')
ylabel('Count')
title('Southern Hemisphere')
saveas(f(19),strcat('eddy_','pixelcount','_75.eps'),'epsc');

%% 76th-100th displacements
cyc_n = bitand(cyc_n_idx, disp_100_idx);
acyc_n = bitand(acyc_n_idx, disp_100_idx);
cyc_s = bitand(cyc_s_idx, disp_100_idx);
acyc_s = bitand(acyc_s_idx, disp_100_idx);

%remove outliers > b
cyc_n = bitand(cyc_n,IBTrACS_1992_2010.EddyPixelCount < b);
acyc_n = bitand(acyc_n,IBTrACS_1992_2010.EddyPixelCount < b);
cyc_s = bitand(cyc_s, IBTrACS_1992_2010.EddyPixelCount < b);
acyc_s = bitand(acyc_s, IBTrACS_1992_2010.EddyPixelCount < b);

f(20) = figure;
set(gcf,'Name','Subset of 76th-100th percentile of hurricane translation speed');
subplot(2,1,1);
cyc_n_res = IBTrACS_1992_2010.EddyPixelCount(cyc_n);
acyc_n_res = IBTrACS_1992_2010.EddyPixelCount(acyc_n);
c_mean = nanmean(cyc_n_res);
a_mean = nanmean(acyc_n_res);
cyc_n_hist = histc(cyc_n_res,bins);
acyc_n_hist = histc(acyc_n_res, bins);
% n_tots = [cyc_n_hist, acyc_n_hist];
plot(bins, cyc_n_hist)
hold on
plot(bins, acyc_n_hist, 'r')
legend(strcat('cyclonic (mean:',num2str(c_mean),')'),...
    strcat('anticyclonic (mean:',num2str(a_mean),')'), 'Location','NorthEast')
xlabel('Eddy Pixel Count')
ylabel('Count')
title('Northern Hemisphere')

subplot(2,1,2);
cyc_s_res = IBTrACS_1992_2010.EddyPixelCount(cyc_s);
acyc_s_res = IBTrACS_1992_2010.EddyPixelCount(acyc_s);
c_mean = nanmean(cyc_s_res);
a_mean = nanmean(acyc_s_res);
cyc_s_hist = histc(cyc_s_res,bins);
acyc_s_hist = histc(acyc_s_res, bins);
% s_tots = [cyc_s_hist, acyc_s_hist];
plot(bins, cyc_s_hist)
hold on
plot(bins, acyc_s_hist, 'r')
legend(strcat('cyclonic (mean:',num2str(c_mean),')'),...
    strcat('anticyclonic (mean:',num2str(a_mean),')'), 'Location','NorthEast')
xlabel('Eddy Pixel Count')
ylabel('Count')
title('Southern Hemisphere')
saveas(f(20),strcat('eddy_','pixelcount','_100.eps'),'epsc');