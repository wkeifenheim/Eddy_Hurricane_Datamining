%% WEEKLY plot figures of eddy characteristic segmented by hurricane displacement

load('/panfs/roc/groups/6/kumarv/keifenhe/Documents/Datasets/with_daily_eddies/IBTrACS_1992_2010.mat')

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
% %legend('cyclonic','anticyclonic', 'Location','North')
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
% %legend('cyclonic','anticyclonic', 'Location','North')
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
% %legend('cyclonic','anticyclonic', 'Location','North')
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
% %legend('cyclonic','anticyclonic', 'Location','North')
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
% %legend('cyclonic','anticyclonic', 'Location','North')
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
% %legend('cyclonic','anticyclonic', 'Location','North')
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
% %legend('cyclonic','anticyclonic', 'Location','North')
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
% %legend('cyclonic','anticyclonic', 'Location','North')
% xlabel('<-Left Passes || Center Passes || Right Passes ->')
% ylabel('Count')
% title('Southern Hemisphere |  <= 25km threshold')

%% Plot eddy age by cyc/acyc and by hurricane displacement
% cyc_n_idx = bitand(IBTrACS_1992_2010.EddyClass(:) == -1, IBTrACS_1992_2010.Latitude_for_mapping(:) > 0);
% acyc_n_idx = bitand(IBTrACS_1992_2010.EddyClass(:) == 1, IBTrACS_1992_2010.Latitude_for_mapping(:) > 0);
% acyc_s_idx = bitand(IBTrACS_1992_2010.EddyClass(:) == 1, IBTrACS_1992_2010.Latitude_for_mapping(:) < 0);
% cyc_s_idx = bitand(IBTrACS_1992_2010.EddyClass(:) == -1, IBTrACS_1992_2010.Latitude_for_mapping(:) < 0);
% 
% a = min(IBTrACS_1992_2010.EddyAge);
% b = max(IBTrACS_1992_2010.EddyAge);
% bins = (a:10:b);
% %% 1st-25th displacements
% cyc_n = bitand(cyc_n_idx, disp_25_idx);
% acyc_n = bitand(acyc_n_idx, disp_25_idx);
% cyc_s = bitand(cyc_s_idx, disp_25_idx);
% acyc_s = bitand(acyc_s_idx, disp_25_idx);
% 
% figure;
% set(gcf,'Name','Subset of 1st-25th percentile of hurricane translation speed');
% subplot(2,1,1);
% cyc_n_res = IBTrACS_1992_2010.EddyAge(cyc_n);
% acyc_n_res = IBTrACS_1992_2010.EddyAge(acyc_n);
% cyc_n_hist = histc(cyc_n_res,bins);
% acyc_n_hist = histc(acyc_n_res, bins);
% n_tots = [cyc_n_hist, acyc_n_hist];
% plot(n_tots)
% legend('cyclonic','anticyclonic', 'Location','North')
% xlabel('Eddy Age (days)')
% ylabel('Count')
% title('Northern Hemisphere')
% 
% subplot(2,1,2);
% cyc_s_res = IBTrACS_1992_2010.EddyAge(cyc_s);
% acyc_s_res = IBTrACS_1992_2010.EddyAge(acyc_s);
% cyc_s_hist = histc(cyc_s_res,bins);
% acyc_s_hist = histc(acyc_s_res, bins);
% s_tots = [cyc_s_hist, acyc_s_hist];
% plot(s_tots)
% legend('cyclonic','anticyclonic', 'Location','North')
% xlabel('Eddy Age (days)')
% ylabel('Count')
% title('Southern Hemisphere')
% 
% %% 26th-50th displacements
% cyc_n = bitand(cyc_n_idx, disp_50_idx);
% acyc_n = bitand(acyc_n_idx, disp_50_idx);
% cyc_s = bitand(cyc_s_idx, disp_50_idx);
% acyc_s = bitand(acyc_s_idx, disp_50_idx);
% 
% figure;
% set(gcf,'Name','Subset of 26th-50th percentile of hurricane translation speed');
% subplot(2,1,1);
% cyc_n_res = IBTrACS_1992_2010.EddyAge(cyc_n);
% acyc_n_res = IBTrACS_1992_2010.EddyAge(acyc_n);
% cyc_n_hist = histc(cyc_n_res,bins);
% acyc_n_hist = histc(acyc_n_res, bins);
% n_tots = [cyc_n_hist, acyc_n_hist];
% plot(n_tots)
% legend('cyclonic','anticyclonic', 'Location','North')
% xlabel('Eddy Age (days)')
% ylabel('Count')
% title('Northern Hemisphere')
% 
% subplot(2,1,2);
% cyc_s_res = IBTrACS_1992_2010.EddyAge(cyc_s);
% acyc_s_res = IBTrACS_1992_2010.EddyAge(acyc_s);
% cyc_s_hist = histc(cyc_s_res,bins);
% acyc_s_hist = histc(acyc_s_res, bins);
% s_tots = [cyc_s_hist, acyc_s_hist];
% plot(s_tots)
% legend('cyclonic','anticyclonic', 'Location','North')
% xlabel('Eddy Age (days)')
% ylabel('Count')
% title('Southern Hemisphere')
% 
% %% 51st-75th displacements
% cyc_n = bitand(cyc_n_idx, disp_75_idx);
% acyc_n = bitand(acyc_n_idx, disp_75_idx);
% cyc_s = bitand(cyc_s_idx, disp_75_idx);
% acyc_s = bitand(acyc_s_idx, disp_75_idx);
% 
% figure;
% set(gcf,'Name','Subset of 51st-75th percentile of hurricane translation speed');
% subplot(2,1,1);
% cyc_n_res = IBTrACS_1992_2010.EddyAge(cyc_n);
% acyc_n_res = IBTrACS_1992_2010.EddyAge(acyc_n);
% cyc_n_hist = histc(cyc_n_res,bins);
% acyc_n_hist = histc(acyc_n_res, bins);
% n_tots = [cyc_n_hist, acyc_n_hist];
% plot(n_tots)
% legend('cyclonic','anticyclonic', 'Location','North')
% xlabel('Eddy Age (days)')
% ylabel('Count')
% title('Northern Hemisphere')
% 
% subplot(2,1,2);
% cyc_s_res = IBTrACS_1992_2010.EddyAge(cyc_s);
% acyc_s_res = IBTrACS_1992_2010.EddyAge(acyc_s);
% cyc_s_hist = histc(cyc_s_res,bins);
% acyc_s_hist = histc(acyc_s_res, bins);
% s_tots = [cyc_s_hist, acyc_s_hist];
% plot(s_tots)
% legend('cyclonic','anticyclonic', 'Location','North')
% xlabel('Eddy Age (days)')
% ylabel('Count')
% title('Southern Hemisphere')
% 
% %% 76th-100th displacements
% cyc_n = bitand(cyc_n_idx, disp_100_idx);
% acyc_n = bitand(acyc_n_idx, disp_100_idx);
% cyc_s = bitand(cyc_s_idx, disp_100_idx);
% acyc_s = bitand(acyc_s_idx, disp_100_idx);
% 
% figure;
% set(gcf,'Name','Subset of 76th-100th percentile of hurricane translation speed');
% subplot(2,1,1);
% cyc_n_res = IBTrACS_1992_2010.EddyAge(cyc_n);
% acyc_n_res = IBTrACS_1992_2010.EddyAge(acyc_n);
% cyc_n_hist = histc(cyc_n_res,bins);
% acyc_n_hist = histc(acyc_n_res, bins);
% n_tots = [cyc_n_hist, acyc_n_hist];
% plot(n_tots)
% legend('cyclonic','anticyclonic', 'Location','North')
% xlabel('Eddy Age (days)')
% ylabel('Count')
% title('Northern Hemisphere')
% 
% subplot(2,1,2);
% cyc_s_res = IBTrACS_1992_2010.EddyAge(cyc_s);
% acyc_s_res = IBTrACS_1992_2010.EddyAge(acyc_s);
% cyc_s_hist = histc(cyc_s_res,bins);
% acyc_s_hist = histc(acyc_s_res, bins);
% s_tots = [cyc_s_hist, acyc_s_hist];
% plot(s_tots)
% legend('cyclonic','anticyclonic', 'Location','North')
% xlabel('Eddy Age (days)')
% ylabel('Count')
% title('Southern Hemisphere')

