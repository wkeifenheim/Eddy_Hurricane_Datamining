colors = cell(60819,1);
class = 0;
idx = 0;
seq = 0; %sequential or not
wait_h = waitbar(0,'progress');
for i = 1 : 60819
    if(IBTrACS_1992_2010.EddyClass(i) == class &&...
            IBTrACS_1992_2010.EddyIdx(i) == idx)
        seq = 1;
    else
        seq = 0;
        class = IBTrACS_1992_2010.EddyClass(i);
        idx = IBTrACS_1992_2010.EddyIdx(i);
    end
        
    if(isnan(IBTrACS_1992_2010.EddyClass(i)))
        colors{i} = [NaN NaN NaN];
    elseif(IBTrACS_1992_2010.EddyClass(i) == -1) %cyclonic
        if(seq)
            colors{i} = [0.2 0.50 0.2];
        else
            colors{i} = [0.25 0.85 0.50];
        end
    elseif(IBTrACS_1992_2010.EddyClass(i) == 1) %anticyclonic
        if(seq)
            colors{i} = [0.7 0.1 0.1];
        else
            colors{i} = [1 0.1 0.1];
        end
    end
    waitbar(i/60819)
end
delete(wait_h)