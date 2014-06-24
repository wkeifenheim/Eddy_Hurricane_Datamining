%% Produces a heatmap of hurricane paths matching the dimensions of weekly SSH data

load('~/Documents/Datasets/IBTrACS_1992_2010_bu_all_working.mat');
load('/project/expeditions/eddies_project_data/results/tracks_viewer_data/SSH/ssh_19921014.mat');
p2ll = load('/project/expeditions/eddies_project_data/ssh_data/data/pixels_2_lat_lon_map.mat');
lat = squeeze(p2ll.latLonMap(:,1,1));
lon = squeeze(p2ll.latLonMap(1,:,2));
tc_heatmap = zeros(size(data));

coords = [IBTrACS_1992_2010.Latitude_for_mapping(:), IBTrACS_1992_2010.Longitude_for_mapping(:)];

wait_h = waitbar(0,'Progress of TC Heatmap generation..');
stop = size(IBTrACS_1992_2010,1);
for i = 1 : stop
    tc_lat = IBTrACS_1992_2010.Latitude_for_mapping(i);
    tc_lon = IBTrACS_1992_2010.Longitude_for_mapping(i);
    
    % find (lat,lon) values that most closely match the tc coordinates
    [c,row] = min(abs(lat-tc_lat));
    if(tc_lon < 0)
        tc_lon = 360 + tc_lon;
    end
    [c,col] = min(abs(lon-tc_lon));
    disp(strcat('Row: ', num2str(row), ' Col: ', num2str(col)));
    
    row = [row-1, row, row+1];
    
    %accomodate longitudes within 0.25 degress of the prime meridian
    if(col == 1)
        col = [1440, 1, 2];
    elseif(col == 1440)
        col = [1439, 1440, 1];
    else
        col = [col-1, col, col+1];
    end
    
    %convert row/col indices to index values
    subscripts = [row(1), col(1); row(1), col(2); row(1), col(3);...
        row(2), col(1); row(2), col(2); row(2), col(3);...
        row(3), col(1); row(3), col(2); row(3), col(3);];
    mapIdx = sub2ind(size(data), subscripts(:,1), subscripts(:,2));
    
    tc_heatmap(mapIdx) = tc_heatmap(mapIdx) + 1;
    
    waitbar(i/stop);
end
delete(wait_h);