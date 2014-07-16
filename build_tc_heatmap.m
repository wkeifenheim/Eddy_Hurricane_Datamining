%% Produces a heatmap of hurricane paths

% TC data file
load('/project/expeditions/woodrow/Datasets/IBTrACS_All_1992_2010_working.mat');

% Used for mapping grid coordinates to row/col values
p2ll = load('/project/expeditions/woodrow/data/new_p2ll_720_1440.mat');
latitude = squeeze(p2ll.latLonMap(:,1,1)); %vector of latitudes corresponding to the data-grid
longitude = squeeze(p2ll.latLonMap(1,:,2)); %vector of longitude "..."

tc_heatmap = zeros(720,1440); %for 0.25x0.25 degree resolution

% coords = [IBTrACS_eddies_1992_2010_working.Latitude_for_mapping(:), IBTrACS_eddies_1992_2010_working.Longitude_for_mapping(:)];

wait_h = waitbar(0,'Progress of TC Heatmap generation..');

stop = size(IBTrACS_eddies_1992_2010_working,1);
for i = 1 : stop
    tc_lat = IBTrACS_eddies_1992_2010_working.Latitude_for_mapping(i);
    tc_lon = IBTrACS_eddies_1992_2010_working.Longitude_for_mapping(i);
    
    % find (lat,lon) values that most closely match the tc coordinates
    [c,row] = min(abs(latitude-tc_lat));
    if(tc_lon < 0)
        tc_lon = 360 + tc_lon;
    end
    [c,col] = min(abs(longitude-tc_lon));
%     disp(strcat('Row: ', num2str(row), ' Col: ', num2str(col)));
    
    % NOTE: the off by one indexing is so the hurricane is not just
    % represented by one 0.25x0.25 degree pixel
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
    mapIdx = sub2ind(size(tc_heatmap), subscripts(:,1), subscripts(:,2));
    
    tc_heatmap(mapIdx) = tc_heatmap(mapIdx) + 1;
    
    waitbar(i/stop);
end
delete(wait_h);


%% Additional code for plotting the heatmap
% initialize a map projection
fig = figure;
axesm('pcarre', 'Origin', [0 180 0]);
% show coast
load coast
plotm(lat,long,'w')
whitebg('k')
pcolorm(latitude,longitude',tc_heatmap);


% you may need to use log10() on the heatmap to get better colors
% eg. tc_heatmap = log10(tc_heatmap); then use pcolorm again
