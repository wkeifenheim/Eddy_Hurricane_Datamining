%% Pull 1 week old eddies globally, and determine stat distributions

cyc_num = size(bu_cyclonic_tracks,2);
acyc_num = size(bu_anticyc_tracks,2);
total = cyc_num + acyc_num;
global_one_week_eddies = NaN(total,6);

wait_h = waitbar(0,'processing cyclonic tracks..');
for i = 1 : cyc_num
    
    track = bu_cyclonic_tracks{i};
    eddyTime = track(1,3);
    eddyId = track(1,4);
    eddy = h_cyc(eddyTime).eddies(eddyId);
    mean_speed = deg2km(distance(track(1,1), track(1,2), track(end,1), track(end,2))) /...
        size(track,1); % km/week
    
    % [EddyClass, EddyTrackLength, EddyAmp, EddyPixelCount, EddyGeoSpeed,
    % EddyPropSpeed]
    global_one_week_eddies(i,:) = [-1, size(track,1), eddy.Amplitude,...
        size(eddy.Stats.PixelIdxList,1), eddy.MeanGeoSpeed, mean_speed];
    
    waitbar(i/cyc_num);
end

delete(wait_h);

% process anticyclonic eddies
wait_h = waitbar(0,'processing anticyclonic tracks..');
for i = 1 : acyc_num
    
    track = bu_anticyc_tracks{i};
    eddyTime = track(1,3);
    eddyId = track(1,4);
    eddy = h_acyc(eddyTime).eddies(eddyId);
    mean_speed = deg2km(distance(track(1,1), track(1,2), track(end,1), track(end,2))) /...
        size(track,1); % km/week
    
    % [EddyClass, EddyTrackLength, EddyAmp, EddyPixelCount, EddyGeoSpeed,
    % EddyPropSpeed]
    global_one_week_eddies(i+cyc_num,:) = [1, size(track,1), eddy.Amplitude,...
        size(eddy.Stats.PixelIdxList,1), eddy.MeanGeoSpeed, mean_speed];
    
    waitbar(i/acyc_num);
end

delete(wait_h);