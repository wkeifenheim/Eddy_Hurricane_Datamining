% Takes hurricane coordinates at a certain timestep, and finds the eddies
% closest to those coordinates.
% lat/lon are the hurricane coordinates, and antiCyc/cyc are file handles
% to eddy bodies from the timeframe cooresponding to hurricane coordinates

% eddyClass:
%           +1 - antiCyclonic
%           -1 - Cyclonic
%

function [eddyClass, eddyLat, eddyLon, eddyAmp, eddyU, eddyIdx, EddyPixelCount]...
    = calcClosest2(lat, lon, antiCyc, cyc, p2ll)

    eddyClass = NaN;
    eddyLat = NaN;
    eddyLon = NaN;
    eddyAmp = NaN;
    eddyU = NaN;
    eddyIdx = NaN;
    EddyPixelCount = NaN;

    consider_threshold = 20.0; %kilometers
    distanceToEddy = Inf('double');    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Search antiCyclonic eddies
    latProximity = abs(lat - [antiCyc.eddies.Lat]');
    lonProximity = abs(lat - [antiCyc.eddies.Lon]');
    consider_idx = bitand(latProximity <= 3.0, lonProximity <= 3.0);
    
    for i = 1 : size(antiCyc.eddies,2)
        if(consider_idx(i))
            pixelLatLons = pid2latlon(antiCyc.eddies(i).Stats.PixelIdxList, p2ll.latLonMap);
            pixelLatLons(:,2) = pixelLatLons(:,2) - 360;
%             distances = zeros(size(pixelLatLons,1),1);
            lats = ones(size(pixelLatLons,1),1) * lat;
            lons = ones(size(pixelLatLons,1),1) * lon;
            distances = deg2km(distance(lats,lons,pixelLatLons(:,1),pixelLatLons(:,2)));
            [d,di] = min(distances);
            
            if(d <= consider_threshold && d < distanceToEddy)
                distanceToEddy = d;
                eddyClass = 1;
                eddyLat = antiCyc.eddies(i).Lat;
                eddyLon = antiCyc.eddies(i).Lon;
                eddyAmp = antiCyc.eddies(i).Amplitude;
                eddyU = antiCyc.eddies(i).MeanGeoSpeed;
                eddyIdx = i;
                EddyPixelCount = length(antiCyc.eddies(i).Stats.PixelIdxList);
            end
        end
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Search Cyclonic eddies
    latProximity = abs(lat - [cyc.eddies.Lat]');
    lonProximity = abs(lon - [cyc.eddies.Lon]');
    consider_idx = bitand(latProximity <= 3.0, lonProximity <= 3.0);
    
    for i = 1 : size(cyc.eddies,2)
        if(consider_idx(i))
            pixelLatLons = pid2latlon(cyc.eddies(i).Stats.PixelIdxList, p2ll.latLonMap);
            pixelLatLons(:,2) = pixelLatLons(:,2) - 360;
%             distances = zeros(size(pixelLatLons,1),1);
            lats = ones(size(pixelLatLons,1),1) * lat;
            lons = ones(size(pixelLatLons,1),1) * lon;
            distances = deg2km(distance(lats,lons,pixelLatLons(:,1),pixelLatLons(:,2)));
            [d,di] = min(distances);
            
            if(d <= consider_threshold && d < distanceToEddy)
                distanceToEddy = d;
                eddyClass = -1;
                eddyLat = cyc.eddies(i).Lat;
                eddyLon = cyc.eddies(i).Lon;
                eddyAmp = cyc.eddies(i).Amplitude;
                eddyU = cyc.eddies(i).MeanGeoSpeed;
                eddyIdx = i;
                EddyPixelCount = length(cyc.eddies(i).Stats.PixelIdxList);
            end
        end
    end    
              
end