%plot changes of Azimuth for time-steps that do not interact with eddies

stop = size(IBTrACS_1992_2010,1);
%including non-unique encounters
non_idx = false(stop,1);
wait_h = waitbar(0','progress:all..');
cur_hur = IBTrACS_1992_2010.Serial_Num(1);
for i = 1 : stop
    if(~strcmp(IBTrACS_1992_2010_NewI.Serial_Num(i), cur_hur))
        cur_hur = IBTrACS_1992_2010_NewI.Serial_Num(i);
    end
        
    if(isnan(IBTrACS_1992_2010_NewI.EddyClass(i)) && ...
            strcmp(IBTrACS_1992_2010_NewI.Serial_Num(i+1),cur_hur))
        non_idx(i+1) = true;
    end
    waitbar(i/stop)
end
delete(wait_h)

bins = -180:20:180;
non_hist = histc(IBTrACS_1992_2010.Az_d1(non_idx),bins);
figure;
bar(bins, non_hist, 'histc')
legend('non-interactions')
xlabel('Change in Azimuth (degrees)')
ylabel('count')
title('Change of Azimuth (non-interactions)')