%% Plot eddy lifetime by cyc/acyc and by hurricane displacement
% cyc_n_idx = bitand(IBTrACS_1992_2010.EddyClass(:) == -1, IBTrACS_1992_2010.Latitude_for_mapping(:) > 0);
% acyc_n_idx = bitand(IBTrACS_1992_2010.EddyClass(:) == 1, IBTrACS_1992_2010.Latitude_for_mapping(:) > 0);
% acyc_s_idx = bitand(IBTrACS_1992_2010.EddyClass(:) == 1, IBTrACS_1992_2010.Latitude_for_mapping(:) < 0);
% cyc_s_idx = bitand(IBTrACS_1992_2010.EddyClass(:) == -1, IBTrACS_1992_2010.Latitude_for_mapping(:) < 0);
% 
% % a = min(IBTrACS_1992_2010.EddyTrackLifetime);
% b = max(IBTrACS_1992_2010.EddyTrackLifetime);
% bins = (1:10:b);
% %% 1st-25th displacements
% cyc_n = bitand(cyc_n_idx, disp_25_idx);
% acyc_n = bitand(acyc_n_idx, disp_25_idx);
% cyc_s = bitand(cyc_s_idx, disp_25_idx);
% acyc_s = bitand(acyc_s_idx, disp_25_idx);
% 
% figure;
% set(gcf,'Name','Subset of 1st-25th percentile of hurricane translation speed');
% subplot(2,1,1);
% cyc_n_res = IBTrACS_1992_2010.EddyTrackLifetime(cyc_n);
% acyc_n_res = IBTrACS_1992_2010.EddyTrackLifetime(acyc_n);
% cyc_n_hist = histc(cyc_n_res,bins);
% acyc_n_hist = histc(acyc_n_res, bins);
% n_tots = [cyc_n_hist, acyc_n_hist];
% plot(n_tots)
% legend('cyclonic','anticyclonic', 'Location','North')
% xlabel('Eddy Lifetime (days)')
% ylabel('Count')
% title('Northern Hemisphere')
% 
% subplot(2,1,2);
% cyc_s_res = IBTrACS_1992_2010.EddyTrackLifetime(cyc_s);
% acyc_s_res = IBTrACS_1992_2010.EddyTrackLifetime(acyc_s);
% cyc_s_hist = histc(cyc_s_res,bins);
% acyc_s_hist = histc(acyc_s_res, bins);
% s_tots = [cyc_s_hist, acyc_s_hist];
% plot(s_tots)
% legend('cyclonic','anticyclonic', 'Location','North')
% xlabel('Eddy Lifetime (days)')
% ylabel('Count')
% title('Southern Hemisphere')
% 
% %% 26th-50th displacements
% cyc_n = bitand(cyc_n_idx, disp_50_idx);
% acyc_n = bitand(acyc_n_idx, disp_50_idx);
% cyc_s = bitand(cyc_s_idx, disp_50_idx);
% acyc_s = bitand(acyc_s_idx, disp_50_idx);
% 
% figure;
% set(gcf,'Name','Subset of 26th-50th percentile of hurricane translation speed');
% subplot(2,1,1);
% cyc_n_res = IBTrACS_1992_2010.EddyTrackLifetime(cyc_n);
% acyc_n_res = IBTrACS_1992_2010.EddyTrackLifetime(acyc_n);
% cyc_n_hist = histc(cyc_n_res,bins);
% acyc_n_hist = histc(acyc_n_res, bins);
% n_tots = [cyc_n_hist, acyc_n_hist];
% plot(n_tots)
% legend('cyclonic','anticyclonic', 'Location','North')
% xlabel('Eddy Lifetime (days)')
% ylabel('Count')
% title('Northern Hemisphere')
% 
% subplot(2,1,2);
% cyc_s_res = IBTrACS_1992_2010.EddyTrackLifetime(cyc_s);
% acyc_s_res = IBTrACS_1992_2010.EddyTrackLifetime(acyc_s);
% cyc_s_hist = histc(cyc_s_res,bins);
% acyc_s_hist = histc(acyc_s_res, bins);
% s_tots = [cyc_s_hist, acyc_s_hist];
% plot(s_tots)
% legend('cyclonic','anticyclonic', 'Location','North')
% xlabel('Eddy Lifetime (days)')
% ylabel('Count')
% title('Southern Hemisphere')
% 
% %% 51st-75th displacements
% cyc_n = bitand(cyc_n_idx, disp_75_idx);
% acyc_n = bitand(acyc_n_idx, disp_75_idx);
% cyc_s = bitand(cyc_s_idx, disp_75_idx);
% acyc_s = bitand(acyc_s_idx, disp_75_idx);
% 
% figure;
% set(gcf,'Name','Subset of 51st-75th percentile of hurricane translation speed');
% subplot(2,1,1);
% cyc_n_res = IBTrACS_1992_2010.EddyTrackLifetime(cyc_n);
% acyc_n_res = IBTrACS_1992_2010.EddyTrackLifetime(acyc_n);
% cyc_n_hist = histc(cyc_n_res,bins);
% acyc_n_hist = histc(acyc_n_res, bins);
% n_tots = [cyc_n_hist, acyc_n_hist];
% plot(n_tots)
% legend('cyclonic','anticyclonic', 'Location','North')
% xlabel('Eddy Lifetime (days)')
% ylabel('Count')
% title('Northern Hemisphere')
% 
% subplot(2,1,2);
% cyc_s_res = IBTrACS_1992_2010.EddyTrackLifetime(cyc_s);
% acyc_s_res = IBTrACS_1992_2010.EddyTrackLifetime(acyc_s);
% cyc_s_hist = histc(cyc_s_res,bins);
% acyc_s_hist = histc(acyc_s_res, bins);
% s_tots = [cyc_s_hist, acyc_s_hist];
% plot(s_tots)
% legend('cyclonic','anticyclonic', 'Location','North')
% xlabel('Eddy Lifetime (days)')
% ylabel('Count')
% title('Southern Hemisphere')
% 
% %% 76th-100th displacements
% cyc_n = bitand(cyc_n_idx, disp_100_idx);
% acyc_n = bitand(acyc_n_idx, disp_100_idx);
% cyc_s = bitand(cyc_s_idx, disp_100_idx);
% acyc_s = bitand(acyc_s_idx, disp_100_idx);
% 
% figure;
% set(gcf,'Name','Subset of 76th-100th percentile of hurricane translation speed');
% subplot(2,1,1);
% cyc_n_res = IBTrACS_1992_2010.EddyTrackLifetime(cyc_n);
% acyc_n_res = IBTrACS_1992_2010.EddyTrackLifetime(acyc_n);
% cyc_n_hist = histc(cyc_n_res,bins);
% acyc_n_hist = histc(acyc_n_res, bins);
% n_tots = [cyc_n_hist, acyc_n_hist];
% plot(n_tots)
% legend('cyclonic','anticyclonic', 'Location','North')
% xlabel('Eddy Lifetime (days)')
% ylabel('Count')
% title('Northern Hemisphere')
% 
% subplot(2,1,2);
% cyc_s_res = IBTrACS_1992_2010.EddyTrackLifetime(cyc_s);
% acyc_s_res = IBTrACS_1992_2010.EddyTrackLifetime(acyc_s);
% cyc_s_hist = histc(cyc_s_res,bins);
% acyc_s_hist = histc(acyc_s_res, bins);
% s_tots = [cyc_s_hist, acyc_s_hist];
% plot(s_tots)
% legend('cyclonic','anticyclonic', 'Location','North')
% xlabel('Eddy Lifetime (days)')
% ylabel('Count')
% title('Southern Hemisphere')

