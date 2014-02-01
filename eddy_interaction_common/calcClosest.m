% Takes hurricane coordinates at a certain timestep, and finds the eddies
% closest to those coordinates.
% lat/lon are the hurricane coordinates, and antiCyc/cyc are file handles
% to eddy bodies from the timeframe cooresponding to hurricane coordinates
%
% proxType:
%           0 - miss
%           1 - within 1-2 grid cells
%           2 - edge
%           3 - core (or nearly so) overlap
% eddyClass:
%           +1 - Anticyclonic
%           -1 - Cyclonic
%

function [eddyClass, eddyLat, eddyLon, eddyAmp, eddyU, eddyIdx]...
    = calcClosest(lat, lon, antiCyc, cyc, p2ll)

    consider_threshold = 20.0;

    
%     p2ll = load('/project/expeditions/eddies_project_data/ssh_data/data/pixels_2_lat_lon_map.mat');
    distanceToEddy = Inf('double');
    EddyIndex = [0 0]; % Type [-1,1] and index
    
    for i=1 : size(antiCyc,2)
        if(antiCyc(i).Type == 0)
            if(antiCyc(i).BUBodyCount)
                eddy = antiCyc(i).BUBody;
            else
                eddy = antiCyc(i).ESBody;
            end
        else
            continue
        end
        latProximity = abs(lat - eddy.Lat);
        lonProximity = abs(lon - eddy.Lon);


        % Restrict the search area
        if(latProximity <= 3.0 && lonProximity <= 3.0)
            
            pixelLatLons = pid2latlon(eddy.Stats.PixelIdxList, p2ll.latLonMap);
            pixelLatLons(:,2) = pixelLatLons(:,2) - 360;
            
            distances = zeros(size(pixelLatLons,1),1);
            
%             for j = 1 : size(distances,1)
%                 distances(j) = geoddistance(lat, lon, pixelLatLons(j,1),...
%                     pixelLatLons(j,2));
%             end

            for j = 1 : size(distances,1)
                distances(j) = deg2km(distance(lat,lon,pixelLatLons(j,1),...
                    pixelLatLons(j,2)));
            end
            
            [d,di] = min(distances);
%             d = d/1000;
            
            if(d <= consider_threshold)
                if(d < distanceToEddy)
                    distanceToEddy = d;
                    EddyIndex = [1, i];
                    eddyLat = eddy.Lat;
                    eddyLon = eddy.Lon;
                    eddyAmp = eddy.Amplitude;
                    eddyU = eddy.MeanGeoSpeed;
                    eddyIdx = i;
                end
            end         
        else
            % do nothing
        end
    end
        
    for i=1 : size(cyc,2)
        if(cyc(i).Type == 0)
            if(antiCyc(i).BUBodyCount)
                eddy = cyc(i).BUBody;
            else
                eddy = cyc(i).ESBody;
            end
        else
            continue
        end
        latProximity = abs(lat - eddy.Lat);
        lonProximity = abs(lon - eddy.Lon);


        % Restrict the search area
        if(latProximity <= 3.0 && lonProximity <= 3.0)
            
            pixelLatLons = pid2latlon(eddy.Stats.PixelIdxList, p2ll.latLonMap);
            pixelLatLons(:,2) = pixelLatLons(:,2) - 360;
            
            distances = zeros(size(pixelLatLons,1),1);

            for j = 1 : size(distances,1)
                distances(j) = deg2km(distance(lat,lon,pixelLatLons(j,1),...
                    pixelLatLons(j,2)));
            end
            
            [d,di] = min(distances);
%             d = d/1000;
            
            if(d <= consider_threshold) %10 km
                if(d < distanceToEddy)
                    distanceToEddy = d;
                    EddyIndex = [-1, i];
                    eddyLat = eddy.Lat;
                    eddyLon = eddy.Lon;
                    eddyAmp = eddy.Amplitude;
                    eddyU = eddy.MeanGeoSpeed;
                    eddyIdx = i;
                end
            end         
        else
            % do nothing
        end
    end
        


    
    % Found something
    if(EddyIndex(1,1) == 1)
        
        %proxType = NaN; % for now %TODO: calculate eddy boundaries
        eddyClass = 1;
        %eddyStruct = antiCyc.eddies(EddyIndex(2));
        
    elseif (EddyIndex(1,1) == -1)
            
        %proxType = NaN;
        eddyClass = -1;
        %eddyStruct = cyc.eddies(EddyIndex(2));
    
    % Found nothing    
    else
        
        %proxType = NaN;
        eddyClass = NaN;
        eddyLat = NaN;
        eddyLon = NaN;
        eddyAmp = NaN;
        eddyU = NaN;
        eddyIdx = NaN;
        %eddyStruct = NaN;
        
    end
    
    
              
end