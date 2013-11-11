result = [60819,2];
result(1,1) = NaN;
result(1,2) = NaN;

current_hurr = cellstr(IBTrACS_All_1992_2010_clean(1,1));
%find first delta
for i=2:60819
    if(strcmp(current_hurr, cellstr(IBTrACS_All_1992_2010_clean(i,1))))
        if(~isnan(double(IBTrACS_All_1992_2010_clean(i,17))) && ~isnan(double(IBTrACS_All_1992_2010_clean(i-1,17))))
            lat1 = double(IBTrACS_All_1992_2010_clean(i,17));
            lon1 = double(IBTrACS_All_1992_2010_clean(i,18));
            lat2 = double(IBTrACS_All_1992_2010_clean(i-1,17));
            lon2 = double(IBTrACS_All_1992_2010_clean(i-1,18));
            result(i,1) = deg2km(distance(lat1,lon1,lat2,lon2));
        else
            result(i,1) = NaN;
        end
    else
        current_hurr = cellstr(IBTrACS_All_1992_2010_clean(i,1));
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