%Collect hurricanes that only interact with cyclonic or anticyclonic eddies
%i.e. racist hurricanes

cyc_hurricanes = [];
acyc_hurricanes = [];

cyc_trigger = 0;
acyc_trigger = 0;
cur_hur = IBTrACS_1992_2010_NewI.Serial_Num(1);

wait_h = waitbar(0,'progress');

for i = 1 : 60819
    if(~strcmp(cur_hur, IBTrACS_1992_2010_NewI.Serial_Num(i)))
        if(cyc_trigger && ~acyc_trigger)
            cyc_hurricanes = [cyc_hurricanes; cur_hur];
        elseif(~cyc_trigger && acyc_trigger)
            acyc_hurricanes = [acyc_hurricanes; cur_hur];
        end
        cyc_trigger = 0;
        acyc_trigger = 0;
        cur_hur = IBTrACS_1992_2010_NewI.Serial_Num(i);
    end
    if(IBTrACS_1992_2010_NewI.EddyClass(i) == -1)
        cyc_trigger = 1;
    elseif(IBTrACS_1992_2010_NewI.EddyClass(i) == 1)
        acyc_trigger = 1;
    end
    waitbar(i/60819)
    
end
delete(wait_h)