%Identify hurricanes occuring in the South Atlantic Basin, to establish if
%more than those labeled as "SA" actually occur there

sa_hurricanes = [];

cur_hur = NaN;
wait_h = waitbar(0,'progress');

for i = 1 : 60819
    if(IBTrACS_1992_2010.Latitude_for_mapping(i) < 0)
        if(IBTrACS_1992_2010.Longitude_for_mapping(i) > -60 &&...
                IBTrACS_1992_2010.Longitude_for_mapping(i) < 15)
            if(~strcmp(cur_hur, IBTrACS_1992_2010.Serial_Num(i)))
                cur_hur = IBTrACS_1992_2010.Serial_Num(i);
                sa_hurricanes = ({sa_hurricanes;cellstr(cur_hur)});
            end
        end
    end
    waitbar(i/60819)
end
delete(wait_h)