%Requires EBTracks_by_eddy_v3.mat to be loaded
%Normalized Version

size_acyc = size(ebtrkatlc_acyc,1);
size_cyc = size(ebtrkatlc_cyc,1);
size_miss = size(ebtrkatlc_miss,1);

for i = 21 : 22
    
    lower = round(min(double(ebtrkatlc_cyc(:,i))));
    upper = round(max(double(ebtrkatlc_cyc(:,i))));
    
    bincounts_acyc = histc(double(ebtrkatlc_acyc(:,i)),lower:.25:upper) / size_acyc;
    bincounts_cyc = histc(double(ebtrkatlc_cyc(:,i)),lower:.25:upper) / size_cyc;
    bincounts_miss = histc(double(ebtrkatlc_miss(:,i)),lower:.25:upper) / size_miss;
    tot_bin = [bincounts_acyc, bincounts_cyc, bincounts_miss];
    figure
    bar(lower:.25:upper, tot_bin, 'grouped')

end