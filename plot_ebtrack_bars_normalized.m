%Requires EBTracks_by_eddy_v3.mat to be loaded
%Normalized Version

size_acyc = size(ebtrkatlc_acyc,1);
size_cyc = size(ebtrkatlc_cyc,1);
size_miss = size(ebtrkatlc_miss,1);

for i = 23 : 23
    
    lower = round(min(double(ebtrkatlc_cyc(:,i))));
    upper = round(max(double(ebtrkatlc_cyc(:,i))));
    increment = 0.25;
    
    bincounts_acyc = histc(double(ebtrkatlc_acyc(:,i)),lower:increment:upper) / size_acyc;
    bincounts_cyc = histc(double(ebtrkatlc_cyc(:,i)),lower:increment:upper) / size_cyc;
    bincounts_miss = histc(double(ebtrkatlc_miss(:,i)),lower:increment:upper) / size_miss;
    tot_bin = [bincounts_acyc, bincounts_cyc, bincounts_miss];
    figure
    bar(lower:increment:upper, tot_bin, 'histc')
    legend('Acyc','Cyc','Miss')
    colormap([1 0 0;0 1 0; 0 0 1])
    
    binsize_str = strcat('Binsize = ', num2str(increment));
    title(binsize_str)
end