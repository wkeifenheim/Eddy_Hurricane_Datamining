result = [60819,2];
result(1,1) = NaN;
result(1,2) = NaN;

current_hurr = IBTrACS_1992_2010.Serial_Num(1);
%find first delta
wait_h = waitbar(0,'progress..')
for i=2:60819
    if(strcmp(current_hurr, IBTrACS_1992_2010.Serial_Num(i)))
        if(~isnan(IBTrACS_1992_2010.WindWMO(i)) && ~isnan(IBTrACS_1992_2010.WindWMO(i-1)))

            result(i,1) = IBTrACS_1992_2010.WindWMO(i) - IBTrACS_1992_2010.WindWMO(i-1);
        else
            result(i,1) = NaN;
        end
    else
        current_hurr = IBTrACS_1992_2010.Serial_Num(i);
        result(i,1) = NaN;
    end
        
    waitbar(i/60819)
end

delete(wait_h)

%find second delta
for i=2:60819
    if(~isnan(result(i,1)) && ~isnan(result(i-1,1)))
        result(i,2) = result(i,1) + result(i-1,1);
    else
        result(i,2) = NaN;
    end
        

end