%Identify hurricanes featuring eddy interactions with an eddy that had a
%lifetime of one week

short_eddies = [];

cur_hur = NaN;
wait_h = waitbar(0,'progress');

for i = 1 : 60819
    if(IBTrACS_1992_2010.TrackLength(i) == 1)
            if(~strcmp(cur_hur, IBTrACS_1992_2010.Serial_Num(i)))
                cur_hur = IBTrACS_1992_2010.Serial_Num(i);
                short_eddies = [short_eddies;cellstr(cur_hur)];
            end
    end
    waitbar(i/60819)
end
delete(wait_h)