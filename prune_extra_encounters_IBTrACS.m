%create a new dataset that contains eddy encounters only once, i.e. if
%consequtive time steps in a hurricane track encounter the same eddy, only
%the first time step will list the encounter in the new dataset.

IBTrACS_1992_2010_NewI2 = IBTrACS_1992_2010;

wait_h  = waitbar(0,'progress');
cur_hur = IBTrACS_1992_2010.Serial_Num(1);
eIdx = NaN;
eClass = NaN;

for i = 1 : 60819
    if(~strcmp(IBTrACS_1992_2010.Serial_Num(i), cur_hur))
       cur_hur = IBTrACS_1992_2010.Serial_Num(i);
       eIdx = NaN;
       eClass = NaN;
    end
    if(strcmp(IBTrACS_1992_2010.Serial_Num(i), cur_hur))
        
        if(eIdx ~= IBTrACS_1992_2010.EddyIdx(i) || eClass ~= ...
                IBTrACS_1992_2010.EddyClass(i))
            
            eIdx = IBTrACS_1992_2010.EddyIdx(i);
            eClass = IBTrACS_1992_2010.EddyClass(i);
        else

            IBTrACS_1992_2010_NewI2.EddyClass(i) = NaN;
            IBTrACS_1992_2010_NewI2.EddyLat(i) = NaN;
            IBTrACS_1992_2010_NewI2.EddyLon(i) = NaN;
            IBTrACS_1992_2010_NewI2.EddyAmp(i) = NaN;
            IBTrACS_1992_2010_NewI2.EddyGeoSpeed(i) = NaN;
            IBTrACS_1992_2010_NewI2.EddyIdx(i) = NaN;
            IBTrACS_1992_2010_NewI2.EddyTrackIdx(i) = NaN;
            IBTrACS_1992_2010_NewI2.EddyAge(i) = NaN;
            IBTrACS_1992_2010_NewI2.EddyTrackLength(i) = NaN;
        end
    end
    waitbar(i/60819)
end
delete(wait_h)