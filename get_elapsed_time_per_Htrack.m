%find the elapsed time (in hours) from the beginning of a hurricane track

duration = zeros(60819,1);
cur_hur = IBTrACS_1992_2010.Serial_Num(1);
first_timestep = datevec(IBTrACS_1992_2010.ISO_time(1));
duration(1) = 0;
wait_h = waitbar(0, 'progress..');

for i = 2 : 60819
    if(strcmp(cur_hur, IBTrACS_1992_2010.Serial_Num(i)))
        duration(i) = etime(datevec(IBTrACS_1992_2010.ISO_time(i)),...
            first_timestep) / 3600; %etime result is in seconds
    else
        cur_hur = IBTrACS_1992_2010.Serial_Num(i);
        first_timestep = datevec(IBTrACS_1992_2010.ISO_time(i));
        duration(i) = 0;
    end
    waitbar(i/60819)
end
delete(wait_h)