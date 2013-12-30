result = [60819,2];
result(1,1) = NaN;
result(1,2) = NaN;

current_hurr = cellstr(IBTrACS_eddies_1992_2010_v2(1,1));
%find first delta
for i=2:60819
    if(strcmp(current_hurr, cellstr(IBTrACS_eddies_1992_2010_v2(i,1))))
        if(~isnan(double(IBTrACS_eddies_1992_2010_v2(i,12))) && ~isnan(double(IBTrACS_eddies_1992_2010_v2(i-1,12))))
            result(i,1) = double(IBTrACS_eddies_1992_2010_v2(i,17)) - ...
                double(IBTrACS_eddies_1992_2010_v2(i-1,17));
        else
            result(i,1) = NaN;
        end
    else
        current_hurr = cellstr(IBTrACS_eddies_1992_2010_v2(i,1));
        result(i,1) = NaN;
    end
        

end

%find second delta
for i=2:60819
    if(~isnan(result(i,1)) && ~isnan(result(i-1,1)))
        result(i,2) = result(i,1) + result(i-1,1);
    else
        result(i,2) = NaN;
    end
        

end