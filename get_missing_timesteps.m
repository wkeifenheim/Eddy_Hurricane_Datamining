%find timesteps exceeding 6 hours

%duration = [duration, zeros(60819,1)];
%cur_hur = IBTrACS_1992_2010.Serial_Num(1);
%first_timestep = datevec(IBTrACS_1992_2010.ISO_time(1));
%duration(1,2) = 0;
wait_h = waitbar(0, 'progress..');

for i = 2 : 60819
    if(duration(i,1) ~= 0 && duration(i,2) ~= 6)
        disp('HEY!')
        i
    end
    waitbar(i/60819)
end
delete(wait_h)