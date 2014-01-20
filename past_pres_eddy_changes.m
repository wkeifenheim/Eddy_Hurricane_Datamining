%cccchanges
past_pres = zeros(7117,1);

for i = 1 : 7117
    if(~isnan(IBTrACS_five_plus.EddyAmp(i)) ...
            && ~isnan(IBTrACS_five_plus.AmplitudeBefore(i)))
        past_pres(i,1) = IBTrACS_five_plus.EddyAmp(i) - ...
            IBTrACS_five_plus.AmplitudeBefore(i);
    else
        past_pres(i,1) = NaN;
    end
    if(~isnan(IBTrACS_five_plus.EddyGeoSpeed(i)) ...
        && ~isnan(IBTrACS_five_plus.GeoSpeedBefore(i)))
    past_pres(i,2) = IBTrACS_five_plus.EddyGeoSpeed(i) - ...
        IBTrACS_five_plus.GeoSpeedBefore(i);
    else
        past_pres(i,2) = NaN;
    end
end