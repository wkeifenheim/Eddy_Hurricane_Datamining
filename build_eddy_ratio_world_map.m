%% Build map of eddy ratios (per pixel basis)
load('/project/expeditions/eddies_project_data/results/tracks_viewer_data/SSH/ssh_19921014.mat');
cyc_count_map = zeros(size(data));
acyc_count_map = zeros(size(data));

total = size(h_cyc,2);
wait_h = waitbar(0,'progress of eddy ratio world map');
for i = 1 : total
    ce = h_cyc(i).eddies;
    ae = h_acyc(i).eddies;
    for j = 1 : size(ce,2);
        cyc_count_map(ce(j).Stats.PixelIdxList) = cyc_count_map(ce(j).Stats.PixelIdxList) + 1;
    end
    for j = 1 : size(ae,2);
        acyc_count_map(ae(j).Stats.PixelIdxList) = acyc_count_map(ae(j).Stats.PixelIdxList) + 1;
    end
    waitbar(i/total);
end

eddy_ratio_world_map = cyc_count_map ./ acyc_count_map;
eddy_ratio_world_map(isnan(eddy_ratio_world_map)) = 0;
eddy_ratio_world_map(isinf(eddy_ratio_world_map)) = 0;
eddy_ratio_world_map = log10(eddy_ratio_world_map);

%% Produce map and use pcolorm with eddy_ratio_world_map
%caxis([-0.8 0.8]); % use to set colormap appropriately

delete(wait_h);

