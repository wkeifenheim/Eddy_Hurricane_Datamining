%populate a table of the ratios between acyc/cyc eddies by how old they
%were upon interaction (or being created by) a hurricane/tropical storm..
% 1-20 weeks seems sufficient, at 21 weeks there are only 93 hurricane
% interactions and EddyAge > 20 accounts for only 4.5% of total

%Columns: Count, % of total (21151), acyc/cyc ratio
results = zeros(20,3);

wait_h = waitbar(0,'progress');
for i = 1 : 20
    results(i,1) = sum(IBTrACS_1992_2010.EddyAge(:) == i);
    results(i,2) = results(i,1) / 21151;
    num_acyc = sum(bitand(IBTrACS_1992_2010.EddyAge(:) == i,...
        IBTrACS_1992_2010.EddyClass(:) == 1));
    num_cyc = sum(bitand(IBTrACS_1992_2010.EddyAge(:) == i,...
        IBTrACS_1992_2010.EddyClass(:) == -1));
    results(i,3) = num_cyc / num_acyc;
    waitbar(i/20);
end
delete(wait_h);

names = {'Count       ';'% of total  ';'cyc_acyc_ratio'};
eddy_ratio_for_hurr_interaction = dataset({results, names{:}});

f1 = figure;
p1 = scatter([1:20],eddy_ratio_for_hurr_interaction.acyc_cyc_ratio);
title('Ratio of cyc/acyc eddies, per eddy age, during hurricane interaction');
lsline
ylabel('cyc/acyc ratio');
xlabel('eddy age (weeks)');
legend('ratio at week(x)','least-squares line');

eddy_age_totals = zeros(134,1);
for i = 1 : 134
    eddy_age_totals(i) = sum(IBTrACS_1992_2010.EddyAge(:) == i);
end
f2 = figure;
p2 = plot(eddy_age_totals);
title('Histogram of eddy ages at hurricane interaction');
ylabel('count');
xlabel('eddy age (weeks)');
f3 = figure;

p3 = boxplot(IBTrACS_1992_2010.EddyAge);
title('Box plot of eddy age at hurricane interaction');