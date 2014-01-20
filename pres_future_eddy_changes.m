%cccchanges
pres_future = zeros(7117,1);

for i = 1 : 7117
    if(~isnan(IBTrACS_five_plus.EddyAmp(i)) ...
            && ~isnan(IBTrACS_five_plus.AmplitudeAfter(i)))
        pres_future(i,1) = IBTrACS_five_plus.AmplitudeAfter(i) - ...
            IBTrACS_five_plus.EddyAmp(i);
    else
        pres_future(i,1) = NaN;
    end
    if(~isnan(IBTrACS_five_plus.EddyGeoSpeed(i)) ...
        && ~isnan(IBTrACS_five_plus.GeoSpeedAfter(i)))
    pres_future(i,2) = IBTrACS_five_plus.GeoSpeedAfter(i) - ...
        IBTrACS_five_plus.EddyGeoSpeed(i);
    else
        pres_future(i,2) = NaN;
    end
end