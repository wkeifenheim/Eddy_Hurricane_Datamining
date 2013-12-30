% Calculate bearing for all but last time-step of a given hurricane.

bearings = zeros(60819,1);
cur_hur_id = IBTrACS_eddies_1992_2010_v1.Serial_Num(1);
for i = 1 : 60818
    if(strcmp(cur_hur_id, IBTrACS_eddies_1992_2010_v1.Serial_Num(i+1)))
        lat1 = IBTrACS_eddies_1992_2010_v1.Latitude_for_mapping(i);
        lon1 = IBTrACS_eddies_1992_2010_v1.Longitude_for_mapping(i);
        lat2 = IBTrACS_eddies_1992_2010_v1.Latitude_for_mapping(i+1);
        lon2 = IBTrACS_eddies_1992_2010_v1.Longitude_for_mapping(i+1);
        [arclen, az] = distance(lat1,lon1,lat2,lon2);
        bearings(i) = az;
    else
        bearings(i) = NaN;
        cur_hur_id = IBTrACS_eddies_1992_2010_v1.Serial_Num(i+1);
    end
end

bearings(60819) = NaN;