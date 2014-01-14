%binsize of about 10 for eddyAge and trackLength plotting...

%Bin ends for track length:
%   [5:10:135, 149]

%Bin ends for eddy age:
%   [1:10:121, 134]
cla
a = 136;
b = 149;
bins = 1:3:b;

cyc_idx = (ibt_cyc(:,2) >= a) == (ibt_cyc(:,2) <= b);
acyc_idx = (ibt_acyc(:,2) >= a) == (ibt_acyc(:,2) <= b);
cyc = ibt_cyc(cyc_idx,1);
acyc = ibt_acyc(acyc_idx,1);
bin_cyc = histc(cyc,bins)' /size(cyc,1);
bin_acyc = histc(acyc,bins)' /size(acyc,1);
both_bins = [bin_cyc, bin_acyc];
bar(bins, both_bins, 'histc');
xlabel('Age of eddy during hurricane interaction');
ylabel('Percent');
legend('Cyclonic','Anticyclonic', 'Location','North');
title_str = strcat('Track Lengths [', num2str(a), ',', num2str(b),...
    '] NORMALIZED');
title(title_str);