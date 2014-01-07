wait_h = waitbar(0,'Progress of searching for nearest eddies..');
tic;
%results = zeros(60819,8);

EddyClass = zeros(60819,1);
EddyLat = zeros(60819,1);
EddyLon = zeros(60819,1);
EddyAmp = zeros(60819,1);
EddyGeoSpeed = zeros(60819,1);
EddyIdx = zeros(60819,1);
TrackIdx = zeros(60819,1);
 
% load('/project/expeditions/eddies_project_data/results/tracks_new_landmask_10_30_2013/lnn/bu_anticyc_new_landmask.mat');
% load('/project/expeditions/eddies_project_data/results/tracks_new_landmask_10_30_2013/lnn/bu_cyclonic_new_landmask.mat');

cur_slice = IBTrACS_All_1992_2010.TimeSlice(1);
time_slice = IBTrACS_All_1992_2010.TimeSlice(1);
time_slice = num2str(time_slice);
anticycFile = strcat('/project/expeditions/eddies_project_data/results/new_bottom_up_w_land_mask_09_16_2013/',...
    'anticyc_', time_slice, '.mat');
cyclonicFile = strcat('/project/expeditions/eddies_project_data/results/new_bottom_up_w_land_mask_09_16_2013/',...
    'cyclonic_', time_slice, '.mat');
antiCyc = load(anticycFile);
cyc = load(cyclonicFile);
 
 % Capped to stop after 2010 dates are run
for i = 1 : 60819
    lat = IBTrACS_All_1992_2010.Latitude_for_mapping(i);
    lon = IBTrACS_All_1992_2010.Longitude_for_mapping(i);
    
    if(cur_slice ~= IBTrACS_All_1992_2010.TimeSlice(i))
        cur_slice = IBTrACS_All_1992_2010.TimeSlice(i);
        time_slice = IBTrACS_All_1992_2010.TimeSlice(i);
        time_slice = num2str(time_slice);
        anticycFile = strcat('/project/expeditions/eddies_project_data/results/new_bottom_up_w_land_mask_09_16_2013/',...
            'anticyc_', time_slice, '.mat');
        cyclonicFile = strcat('/project/expeditions/eddies_project_data/results/new_bottom_up_w_land_mask_09_16_2013/',...
            'cyclonic_', time_slice, '.mat');
        antiCyc = load(anticycFile);
        cyc = load(cyclonicFile);
    end

    
    [EddyClass(i), EddyLat(i), EddyLon(i),...
        EddyAmp(i), EddyGeoSpeed(i), EddyIdx(i)] = ...
        calcClosest(lat,lon, antiCyc, cyc);
    
    %Retain eddy association only if corresponding eddyTrack lasted longer
    %than "e_track_length_thresh"
%     track_time_slice = findTimeSlice(year_str, month_str, day_str);
%     track_time_slice = str2num(track_time_slice);

    track_time_slice = IBTrACS_All_1992_2010.TimeSlice(i);
    j = find(double(eddy_track_date_indices(:,1)) == ...
                        track_time_slice);
    track = NaN;
    found = 0;
    search_eddy_tracks = 0;
    TrackIdx(i) = NaN;
    
    if(EddyClass(i) == 1)
        track_set = bu_anticyc_tracks;
        a = 2; b = 3;
        search_eddy_tracks = 1;
    elseif(EddyClass(i) == -1)
        track_set = bu_cyclonic_tracks;
        a = 4; b = 5;
        search_eddy_tracks = 1;
    end
    
    if(search_eddy_tracks)
        %disp('starting search for eddy_tracks..')
        %toc
        for k = double(eddy_track_date_indices(j,a)) : ...
                double(eddy_track_date_indices(j,b));
           temp_track = cell2mat(track_set(k));
           for l = 1 : size(temp_track,1)
               if(temp_track(l,3) == j && temp_track(l,4) == EddyIdx(i))
                   track = temp_track;
                   found = 1;
                   TrackIdx(i) = k;
                   %disp('found a track!')
                   break
               end
           end
           if(found)
%                if(size(temp_track,1) < e_track_length_thresh)
%                    disp('removing an eddy association whose lifetime did not meet threshold');
%                    results(i,:) = NaN;
%                end
               break
           end         
        end
    end
    
    %toc
    waitbar(i/60819)

end
toc
delete(wait_h)