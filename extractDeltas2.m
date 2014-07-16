% find changes over TC time-steps, and over two time-steps

total = size(IBTrACS_1993_2012,1);
result = [total,2];
result(1,1) = NaN;
result(1,2) = NaN;
var = IBTrACS_1993_2012.WindWMO; % choose your adventure

current_hurr = IBTrACS_1993_2012.Serial_Num(1);
%find first delta
for i=2:total
    if(strcmp(current_hurr, IBTrACS_1993_2012.Serial_Num(i)))
        if(~isnan(var(i)) && ~isnan(var(i-1)))
            result(i,1) = var(i) - var(i-1);
        else
            result(i,1) = NaN;
        end
    else
        current_hurr = IBTrACS_1993_2012.Serial_Num(i);
        result(i,1) = NaN;
    end
        

end

%find second delta
for i=2:total
    if(~isnan(result(i,1)) && ~isnan(result(i-1,1)))
        result(i,2) = result(i,1) + result(i-1,1);
    else
        result(i,2) = NaN;
    end
        

end