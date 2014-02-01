%create a new dataset that contains eddy encounters only once, i.e. if
%consequtive time steps in a hurricane track encounter the same eddy, only
%the first time step will list the encounter in the new dataset.

IBTrACS_1992_2010_common_unique = IBTrACS_1992_2010_common;

wait_h  = waitbar(0,'progress');
cur_hur = IBTrACS_1992_2010_common.Serial_Num(1);
eIdx = NaN;
eClass = NaN;

for i = 1 : 60819
    if(~strcmp(IBTrACS_1992_2010_common.Serial_Num(i), cur_hur))
       cur_hur = IBTrACS_1992_2010_common.Serial_Num(i);
       eIdx = NaN;
       eClass = NaN;
    end
    if(strcmp(IBTrACS_1992_2010_common.Serial_Num(i), cur_hur))
        
        if(eIdx ~= IBTrACS_1992_2010_common.EddyIdx(i) || eClass ~= ...
                IBTrACS_1992_2010_common.EddyClass(i))
            
            eIdx = IBTrACS_1992_2010_common.EddyIdx(i);
            eClass = IBTrACS_1992_2010_common.EddyClass(i);
        else

            IBTrACS_1992_2010_common_unique.EddyClass(i) = NaN;
            IBTrACS_1992_2010_common_unique.EddyLat(i) = NaN;
            IBTrACS_1992_2010_common_unique.EddyLon(i) = NaN;
            IBTrACS_1992_2010_common_unique.EddyAmp(i) = NaN;
            IBTrACS_1992_2010_common_unique.EddyGeoSpeed(i) = NaN;
            IBTrACS_1992_2010_common_unique.EddyIdx(i) = NaN;
%             IBTrACS_1992_2010_common_unique.EddyTrackIdx(i) = NaN;
%             IBTrACS_1992_2010_common_unique.EddyAge(i) = NaN;
%             IBTrACS_1992_2010_common_unique.EddyTrackLength(i) = NaN;
        end
    end
    waitbar(i/60819)
end
delete(wait_h)