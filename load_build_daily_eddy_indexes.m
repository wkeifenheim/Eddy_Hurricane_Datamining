%% Load files for daily eddies

% tracks
load('/project/expeditions/alindell/results/tracks/test_tracks/tracks_93-12/cyclonic_tracks_processed.mat');
load('/project/expeditions/alindell/results/tracks/test_tracks/tracks_93-12/anticyc_tracks_processed.mat');

% dates
load('/project/expeditions/alindell/results/viewer_data/daily_SSH/dates_all.mat');

% load all eddies into memory
loadEddyTimeslicesDaily;

%% Produce index of eddies that are tracked (which track, and where within the track)
cyc_eddy_indexes = cell(size(h_cyc));
acyc_eddy_indexes = cell(size(h_acyc));
for i = 1 : length(cyc_eddy_indexes)
    cyc_eddy_indexes{i} = nan(length(h_cyc(i).eddies),2);
    acyc_eddy_indexes{i} = nan(length(h_acyc(i).eddies),2);
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
    waitbar(i/length(cyclonic_tracks));
end
delete(wait_h);