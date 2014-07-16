%% Load files for daily eddies
% Note 2014.07.11 - Updated to support different, fully loaded, eddy data
% tracks
load('/project/expeditions/alindell/results/tracks/test_tracks/tracks_93-12_005_threshold/tolerance/cyclonic_tracks_processed.mat');
load('/project/expeditions/alindell/results/tracks/test_tracks/tracks_93-12_005_threshold/tolerance/anticyc_tracks_processed.mat');

% dates
load('/project/expeditions/alindell/results/viewer_data/daily_SSH/dates_all.mat');

% load all eddies into memory
% h_cyc = load_eddies_cells('cyclonic',dates);
% h_acyc = load_eddies_cells('anticyclonic',dates);

%% Produce index of eddies that are tracked (which track, and where within the track)
cyc_eddy_indexes = cell(size(h_cyc));
acyc_eddy_indexes = cell(size(h_acyc));
for i = 1 : length(cyc_eddy_indexes)
    cyc_eddy_indexes{i} = nan(length(h_cyc{i}),2);
%     acyc_eddy_indexes{i} = nan(length(h_acyc{i}),2);
end
% cyclonic
wait_h = waitbar(0,'building cyclonic eddy track indexes');
for i = 1 : length(cyclonic_tracks)
    cur_track = cyclonic_tracks{i};
    for j = 1 : size(cur_track,1)
        cur_eddy = cur_track(j,:);
        timestep = cur_eddy(3);
        eddy_index = cur_eddy(4);
        cyc_eddy_indexes{timestep}(eddy_index,:) = [i,j];
    end
    waitbar(i/length(cyclonic_tracks));
end
delete(wait_h);

%anticyclonic
wait_h = waitbar(0,'building anticyclonic eddy track indexes');
for i = 1 : length(anticyc_tracks)
    cur_track = anticyc_tracks{i};
    for j = 1 : size(cur_track,1)
        cur_eddy = cur_track(j,:);
        timestep = cur_eddy(3);
        eddy_index = cur_eddy(4);
        acyc_eddy_indexes{timestep}(eddy_index,:) = [i,j];
    end
    waitbar(i/length(anticyc_tracks));
end
delete(wait_h);