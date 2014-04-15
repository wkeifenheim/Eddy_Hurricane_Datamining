% produces several plots describing the distribution of hurricane characteristic
% deltas when encountering eddies.  Global and by basin. WEEKLY EDDIES
%%%%%% NAVIGATE TO DESIRED SAVE DIRECTORY FIRST, AND RUN BY HIGHLIGHTING
%%%%%% AND RIGHT CLICKING "EVALUATE SELECTION"

% load('/panfs/roc/groups/6/kumarv/keifenhe/Documents/Datasets/with_daily_eddies/IBTrACS_1992_2010_daily.mat')
eddies= IBTrACS_1992_2010(~isnan(IBTrACS_1992_2010.EddyClass(:)),:); %dataset with only timesteps that encountered eddies
cyc_eddies = eddies(eddies.EddyClass(:) == -1,:);
acyc_eddies = eddies(eddies.EddyClass(:) == 1,:);

% title for final table (maybe)
titles = cell(9,1);
titles(1) = cellstr('Northern Hemisphere');
titles(2) = cellstr('Southern Hemisphere');
titles(3) = cellstr('North Atlantic');
titles(4) = cellstr('South Atlantic');
titles(5) = cellstr('West Pacific');
titles(6) = cellstr('East Pacific');
titles(7) = cellstr('South Pacific');
titles(8) = cellstr('North Indian');
titles(9) = cellstr('South Indian');

% for use with strcmp
initials = cell(9,1);
initials(1) = cellstr('NH');
initials(2) = cellstr('SH');
initials(3) = cellstr('NA');
initials(4) = cellstr('SA');
initials(5) = cellstr('WP');
initials(6) = cellstr('EP');
initials(7) = cellstr('SP');
initials(8) = cellstr('NI');
initials(9) = cellstr('SI');

%% Hurricane displacement_d1, git'em.
a = min(eddies.Displacement_d1(:));
b = max(eddies.Displacement_d1(:));
bins = a:25:b;

f_global = figure;
set(gcf,'Name','Global Hurricane Translation between  t_i & t_{i-1}');
cyc_n_res = cyc_eddies.Displacement_d1(:);
acyc_n_res = acyc_eddies.Displacement_d1(:);
cyc_n_hist = histc(cyc_n_res,bins);
acyc_n_hist = histc(acyc_n_res, bins);
plot(bins, cyc_n_hist)
hold on
plot(bins, acyc_n_hist, 'r')
legend('cyclonic','anticyclonic', 'Location','North')
xlabel('Translational Movement (km)')
ylabel('Count')
title('Global Hurricane Translation between  t_i & t_{i-1}')
saveas(f_global,strcat('hurr_','disp','_global.eps'),'epsc');

f(1) = figure;
set(gcf,'Name',strcat('Hurricane Translation between  t_i & t_{i-1} for Location:',initials{1}));
cyc_n_res = cyc_eddies.Displacement_d1(cyc_eddies.Latitude_for_mapping(:) >= 0);
acyc_n_res = acyc_eddies.Displacement_d1(acyc_eddies.Latitude_for_mapping(:) >= 0);
cyc_n_hist = histc(cyc_n_res,bins);
acyc_n_hist = histc(acyc_n_res, bins);
plot(bins, cyc_n_hist)
hold on
plot(bins, acyc_n_hist, 'r')
legend('cyclonic','anticyclonic', 'Location','North')
xlabel('Translational Movement (km)')
ylabel('Count')
title(strcat('Hurricane Translation between  t_i & t_{i-1} in: ',initials{1}))
saveas(f(1),strcat('hurr_','disp','_NH.eps'),'epsc');

f(2) = figure;
set(gcf,'Name',strcat('Hurricane Translation between  t_i & t_{i-1} for Location:',initials{2}));
cyc_n_res = cyc_eddies.Displacement_d1(cyc_eddies.Latitude_for_mapping(:) < 0);
acyc_n_res = acyc_eddies.Displacement_d1(acyc_eddies.Latitude_for_mapping(:) < 0);
cyc_n_hist = histc(cyc_n_res,bins);
acyc_n_hist = histc(acyc_n_res, bins);
plot(bins, cyc_n_hist)
hold on
plot(bins, acyc_n_hist, 'r')
legend('cyclonic','anticyclonic', 'Location','North')
xlabel('Translational Movement (km)')
ylabel('Count')
title(strcat('Hurricane Translation between  t_i & t_{i-1} in: ',initials{2}))
saveas(f(2),strcat('hurr_','disp','_SH.eps'),'epsc');

