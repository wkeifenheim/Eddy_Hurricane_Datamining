%Requires IBTrACS_v1 to be loaded
%Normalized Version

size_acyc = size(IBTrACS_acyc,1);
size_cyc = size(IBTrACS_cyc,1);
size_miss = size(IBTrACS_miss,1);

for i = 19 : 23
    
    lower = round(min(double(IBTrACS_cyc(:,i))));
    upper = round(max(double(IBTrACS_cyc(:,i))));
    increment = 5;
    
    bincounts_acyc = histc(double(IBTrACS_acyc(:,i)),lower:increment:upper) / size_acyc;
    bincounts_cyc = histc(double(IBTrACS_cyc(:,i)),lower:increment:upper) / size_cyc;
    bincounts_miss = histc(double(IBTrACS_miss(:,i)),lower:increment:upper) / size_miss;
    tot_bin = [bincounts_acyc, bincounts_cyc, bincounts_miss];
    figure
    plot_h = bar(lower:increment:upper, tot_bin, 'histc');
    legend('Acyc','Cyc','Miss')
    colormap([1 0 0;0 1 0; 0 0 1])
    
    binsize_str = strcat('(binsize = ', num2str(increment), ')');
    title(binsize_str)
%     plot_h.xlabel = xlabel('kt (knots)');
    plot_h.ylabel = ylabel('Percent');
    delete(gca)
end