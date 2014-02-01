%run through dataset and get area stats around each hurricane timestep
tic
%p2ll = load('/project/expeditions/eddies_project_data/ssh_data/data/pixels_2_lat_lon_map.mat');
steps = size(IBTrACS_1992_2010,1);
cyc_count = zeros(steps,1);
acyc_count = zeros(steps,1);
cyc_area = zeros(steps,1);
acyc_area = zeros(steps,1);

wait_h = waitbar(0, 'progress');

for i = 1 : steps
    lat = IBTrACS_1992_2010.Latitude_for_mapping(i);
    lon = IBTrACS_1992_2010.Longitude_for_mapping(i);
    cyc = h_cyc(IBTrACS_1992_2010.Timeslice_idx(i));
    acyc = h_acyc(IBTrACS_1992_2010.Timeslice_idx(i));
    
    [cyc_count(i), acyc_count(i), cyc_area(i), acyc_area(i)] =...
        areaStats(lat, lon, cyc, acyc);
    
    waitbar(i/steps);
end

names = cellstr(['cyc_count ';'acyc_count';'cyc_area  ';...
    'acyc_area ']);
area_stats = dataset({[cyc_count, acyc_count, cyc_area, acyc_area],...
    names{:}});

delete(wait_h)

toc