for i = 3 : 9
    f(i) = figure;
    set(gcf,'Name',strcat('Hurricane Translation between  t_i & t_{i-1} for Location:',initials{i}));
    cyc_n_res = cyc_eddies.Displacement_d1(strcmp(cyc_eddies.Basin(:),initials(i)));
    acyc_n_res = acyc_eddies.Displacement_d1(strcmp(acyc_eddies.Basin(:),initials(i)));
    cyc_n_hist = histc(cyc_n_res,bins);
    acyc_n_hist = histc(acyc_n_res, bins);
    plot(bins, cyc_n_hist)
    hold on
    plot(bins, acyc_n_hist, 'r')
    legend('cyclonic','anticyclonic', 'Location','North')
    xlabel('Translational Movement (km)')
    ylabel('Count')
    title(strcat('Hurricane Translation between  t_i & t_{i-1} in: ',initials{i}))
    saveas(f(2),strcat('hurr_','disp','_',initials{i},'.eps'),'epsc');
end
waitfor(msgbox('click OK to close all current figures and continue'));
close all

%% Hurricane wind_d1, git'em.
a = min(eddies.Wind_d1(:));
b = max(eddies.Wind_d1(:));
bins = -100:5:80;

f_global = figure;
set(gcf,'Name','Global Hurricane Windspeed Delta between  t_i & t_{i-1}');
cyc_n_res = cyc_eddies.Wind_d1(:);
acyc_n_res = acyc_eddies.Wind_d1(:);
cyc_n_hist = histc(cyc_n_res,bins);
acyc_n_hist = histc(acyc_n_res, bins);
plot(bins, cyc_n_hist)
hold on
plot(bins, acyc_n_hist, 'r')
legend('cyclonic','anticyclonic', 'Location','East')
xlabel('Change in Windspeed (kt)')
ylabel('Count')
title('Global Hurricane Windspeed Delta between  t_i & t_{i-1}')
saveas(f_global,strcat('hurr_','wind_d1','_global.eps'),'epsc');

f(1) = figure;
set(gcf,'Name',strcat('Hurricane Windspeed Delta between  t_i & t_{i-1} for Location:',initials{1}));
cyc_n_res = cyc_eddies.Wind_d1(cyc_eddies.Latitude_for_mapping(:) >= 0);
acyc_n_res = acyc_eddies.Wind_d1(acyc_eddies.Latitude_for_mapping(:) >= 0);
cyc_n_hist = histc(cyc_n_res,bins);
acyc_n_hist = histc(acyc_n_res, bins);
plot(bins, cyc_n_hist)
hold on
plot(bins, acyc_n_hist, 'r')
legend('cyclonic','anticyclonic', 'Location','East')
xlabel('Change in Windspeed (kt)')
ylabel('Count')
title(strcat('Hurricane Windspeed Delta between  t_i & t_{i-1} in: ',initials{1}))
saveas(f(1),strcat('hurr_','wind_d1','_NH.eps'),'epsc');

f(2) = figure;
set(gcf,'Name',strcat('Hurricane Windspeed Delta between  t_i & t_{i-1} for Location:',initials{2}));
cyc_n_res = cyc_eddies.Wind_d1(cyc_eddies.Latitude_for_mapping(:) < 0);
acyc_n_res = acyc_eddies.Wind_d1(acyc_eddies.Latitude_for_mapping(:) < 0);
cyc_n_hist = histc(cyc_n_res,bins);
acyc_n_hist = histc(acyc_n_res, bins);
plot(bins, cyc_n_hist)
hold on
plot(bins, acyc_n_hist, 'r')
legend('cyclonic','anticyclonic', 'Location','East')
xlabel('Change in Windspeed (kt)')
ylabel('Count')
title(strcat('Hurricane Windspeed Delta between  t_i & t_{i-1} in: ',initials{2}))
saveas(f(2),strcat('hurr_','wind_d1','_SH.eps'),'epsc');

for i = 3 : 9
    f(i) = figure;
    set(gcf,'Name',strcat('Hurricane Windspeed Delta between  t_i & t_{i-1} for Location:',initials{i}));
    cyc_n_res = cyc_eddies.Wind_d1(strcmp(cyc_eddies.Basin(:),initials(i)));
    acyc_n_res = acyc_eddies.Wind_d1(strcmp(acyc_eddies.Basin(:),initials(i)));
    cyc_n_hist = histc(cyc_n_res,bins);
    acyc_n_hist = histc(acyc_n_res, bins);
    plot(bins, cyc_n_hist)
    hold on
    plot(bins, acyc_n_hist, 'r')
    legend('cyclonic','anticyclonic', 'Location','East')
    xlabel('Change in Windspeed (kt)')
    ylabel('Count')
    title(strcat('Hurricane Windspeed Delta between  t_i & t_{i-1} in: ',initials{i}))
    saveas(f(i),strcat('hurr_','wind_d1','_',initials{i},'.eps'),'epsc');
