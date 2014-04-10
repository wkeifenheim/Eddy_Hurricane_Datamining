%determine indices of IBTrACS-eddies in which a hurricane interacts with an
%eddy only once.
%NOTE: Will miscategorize if the same eddy is encountered but in a
%different eddy timeslice (weekly/daily)

cur_hur = IBTrACS_1992_2010.Serial_Num(1);
one_offs = false(size(IBTrACS_1992_2010,1),1);
e_class= NaN;
e_idx = NaN;

for i = 1 : length(one_offs)
    
    if(~strcmp(cur_hur, IBTrACS_1992_2010.Serial_Num(i)))
        cur_hur = IBTrACS_1992_2010.Serial_Num(i);
        e_class= NaN;
        e_idx = NaN;
    end
    
    if(~isnan(IBTrACS_1992_2010.EddyClass(i)))
        if(e_class ~= IBTrACS_1992_2010.EddyClass(i) &&...
                e_idx ~= IBTrACS_1992_2010.EddyIdx(i))
            
            e_idx = IBTrACS_1992_2010.EddyIdx(i);
            e_class = IBTrACS_1992_2010.EddyClass(i);
            if(e_class ~= IBTrACS_1992_2010.EddyClass(i+1) &&...
                e_idx ~= IBTrACS_1992_2010.EddyIdx(i+1))
                
                one_offs(i) = true;
            end
        end
    else
        e_class = NaN;
        e_idx = NaN;
    end
    
end

name = 'one_only';
one_offs = dataset({one_offs,name});