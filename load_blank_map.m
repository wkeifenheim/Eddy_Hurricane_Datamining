fig = figure;
axesm('pcarre', 'Origin', [0 180 0]);%, 'MapLatLimit', [0 70], 'MapLonLimit', [-120 0]);
% load coast
plotm(lat,long,'w')
whitebg('k')

p2ll = load('~/Documents/data/new_p2ll_720_1440.mat');
lat_e = squeeze(p2ll.latLonMap(:,1,1));
lon_e = squeeze(p2ll.latLonMap(1,:,2));
lsmask = ncread('lsmask.oisst.v2.nc','lsmask');
lsmask = lsmask';
load('/project/expeditions/woodrow/data/colormaps/colormap_19930101.mat');
cmap = squeeze(colormap(:,:,1));
cmap(cmap == 1) = 2;
cmap(cmap == -1) = 1;

pcolorm(lat_e,lon_e',cmap)

% lat_e and lon_e for mapping matrix to projection with pcolorm
% load('~/Documents/Datasets/pcolorm_lat_lon.mat')
% load('~/Documents/Datasets/week_one_vs_not_week_one_heatmaps.mat')

% pcolorm(lat_e,lon_e,(global_cyc_heat_map + global_acyc_heat_map))


% pcolorm(lat_e,lon_e,(1 ./ (cyc_heat_map + acyc_heat_map)))

% print(fig, '-dpng', '-r400','inverse_one_week_old_TC_eddy_heat_map.png')