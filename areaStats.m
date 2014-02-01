% Takes hurricane coordinates at a certain timestep, and determines the
% counts and area of cyclonic and anticyclonic eddies with centers within 3
% degrees of the hurricane
% eddyClass:
%           +1 - Anticyclonic
%           -1 - Cyclonic
%

function [cyc_count, acyc_count, cyc_area, acyc_area]...
    = areaStats(lat, lon, cyc, acyc)
    
%     p2ll = load('/project/expeditions/eddies_project_data/ssh_data/data/pixels_2_lat_lon_map.mat');

    %Check cyclonic eddies
    num_eddies = size(cyc.eddies,2);
    cyc_lats = zeros(num_eddies,1);
    cyc_lons = zeros(num_eddies,1);
    
    
    for i = 1 : num_eddies
       cyc_lats(i) = cyc.eddies(i).Lat;
       cyc_lons(i) = cyc.eddies(i).Lon;
    end
    
    latProximities = abs(lat - cyc_lats(:));
    lonProximities = abs(lon - cyc_lons(:));
    
    good_lats = latProximities(:) <= 2;
    good_lons = lonProximities(:) <= 2;
    good_buddies = bitand(good_lats(:),good_lons(:));
    
    cyc_count = 0; %default
    cyc_area = 0; %default
    cyc_count = sum(good_buddies);
    
    if(cyc_count ~= 0)
        edds = cyc.eddies(good_buddies);
        for j = 1 : size(edds,2)
            cyc_area = cyc_area + ...
                size(edds(j).Stats.PixelIdxList,1);
        end
    end


%------------------------------------------------------------
    %Check anticyclonic eddies
    num_eddies = size(acyc.eddies,2);
    acyc_lats = zeros(num_eddies,1);
    acyc_lons = zeros(num_eddies,1);
    
    
    for i = 1 : num_eddies
       acyc_lats(i) = acyc.eddies(i).Lat;
       acyc_lons(i) = acyc.eddies(i).Lon;
    end
    
    latProximities = abs(lat - acyc_lats(:));
    lonProximities = abs(lon - acyc_lons(:));
    
    good_lats = latProximities(:) <= 2;
    good_lons = lonProximities(:) <= 2;
    good_buddies = bitand(good_lats(:),good_lons(:));
    
    acyc_count = 0; %default
    acyc_area = 0; %default
    acyc_count = sum(good_buddies);
    
    if(acyc_count ~= 0)
        edds = acyc.eddies(good_buddies);
        for j = 1 : size(edds,2)
            acyc_area = acyc_area + ...
                size(edds(j).Stats.PixelIdxList,1);
        end
    end
    
end