%plot change of Azimuth after eddy interactions

stop = size(IBTrACS_1992_2010_NewI,1);
%including non-unique encounters
cyc_azd1_unique = false(stop,1);
acyc_azd1_unique = false(stop,1);
wait_h = waitbar(0','progress:all..');
cur_hur = IBTrACS_1992_2010_NewI.Serial_Num(1);
for i = 1 : stop
    if(~strcmp(IBTrACS_1992_2010_NewI.Serial_Num(i), cur_hur))
        cur_hur = IBTrACS_1992_2010_NewI.Serial_Num(i);
    end
        
    if(IBTrACS_1992_2010_NewI.EddyClass(i) == -1 && ...
            strcmp(IBTrACS_1992_2010_NewI.Serial_Num(i+1),cur_hur))
        cyc_azd1_unique(i+1) = true;

    elseif(IBTrACS_1992_2010_NewI.EddyClass(i) == 1 && ...
            strcmp(IBTrACS_1992_2010_NewI.Serial_Num(i+1),cur_hur))
        acyc_azd1_unique(i+1) = true;

    end
    waitbar(i/stop)
end
delete(wait_h)

bins = -180:20:180;
cyc_hist = histc(IBTrACS_1992_2010.Az_d1(cyc_azd1_unique),bins);
acyc_hist = histc(IBTrACS_1992_2010.Az_d1(acyc_azd1_unique),bins);
tots = [cyc_hist, acyc_hist];
bar(bins, tots, 'histc')
legend('cyclonic','anticyclonic')
xlabel('Change in Azimuth (degrees)')
ylabel('count')
title('Change of Azimuth after eddy encounter (unique)')