%% Plot eddy amplitude by cyc/acyc and by hurricane displacement
% cyc_n_idx = bitand(IBTrACS_1992_2010.EddyClass(:) == -1, IBTrACS_1992_2010.Latitude_for_mapping(:) > 0);
% acyc_n_idx = bitand(IBTrACS_1992_2010.EddyClass(:) == 1, IBTrACS_1992_2010.Latitude_for_mapping(:) > 0);
% acyc_s_idx = bitand(IBTrACS_1992_2010.EddyClass(:) == 1, IBTrACS_1992_2010.Latitude_for_mapping(:) < 0);
% cyc_s_idx = bitand(IBTrACS_1992_2010.EddyClass(:) == -1, IBTrACS_1992_2010.Latitude_for_mapping(:) < 0);
% 
% % a = min(IBTrACS_1992_2010.EddyTrackLifetime);
% b = max(IBTrACS_1992_2010.EddyTrackLifetime);
% bins = (1:10:b);
% %% 1st-25th displacements
% cyc_n = bitand(cyc_n_idx, disp_25_idx);
% acyc_n = bitand(acyc_n_idx, disp_25_idx);
% cyc_s = bitand(cyc_s_idx, disp_25_idx);
% acyc_s = bitand(acyc_s_idx, disp_25_idx);
% 
% figure;
% set(gcf,'Name','Subset of 1st-25th percentile of hurricane translation speed');
% subplot(2,1,1);
% cyc_n_res = IBTrACS_1992_2010.EddyAmp(cyc_n);
% acyc_n_res = IBTrACS_1992_2010.EddyAmp(acyc_n);
% cyc_n_hist = histc(cyc_n_res,bins);
% acyc_n_hist = histc(acyc_n_res, bins);
% % n_tots = [cyc_n_hist, acyc_n_hist];
% plot(cyc_n_hist)
% hold on
% plot(acyc_n_hist, 'r')
% legend('cyclonic','anticyclonic', 'Location','North')
% xlabel('Eddy Amplitude')
% ylabel('Count')
% title('Northern Hemisphere')
% 
% subplot(2,1,2);
% cyc_s_res = IBTrACS_1992_2010.EddyAmp(cyc_s);
% acyc_s_res = IBTrACS_1992_2010.EddyAmp(acyc_s);
% cyc_s_hist = histc(cyc_s_res,bins);
% acyc_s_hist = histc(acyc_s_res, bins);
% % s_tots = [cyc_s_hist, acyc_s_hist];
% plot(cyc_s_hist)
% hold on
% plot(acyc_s_hist, 'r')
% legend('cyclonic','anticyclonic', 'Location','North')
% xlabel('Eddy Amplitude')
% ylabel('Count')
% title('Southern Hemisphere')
% 
% %% 26th-50th displacements
% cyc_n = bitand(cyc_n_idx, disp_50_idx);
% acyc_n = bitand(acyc_n_idx, disp_50_idx);
% cyc_s = bitand(cyc_s_idx, disp_50_idx);
% acyc_s = bitand(acyc_s_idx, disp_50_idx);
% 
% figure;
% set(gcf,'Name','Subset of 26th-50th percentile of hurricane translation speed');
% subplot(2,1,1);
% cyc_n_res = IBTrACS_1992_2010.EddyAmp(cyc_n);
% acyc_n_res = IBTrACS_1992_2010.EddyAmp(acyc_n);
% cyc_n_hist = histc(cyc_n_res,bins);
% acyc_n_hist = histc(acyc_n_res, bins);
% % n_tots = [cyc_n_hist, acyc_n_hist];
% plot(cyc_n_hist)
% hold on
% plot(acyc_n_hist, 'r')
% legend('cyclonic','anticyclonic', 'Location','North')
% xlabel('Eddy Amplitude')
% ylabel('Count')
% title('Northern Hemisphere')
% 
% subplot(2,1,2);
% cyc_s_res = IBTrACS_1992_2010.EddyAmp(cyc_s);
% acyc_s_res = IBTrACS_1992_2010.EddyAmp(acyc_s);
% cyc_s_hist = histc(cyc_s_res,bins);
% acyc_s_hist = histc(acyc_s_res, bins);
% % s_tots = [cyc_s_hist, acyc_s_hist];
% plot(cyc_s_hist)
% hold on
% plot(acyc_s_hist, 'r')
% legend('cyclonic','anticyclonic', 'Location','North')
% xlabel('Eddy Amplitude')
% ylabel('Count')
% title('Southern Hemisphere')
% 
% %% 51st-75th displacements
% cyc_n = bitand(cyc_n_idx, disp_75_idx);
% acyc_n = bitand(acyc_n_idx, disp_75_idx);
% cyc_s = bitand(cyc_s_idx, disp_75_idx);
% acyc_s = bitand(acyc_s_idx, disp_75_idx);
% 
% figure;
% set(gcf,'Name','Subset of 51st-75th percentile of hurricane translation speed');
% subplot(2,1,1);
% cyc_n_res = IBTrACS_1992_2010.EddyAmp(cyc_n);
% acyc_n_res = IBTrACS_1992_2010.EddyAmp(acyc_n);
% cyc_n_hist = histc(cyc_n_res,bins);
% acyc_n_hist = histc(acyc_n_res, bins);
% % n_tots = [cyc_n_hist, acyc_n_hist];
% plot(cyc_n_hist)
% hold on
% plot(acyc_n_hist, 'r')
% legend('cyclonic','anticyclonic', 'Location','North')
% xlabel('Eddy Amplitude')
% ylabel('Count')
% title('Northern Hemisphere')
% 
% subplot(2,1,2);
% cyc_s_res = IBTrACS_1992_2010.EddyAmp(cyc_s);
% acyc_s_res = IBTrACS_1992_2010.EddyAmp(acyc_s);
% cyc_s_hist = histc(cyc_s_res,bins);
% acyc_s_hist = histc(acyc_s_res, bins);
% % s_tots = [cyc_s_hist, acyc_s_hist];
% plot(cyc_s_hist)
% hold on
% plot(acyc_s_hist, 'r')
% legend('cyclonic','anticyclonic', 'Location','North')
% xlabel('Eddy Amplitude')
% ylabel('Count')
% title('Southern Hemisphere')
% 
% %% 76th-100th displacements
% cyc_n = bitand(cyc_n_idx, disp_100_idx);
% acyc_n = bitand(acyc_n_idx, disp_100_idx);
% cyc_s = bitand(cyc_s_idx, disp_100_idx);
% acyc_s = bitand(acyc_s_idx, disp_100_idx);
% 
% figure;
% set(gcf,'Name','Subset of 76th-100th percentile of hurricane translation speed');
% subplot(2,1,1);
% cyc_n_res = IBTrACS_1992_2010.EddyAmp(cyc_n);
% acyc_n_res = IBTrACS_1992_2010.EddyAmp(acyc_n);
% cyc_n_hist = histc(cyc_n_res,bins);
% acyc_n_hist = histc(acyc_n_res, bins);
% % n_tots = [cyc_n_hist, acyc_n_hist];
% plot(cyc_n_hist)
% hold on
% plot(acyc_n_hist, 'r')
% legend('cyclonic','anticyclonic', 'Location','North')
% xlabel('Eddy Amplitude')
% ylabel('Count')
% title('Northern Hemisphere')
% 
% subplot(2,1,2);
% cyc_s_res = IBTrACS_1992_2010.EddyAmp(cyc_s);
% acyc_s_res = IBTrACS_1992_2010.EddyAmp(acyc_s);
% cyc_s_hist = histc(cyc_s_res,bins);
% acyc_s_hist = histc(acyc_s_res, bins);
% % s_tots = [cyc_s_hist, acyc_s_hist];
% plot(cyc_s_hist)
% hold on
% plot(acyc_s_hist, 'r')
% legend('cyclonic','anticyclonic', 'Location','North')
% xlabel('Eddy Amplitude')
% ylabel('Count')
% title('Southern Hemisphere')

