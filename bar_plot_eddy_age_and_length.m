%binsize of about 10 for eddyAge and trackLength plotting...

%Bin ends for track length:
%   [5:10:135, 149]

%Bin ends for eddy age:
%   [1:10:121, 134]
cla

%preamble...
% cyc_idx = IBTrACS_five_plus.EddyClass(:) == -1;
% acyc_idx = IBTrACS_five_plus.EddyClass(:) == 1;
% ibt_cyc = IBTrACS_five_plus(cyc_idx,:);
% ibt_acyc = IBTrACS_five_plus(acyc_idx,:);
% ibt_cyc = [ibt_cyc.EddyAge(:), ibt_cyc.EddyTrackLength(:)];
% ibt_acyc = [ibt_acyc.EddyAge(:), ibt_acyc.EddyTrackLength(:)];

a = 5;
b = 15;
bins = 1:1:b;

cyc_idx = (ibt_cyc(:,2) >= a) == (ibt_cyc(:,2) <= b);
acyc_idx = (ibt_acyc(:,2) >= a) == (ibt_acyc(:,2) <= b);
cyc = ibt_cyc(cyc_idx,:);
acyc = ibt_acyc(acyc_idx,:);
%subdivide until all track lengths are represented in different rows...

size(cyc,1)
size(acyc,1)
% cyc_total = cyc_total + size(cyc,1);
% acyc_total = acyc_total + size(acyc,1);
% bin_cyc = zeros(15,15);
% for i = 5 : 15
%     tr_idx = (cyc(:,2) == i);
%     sub_cyc = cyc(tr_idx,1);
%     bin_cyc(i,:) = histc(sub_cyc, bins);
% end
bin_acyc = zeros(15,15);
for i = 5 : 15
    tr_idx = (acyc(:,2) == i);
    sub_acyc = acyc(tr_idx,1);
    bin_acyc(i,:) = histc(sub_acyc, bins);
end

bin_cyc = histc(cyc,bins);%/size(cyc,1);
bin_acyc = histc(acyc,bins);%/size(acyc,1);
both_bins = [bin_cyc', bin_acyc'];
bar(bins, both_bins);
xlabel('Age of eddy during hurricane interaction');
ylabel('Number');
legend('Cyclonic','Anticyclonic', 'Location','North');
title_str = strcat('Track Lengths [', num2str(a), ',', num2str(b),...
    ']');
title(title_str);