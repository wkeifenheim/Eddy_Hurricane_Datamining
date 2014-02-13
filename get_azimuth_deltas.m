az_d1 = zeros(size(IBTrACS_1992_2010,1));

cur_hur= IBTrACS_1992_2010.Serial_Num(1);
az_d1(1) = NaN;
wait_h = waitbar(0,'progress..');
for i = 2 : size(IBTrACS_1992_2010,1)
    if(~strcmp(cur_hur,IBTrACS_1992_2010.Serial_Num(i)))
        cur_hur = IBTrACS_1992_2010.Serial_Num(i);
        az_d1(i) = NaN;
    end
    x = IBTrACS_1992_2010.Azimuth(i);
    y = IBTrACS_1992_2010.Azimuth(i-1);
    az_d1(i) = atan2d(sind(x-y),cosd(x-y));
    waitbar(i/60819)
end

result = az_d1;
for i=2:60819
    if(~isnan(result(i,1)) && ~isnan(result(i-1,1)))
        result(i,2) = result(i,1) + result(i-1,1);
    else
        result(i,2) = NaN;
    end
        

end
delete(wait_h)