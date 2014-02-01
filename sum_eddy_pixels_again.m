list = cell(1915,1);
j = 1;
cur_hur = IBTrACS_1992_2010.Serial_Num(1);
rem_ed_type = NaN;
rem_ed_idx = NaN;
rem_ed_count = 0;
pppp = NaN;
hhh = NaN;
e = NaN;

cur_hur = IBTrACS_1992_2010.Serial_Num(1);
wait_h = waitbar(0,'progress');

for i = 1 : 60819
    
    %advance the hurricane counter if needed..
    if(~strcmp(cur_hur, IBTrACS_1992_2010.Serial_Num(i)))
        j = j + 1;
        cur_hur = IBTrACS_1992_2010.Serial_Num(i);
        rem_ed_type = NaN;
        rem_ed_idx = NaN;
        rem_ed_count = 0;
        pppp = NaN;
        hhh = NaN;
        e = NaN;
    end
    
    if(rem_ed_count == 0) %not accumulating an eddy interaction count....
        if(~isnan(IBTrACS_1992_2010.EddyClass(i)))
            rem_ed_type = IBTrACS_1992_2010.EddyClass(i);
            rem_ed_idx = IBTrACS_1992_2010.EddyIdx(i);
            rem_ed_count = 1;
            pppp = num2str(IBTrACS_1992_2010.EddyPixelCount(i));
            hhh = num2str(IBTrACS_1992_2010.HurricaneAge(i) / 6);
            if(rem_ed_type == -1)
                e = 'C';
            else
                e = 'A';
            end
            if(rem_ed_type ~= IBTrACS_1992_2010.EddyClass(i+1) ||...
                    rem_ed_idx ~= IBTrACS_1992_2010.EddyIdx(i+1))
                
                count = num2str(rem_ed_count);
                list_str = strcat(hhh, ':', e, ':', count, ':', pppp);
                list{j} = strcat(list{j}, {' '}, list_str);
                list_str = strcat(hhh, ':', e, ':', pppp);
                rem_ed_type = NaN;
                rem_ed_idx = NaN;
                rem_ed_count = 0;
                pppp = NaN;
                hhh = NaN;
                e = NaN;
            end
            
            
        end
    else %currently accumulating visits to an eddy
        if(rem_ed_type == IBTrACS_1992_2010.EddyClass(i) &&...
                rem_ed_idx == IBTrACS_1992_2010.EddyIdx(i))
            
            rem_ed_count = rem_ed_count + 1;
            
            if(rem_ed_type ~= IBTrACS_1992_2010.EddyClass(i+1) ||...
                    rem_ed_idx ~= IBTrACS_1992_2010.EddyIdx(i+1))
                
                count = num2str(rem_ed_count);
                list_str = strcat(hhh, ':', e, ':', count, ':', pppp);
                list{j} = strcat(list{j}, {' '}, list_str);
                list_str = strcat(hhh, ':', e, ':', pppp);
                rem_ed_type = NaN;
                rem_ed_idx = NaN;
                rem_ed_count = 0;
                pppp = NaN;
                hhh = NaN;
                e = NaN;
            end
        else
            rem_ed_type = NaN;
            rem_ed_idx = NaN;
            rem_ed_count = 0;
            pppp = NaN;
            hhh = NaN;
            e = NaN;
        end
            
    end
   waitbar(i/60819)
end
delete(wait_h)