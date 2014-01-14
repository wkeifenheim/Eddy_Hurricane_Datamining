%cccchanges

for i = 1 : 12692
    if(~isnan(IBTrACS_five_plus.EddyAmp(i)) ...
            && ~isnan(IBTrACS_five_plus.OldAmp(i)))
        past_pres(i,1) = IBTrACS_five_plus.EddyAmp(i) - ...
            IBTrACS_five_plus.OldAmp(i);
    else
        past_pres(i,1) = NaN;
    end
    if(~isnan(IBTrACS_five_plus.EddyGeoSpeed(i)) ...
        && ~isnan(IBTrACS_five_plus.OldGeoSpeed(i)))
    past_pres(i,2) = IBTrACS_five_plus.EddyGeoSpeed(i) - ...
        IBTrACS_five_plus.OldGeoSpeed(i);
    else
        past_pres(i,2) = NaN;
    end
end