%% Plot eddy geospeed by cyc/acyc and by hurricane displacement
% cyc_n_idx = bitand(IBTrACS_1992_2010.EddyClass(:) == -1, IBTrACS_1992_2010.Latitude_for_mapping(:) > 0);
% acyc_n_idx = bitand(IBTrACS_1992_2010.EddyClass(:) == 1, IBTrACS_1992_2010.Latitude_for_mapping(:) > 0);
% acyc_s_idx = bitand(IBTrACS_1992_2010.EddyClass(:) == 1, IBTrACS_1992_2010.Latitude_for_mapping(:) < 0);
% cyc_s_idx = bitand(IBTrACS_1992_2010.EddyClass(:) == -1, IBTrACS_1992_2010.Latitude_for_mapping(:) < 0);
% 
% % a = min(IBTrACS_1992_2010.EddyTrackLifetime);
% b = max(IBTrACS_1992_2010.EddyTrackLifetime);
% bins = (1:10:b);
% %% 1st-25th displacements
% cyc_n = bitand(cyc_n_idx, disp_25_idx);
% acyc_n = bitand(acyc_n_idx, disp_25_idx);
% cyc_s = bitand(cyc_s_idx, disp_25_idx);
% acyc_s = bitand(acyc_s_idx, disp_25_idx);
% 
% figure;
% set(gcf,'Name','Subset of 1st-25th percentile of hurricane translation speed');
% subplot(2,1,1);
% cyc_n_res = IBTrACS_1992_2010.EddyGeoSpeed(cyc_n);
% acyc_n_res = IBTrACS_1992_2010.EddyGeoSpeed(acyc_n);
% cyc_n_hist = histc(cyc_n_res,bins);
% acyc_n_hist = histc(acyc_n_res, bins);
% % n_tots = [cyc_n_hist, acyc_n_hist];
% plot(cyc_n_hist)
% hold on
% plot(acyc_n_hist, 'r')
% legend('cyclonic','anticyclonic', 'Location','North')
% xlabel('Eddy Mean Geo-speed')
% ylabel('Count')
% title('Northern Hemisphere')
% 
% subplot(2,1,2);
% cyc_s_res = IBTrACS_1992_2010.EddyGeoSpeed(cyc_s);
% acyc_s_res = IBTrACS_1992_2010.EddyGeoSpeed(acyc_s);
% cyc_s_hist = histc(cyc_s_res,bins);
% acyc_s_hist = histc(acyc_s_res, bins);
% % s_tots = [cyc_s_hist, acyc_s_hist];
% plot(cyc_s_hist)
% hold on
% plot(acyc_s_hist, 'r')
% legend('cyclonic','anticyclonic', 'Location','North')
% xlabel('Eddy Mean Geo-speed')
% ylabel('Count')
% title('Southern Hemisphere')
% 
% %% 26th-50th displacements
% cyc_n = bitand(cyc_n_idx, disp_50_idx);
% acyc_n = bitand(acyc_n_idx, disp_50_idx);
% cyc_s = bitand(cyc_s_idx, disp_50_idx);
% acyc_s = bitand(acyc_s_idx, disp_50_idx);
% 
% figure;
% set(gcf,'Name','Subset of 26th-50th percentile of hurricane translation speed');
% subplot(2,1,1);
% cyc_n_res = IBTrACS_1992_2010.EddyGeoSpeed(cyc_n);
% acyc_n_res = IBTrACS_1992_2010.EddyGeoSpeed(acyc_n);
% cyc_n_hist = histc(cyc_n_res,bins);
% acyc_n_hist = histc(acyc_n_res, bins);
% % n_tots = [cyc_n_hist, acyc_n_hist];
% plot(cyc_n_hist)
% hold on
% plot(acyc_n_hist, 'r')
% legend('cyclonic','anticyclonic', 'Location','North')
% xlabel('Eddy Mean Geo-speed')
% ylabel('Count')
% title('Northern Hemisphere')
% 
% subplot(2,1,2);
% cyc_s_res = IBTrACS_1992_2010.EddyGeoSpeed(cyc_s);
% acyc_s_res = IBTrACS_1992_2010.EddyGeoSpeed(acyc_s);
% cyc_s_hist = histc(cyc_s_res,bins);
% acyc_s_hist = histc(acyc_s_res, bins);
% % s_tots = [cyc_s_hist, acyc_s_hist];
% plot(cyc_s_hist)
% hold on
% plot(acyc_s_hist, 'r')
% legend('cyclonic','anticyclonic', 'Location','North')
% xlabel('Eddy Mean Geo-speed')
% ylabel('Count')
% title('Southern Hemisphere')
% 
% %% 51st-75th displacements
% cyc_n = bitand(cyc_n_idx, disp_75_idx);
% acyc_n = bitand(acyc_n_idx, disp_75_idx);
% cyc_s = bitand(cyc_s_idx, disp_75_idx);
% acyc_s = bitand(acyc_s_idx, disp_75_idx);
% 
% figure;
% set(gcf,'Name','Subset of 51st-75th percentile of hurricane translation speed');
% subplot(2,1,1);
% cyc_n_res = IBTrACS_1992_2010.EddyGeoSpeed(cyc_n);
% acyc_n_res = IBTrACS_1992_2010.EddyGeoSpeed(acyc_n);
% cyc_n_hist = histc(cyc_n_res,bins);
% acyc_n_hist = histc(acyc_n_res, bins);
% % n_tots = [cyc_n_hist, acyc_n_hist];
% plot(cyc_n_hist)
% hold on
% plot(acyc_n_hist, 'r')
% legend('cyclonic','anticyclonic', 'Location','North')
% xlabel('Eddy Mean Geo-speed')
% ylabel('Count')
% title('Northern Hemisphere')
% 
% subplot(2,1,2);
% cyc_s_res = IBTrACS_1992_2010.EddyGeoSpeed(cyc_s);
% acyc_s_res = IBTrACS_1992_2010.EddyGeoSpeed(acyc_s);
% cyc_s_hist = histc(cyc_s_res,bins);
% acyc_s_hist = histc(acyc_s_res, bins);
% % s_tots = [cyc_s_hist, acyc_s_hist];
% plot(cyc_s_hist)
% hold on
% plot(acyc_s_hist, 'r')
% legend('cyclonic','anticyclonic', 'Location','North')
% xlabel('Eddy Mean Geo-speed')
% ylabel('Count')
% title('Southern Hemisphere')
% 
% %% 76th-100th displacements
% cyc_n = bitand(cyc_n_idx, disp_100_idx);
% acyc_n = bitand(acyc_n_idx, disp_100_idx);
% cyc_s = bitand(cyc_s_idx, disp_100_idx);
% acyc_s = bitand(acyc_s_idx, disp_100_idx);
% 
% figure;
% set(gcf,'Name','Subset of 76th-100th percentile of hurricane translation speed');
% subplot(2,1,1);
% cyc_n_res = IBTrACS_1992_2010.EddyGeoSpeed(cyc_n);
% acyc_n_res = IBTrACS_1992_2010.EddyGeoSpeed(acyc_n);
% cyc_n_hist = histc(cyc_n_res,bins);
% acyc_n_hist = histc(acyc_n_res, bins);
% % n_tots = [cyc_n_hist, acyc_n_hist];
% plot(cyc_n_hist)
% hold on
% plot(acyc_n_hist, 'r')
% legend('cyclonic','anticyclonic', 'Location','North')
% xlabel('Eddy Mean Geo-speed')
% ylabel('Count')
% title('Northern Hemisphere')
% 
% subplot(2,1,2);
% cyc_s_res = IBTrACS_1992_2010.EddyGeoSpeed(cyc_s);
% acyc_s_res = IBTrACS_1992_2010.EddyGeoSpeed(acyc_s);
% cyc_s_hist = histc(cyc_s_res,bins);
% acyc_s_hist = histc(acyc_s_res, bins);
% % s_tots = [cyc_s_hist, acyc_s_hist];
% plot(cyc_s_hist)
% hold on
% plot(acyc_s_hist, 'r')
% legend('cyclonic','anticyclonic', 'Location','North')
% xlabel('Eddy Mean Geo-speed')
% ylabel('Count')
% title('Southern Hemisphere')