end
waitfor(msgbox('click OK to close all current figures and continue'));
close all

%% Hurricane pres_d1, git'em.
a = min(eddies.Pres_d1(:));
b = max(eddies.Pres_d1(:));
bins = a:b;

f_global = figure;
set(gcf,'Name','Global Hurricane Pressure Delta between  t_i & t_{i-1}');
cyc_n_res = cyc_eddies.Pres_d1(:);
acyc_n_res = acyc_eddies.Pres_d1(:);
cyc_n_hist = histc(cyc_n_res,bins);
acyc_n_hist = histc(acyc_n_res, bins);
plot(bins, cyc_n_hist)
hold on
plot(bins, acyc_n_hist, 'r')
legend('cyclonic','anticyclonic', 'Location','East')
xlabel('Change in Pressure (mbar)')
ylabel('Count')
title('Global Hurricane Pressure Delta between  t_i & t_{i-1}')
saveas(f_global,strcat('hurr_','pres_d1','_global.eps'),'epsc');

f(1) = figure;
set(gcf,'Name',strcat('Hurricane Pressure Delta between  t_i & t_{i-1} for Location:',initials{1}));
cyc_n_res = cyc_eddies.Pres_d1(cyc_eddies.Latitude_for_mapping(:) >= 0);
acyc_n_res = acyc_eddies.Pres_d1(acyc_eddies.Latitude_for_mapping(:) >= 0);
cyc_n_hist = histc(cyc_n_res,bins);
acyc_n_hist = histc(acyc_n_res, bins);
plot(bins, cyc_n_hist)
hold on
plot(bins, acyc_n_hist, 'r')
legend('cyclonic','anticyclonic', 'Location','East')
xlabel('Change in Pressure (mbar)')
ylabel('Count')
title(strcat('Hurricane Pressure Delta between  t_i & t_{i-1} in: ',initials{1}))
saveas(f(1),strcat('hurr_','pres_d1','_NH.eps'),'epsc');

f(2) = figure;
set(gcf,'Name',strcat('Hurricane Pressure Delta between  t_i & t_{i-1} for Location:',initials{2}));
cyc_n_res = cyc_eddies.Pres_d1(cyc_eddies.Latitude_for_mapping(:) < 0);
acyc_n_res = acyc_eddies.Pres_d1(acyc_eddies.Latitude_for_mapping(:) < 0);
cyc_n_hist = histc(cyc_n_res,bins);
acyc_n_hist = histc(acyc_n_res, bins);
plot(bins, cyc_n_hist)
hold on
plot(bins, acyc_n_hist, 'r')
legend('cyclonic','anticyclonic', 'Location','East')
xlabel('Change in Pressure (mbar)')
ylabel('Count')
title(strcat('Hurricane Pressure Delta between  t_i & t_{i-1} in: ',initials{2}))
saveas(f(2),strcat('hurr_','pres_d1','_SH.eps'),'epsc');

for i = 3 : 9
    f(i) = figure;
    set(gcf,'Name',strcat('Hurricane Pressure Delta between  t_i & t_{i-1} for Location:',initials{i}));
    cyc_n_res = cyc_eddies.Pres_d1(strcmp(cyc_eddies.Basin(:),initials(i)));
    acyc_n_res = acyc_eddies.Pres_d1(strcmp(acyc_eddies.Basin(:),initials(i)));
    cyc_n_hist = histc(cyc_n_res,bins);
    acyc_n_hist = histc(acyc_n_res, bins);
    plot(bins, cyc_n_hist)
    hold on
    plot(bins, acyc_n_hist, 'r')
    legend('cyclonic','anticyclonic', 'Location','East')
    xlabel('Change in Pressure (mbar)')
    ylabel('Count')
    title(strcat('Hurricane Pressure Delta between  t_i & t_{i-1} in: ',initials{i}))
    saveas(f(i),strcat('hurr_','pres_d1','_',initials{i},'.eps'),'epsc');
end
waitfor(msgbox('click OK to close all current figures and continue'));
close all