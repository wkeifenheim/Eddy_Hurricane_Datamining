%% build heatmap of one week old eddies that interact with TC

load('/project/expeditions/eddies_project_data/results/tracks_viewer_data/SSH/ssh_19921014.mat');

subset = IBTrACS_1992_2010(IBTrACS_1992_2010.EddyAge == 1,:);
cyc_heat_map = zeros(size(data));
acyc_heat_map = zeros(size(data));

wait_h = waitbar(0,'Progress of Age=1 Eddy Heatmap generation..');
stop = size(subset,1);
for i = 1 : stop
    
    timestep = subset.Timeslice_idx(i);
    e_idx = subset.EddyIdx(i);
    
    if(subset.EddyClass(i) == -1)
        pixels = h_cyc(timestep).eddies(e_idx).Stats.PixelIdxList;
        cyc_heat_map(pixels) = cyc_heat_map(pixels) + 1;
        if(~isnan(subset.EddyTrackIdx(i)))
            track = bu_cyclonic_tracks{subset.EddyTrackIdx(i)};
            for j = 2 : size(track,1)
                pixels = h_cyc(track(j,3)).eddies(track(j,4)).Stats.PixelIdxList;
                cyc_heat_map(pixels) = cyc_heat_map(pixels) + 1;
            end
        end
    elseif(not_one_week.EddyClass(i) == 1)
        pixels = h_acyc(timestep).eddies(e_idx).Stats.PixelIdxList;
        acyc_heat_map(pixels) = acyc_heat_map(pixels) + 1;
        if(~isnan(subset.EddyTrackIdx(i)))
            track = bu_anticyc_tracks{subset.EddyTrackIdx(i)};
            for j = 2 : size(track,1)
                pixels = h_acyc(track(j,3)).eddies(track(j,4)).Stats.PixelIdxList;
                acyc_heat_map(pixels) = cyc_heat_map(pixels) + 1;
            end
        end
    end
    
    
    waitbar(i/stop);
end
delete(wait_h);