%% Plot eddy pixel count by cyc/acyc and by hurricane displacement
% cyc_n_idx = bitand(IBTrACS_1992_2010.EddyClass(:) == -1, IBTrACS_1992_2010.Latitude_for_mapping(:) > 0);
% acyc_n_idx = bitand(IBTrACS_1992_2010.EddyClass(:) == 1, IBTrACS_1992_2010.Latitude_for_mapping(:) > 0);
% acyc_s_idx = bitand(IBTrACS_1992_2010.EddyClass(:) == 1, IBTrACS_1992_2010.Latitude_for_mapping(:) < 0);
% cyc_s_idx = bitand(IBTrACS_1992_2010.EddyClass(:) == -1, IBTrACS_1992_2010.Latitude_for_mapping(:) < 0);
% 
% % a = min(IBTrACS_1992_2010.EddyTrackLifetime);
% b = max(IBTrACS_1992_2010.EddyTrackLifetime);
% bins = (1:10:b);
% %% 1st-25th displacements
% cyc_n = bitand(cyc_n_idx, disp_25_idx);
% acyc_n = bitand(acyc_n_idx, disp_25_idx);
% cyc_s = bitand(cyc_s_idx, disp_25_idx);
% acyc_s = bitand(acyc_s_idx, disp_25_idx);
% 
% figure;
% set(gcf,'Name','Subset of 1st-25th percentile of hurricane translation speed');
% subplot(2,1,1);
% cyc_n_res = IBTrACS_1992_2010.EddyPixelCount(cyc_n);
% acyc_n_res = IBTrACS_1992_2010.EddyPixelCount(acyc_n);
% cyc_n_hist = histc(cyc_n_res,bins);
% acyc_n_hist = histc(acyc_n_res, bins);
% % n_tots = [cyc_n_hist, acyc_n_hist];
% plot(cyc_n_hist)
% hold on
% plot(acyc_n_hist, 'r')
% legend('cyclonic','anticyclonic', 'Location','North')
% xlabel('Eddy Pixel Count')
% ylabel('Count')
% title('Northern Hemisphere')
% 
% subplot(2,1,2);
% cyc_s_res = IBTrACS_1992_2010.EddyPixelCount(cyc_s);
% acyc_s_res = IBTrACS_1992_2010.EddyPixelCount(acyc_s);
% cyc_s_hist = histc(cyc_s_res,bins);
% acyc_s_hist = histc(acyc_s_res, bins);
% % s_tots = [cyc_s_hist, acyc_s_hist];
% plot(cyc_s_hist)
% hold on
% plot(acyc_s_hist, 'r')
% legend('cyclonic','anticyclonic', 'Location','North')
% xlabel('Eddy Pixel Count')
% ylabel('Count')
% title('Southern Hemisphere')
% 
% %% 26th-50th displacements
% cyc_n = bitand(cyc_n_idx, disp_50_idx);
% acyc_n = bitand(acyc_n_idx, disp_50_idx);
% cyc_s = bitand(cyc_s_idx, disp_50_idx);
% acyc_s = bitand(acyc_s_idx, disp_50_idx);
% 
% figure;
% set(gcf,'Name','Subset of 26th-50th percentile of hurricane translation speed');
% subplot(2,1,1);
% cyc_n_res = IBTrACS_1992_2010.EddyPixelCount(cyc_n);
% acyc_n_res = IBTrACS_1992_2010.EddyPixelCount(acyc_n);
% cyc_n_hist = histc(cyc_n_res,bins);
% acyc_n_hist = histc(acyc_n_res, bins);
% % n_tots = [cyc_n_hist, acyc_n_hist];
% plot(cyc_n_hist)
% hold on
% plot(acyc_n_hist, 'r')
% legend('cyclonic','anticyclonic', 'Location','North')
% xlabel('Eddy Pixel Count')
% ylabel('Count')
% title('Northern Hemisphere')
% 
% subplot(2,1,2);
% cyc_s_res = IBTrACS_1992_2010.EddyPixelCount(cyc_s);
% acyc_s_res = IBTrACS_1992_2010.EddyPixelCount(acyc_s);
% cyc_s_hist = histc(cyc_s_res,bins);
% acyc_s_hist = histc(acyc_s_res, bins);
% % s_tots = [cyc_s_hist, acyc_s_hist];
% plot(cyc_s_hist)
% hold on
% plot(acyc_s_hist, 'r')
% legend('cyclonic','anticyclonic', 'Location','North')
% xlabel('Eddy Pixel Count')
% ylabel('Count')
% title('Southern Hemisphere')
% 
% %% 51st-75th displacements
% cyc_n = bitand(cyc_n_idx, disp_75_idx);
% acyc_n = bitand(acyc_n_idx, disp_75_idx);
% cyc_s = bitand(cyc_s_idx, disp_75_idx);
% acyc_s = bitand(acyc_s_idx, disp_75_idx);
% 
% figure;
% set(gcf,'Name','Subset of 51st-75th percentile of hurricane translation speed');
% subplot(2,1,1);
% cyc_n_res = IBTrACS_1992_2010.EddyPixelCount(cyc_n);
% acyc_n_res = IBTrACS_1992_2010.EddyPixelCount(acyc_n);
% cyc_n_hist = histc(cyc_n_res,bins);
% acyc_n_hist = histc(acyc_n_res, bins);
% % n_tots = [cyc_n_hist, acyc_n_hist];
% plot(cyc_n_hist)
% hold on
% plot(acyc_n_hist, 'r')
% legend('cyclonic','anticyclonic', 'Location','North')
% xlabel('Eddy Pixel Count')
% ylabel('Count')
% title('Northern Hemisphere')
% 
% subplot(2,1,2);
% cyc_s_res = IBTrACS_1992_2010.EddyPixelCount(cyc_s);
% acyc_s_res = IBTrACS_1992_2010.EddyPixelCount(acyc_s);
% cyc_s_hist = histc(cyc_s_res,bins);
% acyc_s_hist = histc(acyc_s_res, bins);
% % s_tots = [cyc_s_hist, acyc_s_hist];
% plot(cyc_s_hist)
% hold on
% plot(acyc_s_hist, 'r')
% legend('cyclonic','anticyclonic', 'Location','North')
% xlabel('Eddy Pixel Count')
% ylabel('Count')
% title('Southern Hemisphere')
% 
% %% 76th-100th displacements
% cyc_n = bitand(cyc_n_idx, disp_100_idx);
% acyc_n = bitand(acyc_n_idx, disp_100_idx);
% cyc_s = bitand(cyc_s_idx, disp_100_idx);
% acyc_s = bitand(acyc_s_idx, disp_100_idx);
% 
% figure;
% set(gcf,'Name','Subset of 76th-100th percentile of hurricane translation speed');
% subplot(2,1,1);
% cyc_n_res = IBTrACS_1992_2010.EddyPixelCount(cyc_n);
% acyc_n_res = IBTrACS_1992_2010.EddyPixelCount(acyc_n);
% cyc_n_hist = histc(cyc_n_res,bins);
% acyc_n_hist = histc(acyc_n_res, bins);
% % n_tots = [cyc_n_hist, acyc_n_hist];
% plot(cyc_n_hist)
% hold on
% plot(acyc_n_hist, 'r')
% legend('cyclonic','anticyclonic', 'Location','North')
% xlabel('Eddy Pixel Count')
% ylabel('Count')
% title('Northern Hemisphere')
% 
% subplot(2,1,2);
% cyc_s_res = IBTrACS_1992_2010.EddyPixelCount(cyc_s);
% acyc_s_res = IBTrACS_1992_2010.EddyPixelCount(acyc_s);
% cyc_s_hist = histc(cyc_s_res,bins);
% acyc_s_hist = histc(acyc_s_res, bins);
% % s_tots = [cyc_s_hist, acyc_s_hist];
% plot(cyc_s_hist)
% hold on
% plot(acyc_s_hist, 'r')
% legend('cyclonic','anticyclonic', 'Location','North')
% xlabel('Eddy Pixel Count')
% ylabel('Count')
% title('Southern Hemisphere')