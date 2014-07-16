%% Produce heatmaps for the global cyclonic and anticyclonic tracks

cyc_num = size(bu_cyclonic_tracks,2);
acyc_num = size(bu_anticyc_tracks,2);
total = cyc_num + acyc_num;
% data = SSH slice
global_cyc_heat_map = zeros(size(data));
global_acyc_heat_map = zeros(size(data));

wait_h = waitbar(0,'processing cyclonic tracks..');
for i = 1 : cyc_num
    
    track = bu_cyclonic_tracks{i};
    for j = 1 : size(track,1)
        pixels = h_cyc(track(j,3)).eddies(track(j,4)).Stats.PixelIdxList;
        global_cyc_heat_map(pixels) = global_cyc_heat_map(pixels) + 1;
    end
    
    waitbar(i/cyc_num);
end

delete(wait_h);

% process anticyclonic eddies
wait_h = waitbar(0,'processing anticyclonic tracks..');
for i = 1 : acyc_num
    
    track = bu_anticyc_tracks{i};
    for j = 1 : size(track,1)
        pixels = h_acyc(track(j,3)).eddies(track(j,4)).Stats.PixelIdxList;
        global_acyc_heat_map(pixels) = global_acyc_heat_map(pixels) + 1;
    end
    
    waitbar(i/acyc_num);
end

delete(wait_h);