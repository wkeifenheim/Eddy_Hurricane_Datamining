% wait_h = waitbar(0,'progress..');
% 
% pruned_ibtrk = dataset();
% for i = 1 : 66280
%     isovec = datevec(cellstr(IBTrACS_All_1992_2010(i,7)));
%     hour = isovec(4);
%     if(mod(hour,6) == 0)
%         pruned_ibtrk = [pruned_ibtrk; IBTrACS_All_1992_2010(i,:)];
%     end
%     waitbar(i/66280)
% end
% delete(wait_h)
% 

% assumes non-6 hour timesteps (and non zero-minutes/seconds) have been
% pruned from the data
dates = datevec(IBTrACS_1993_2012.ISO_time);

% find missing days..
total = size(IBTrACS_1993_2012,1);
bad_tc_tracks = false(total,1);
cur_hur = IBTrACS_1993_2012.Serial_Num(1);
cur_day = dates(1,3);
for i = 2 : total
    if(strcmp(IBTrACS_1993_2012.Serial_Num(i),cur_hur))
        if(dates(i,3) - cur_day > 1)
            bad_tc_tracks(i) = true;
        else
            cur_day = dates(i,3);
        end
    else
        cur_hur = IBTrACS_1993_2012.Serial_Num(i);
        cur_day = dates(i,3);
    end
end