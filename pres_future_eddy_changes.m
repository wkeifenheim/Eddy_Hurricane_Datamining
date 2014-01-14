%cccchanges

for i = 1 : 12692
    if(~isnan(IBTrACS_five_plus.EddyAmp(i)) ...
            && ~isnan(IBTrACS_five_plus.FutureAmp(i)))
        pres_future(i,1) = IBTrACS_five_plus.FutureAmp(i) - ...
            IBTrACS_five_plus.EddyAmp(i);
    else
        pres_future(i,1) = NaN;
    end
    if(~isnan(IBTrACS_five_plus.EddyGeoSpeed(i)) ...
        && ~isnan(IBTrACS_five_plus.FutureGeoSpeed(i)))
    pres_future(i,2) = IBTrACS_five_plus.FutureGeoSpeed(i) - ...
        IBTrACS_five_plus.EddyGeoSpeed(i);
    else
        pres_future(i,2) = NaN;
    end
end