%populate a table of the ratios between cyc/acyc eddies by how old they
%were upon interaction (or being created by) a hurricane/tropical storm..
% 1-20 weeks seems sufficient, at 21 weeks there are only 93 hurricane
% interactions and EddyAge > 20 accounts for only 4.5% of total

load('/panfs/roc/groups/6/kumarv/keifenhe/Documents/Datasets/with_daily_eddies/IBTrACS_1992_2010_daily.mat');

%Columns: Count, % of total (21106), acyc/cyc ratio
results = zeros(20,5);

labels = {'Count','Percentge','Ratio','NumAtLeast2Weeks','2WeekRatio'};

wait_h = waitbar(0,'progress');
for i = 1 : 140
    results(i,1) = sum(IBTrACS_1992_2010_daily.EddyAge(:) == i);
    results(i,2) = results(i,1) / 21106;
    num_acyc = sum(bitand(IBTrACS_1992_2010_daily.EddyAge(:) == i,...
        IBTrACS_1992_2010_daily.EddyClass(:) == 1));
    num_cyc = sum(bitand(IBTrACS_1992_2010_daily.EddyAge(:) == i,...
        IBTrACS_1992_2010_daily.EddyClass(:) == -1));
    results(i,3) = num_cyc / num_acyc;
    results(i,4) = sum(bitand(IBTrACS_1992_2010_daily.EddyAge(:) == i,IBTrACS_1992_2010_daily.EddyTrackLifetime >= 14));
    num_acyc = sum(bitand(bitand(IBTrACS_1992_2010_daily.EddyAge(:) == i,...
        IBTrACS_1992_2010_daily.EddyClass(:) == 1), IBTrACS_1992_2010_daily.EddyTrackLifetime >= 14));
    num_cyc = sum(bitand(bitand(IBTrACS_1992_2010_daily.EddyAge(:) == i,...
        IBTrACS_1992_2010_daily.EddyClass(:) == -1), IBTrACS_1992_2010_daily.EddyTrackLifetime >= 14));
    results(i,5) = num_cyc / num_acyc;
    waitbar(i/140);
end
delete(wait_h);

eddy_age_ratios = dataset({results,labels{:}});

names = {'Count       ';'% of total  ';'cyc_acyc_ratio'};
eddy_ratio_for_hurr_interaction = dataset({results, names{:}});

f1 = figure;
p1 = scatter([1:140],eddy_ratio_for_hurr_interaction.cyc_acyc_ratio);
title('Ratio of cyc/acyc eddies, per eddy age, during hurricane interaction');
lsline
ylabel('cyc/acyc ratio');
xlabel('eddy age (days)');
legend('ratio at day(x)','least-squares line');

eddy_age_totals = zeros(134,2); %columns: [anticylonic, cyclonic]
for i = 1 : 506
    eddy_age_totals(i,1) = sum(bitand(IBTrACS_1992_2010_daily.EddyAge(:) == i,...
        IBTrACS_1992_2010_daily.EddyClass(:) == 1));
    eddy_age_totals(i,2) = sum(bitand(IBTrACS_1992_2010_daily.EddyAge(:) == i,...
        IBTrACS_1992_2010_daily.EddyClass(:) == -1));
end
f2 = figure;
p2 = plot(eddy_age_totals(:,1));
hold on
p2_5 = plot(eddy_age_totals(:,2),'r');
title('Histogram of eddy ages at hurricane interaction');
ylabel('count');
xlabel('eddy age (days)');
legend('anticyclonic','cyclonic')
f3 = figure;

IBTrACS_1992_2010_daily_eddies = IBTrACS_1992_2010_daily(~isnan(IBTrACS_1992_2010_daily.EddyClass(:)),:);
type = cell(size(IBTrACS_1992_2010_daily_eddies,1),1);

for i = 1 : size(IBTrACS_1992_2010_daily_eddies,1)
    if(IBTrACS_1992_2010_daily_eddies.EddyClass(i) == -1)
        type{i} = 'cyclonic';
    elseif(IBTrACS_1992_2010_daily_eddies.EddyClass(i) == 1)
        type{i} = 'anticyclonic';
    end
end

p3 = boxplot(IBTrACS_1992_2010_daily_eddies.EddyAge, type);
title('Box plot of eddy age at hurricane interaction');
ylabel('age (day)');