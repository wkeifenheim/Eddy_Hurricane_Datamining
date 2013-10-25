%Requires EBTracks_by_eddy_v3.mat to be loaded


for i = 9: 22
    
    lower = round(min(double(ebtrkatlc_cyc(:,i))));
    upper = round(max(double(ebtrkatlc_cyc(:,i))));
    
    bincounts_acyc = histc(double(ebtrkatlc_acyc(:,i)),lower:5:upper);
    bincounts_cyc = histc(double(ebtrkatlc_cyc(:,i)),lower:5:upper);
    bincounts_miss = histc(double(ebtrkatlc_miss(:,i)),lower:5:upper);
    tot_bin = [bincounts_acyc, bincounts_cyc, bincounts_miss];
    figure
    bar(lower:5:upper, tot_bin, 'grouped')

end