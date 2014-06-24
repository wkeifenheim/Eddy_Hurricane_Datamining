%Considers each hurricane time-step, and performs a search to determine any
%eddy interaction (currently defined as hurricane center colocated over
%eddy body.
%
% Requires eddy timeslices to be loaded.. "loadEddyTimeslicesDaily.m"

wait_h = waitbar(0,'Progress of searching for nearest eddies..');
tic;

%Used by calcClosest.m
p2ll = load('/project/expeditions/eddies_project_data/ssh_data/data/pixels_2_lat_lon_map.mat');

% load eddies and eddy tracks. this will take a long time, around 1-2
% hours
load('/project/expeditions/alindell/results/tracks/test_tracks/tracks_93-12/cyclonic_tracks_processed.mat');
load('/project/expeditions/alindell/results/tracks/test_tracks/tracks_93-12/anticyc_tracks_processed.mat');
load('/project/expeditions/alindell/results/viewer_data/daily_SSH/dates_all.mat');
load('~/Documents/Datasets/IBTrACS_1993_2012.mat');
loadEddyTimeslicesDaily;

% load base IBTrACS data
total = size(IBTrACS_1993_2012,1);

EddyClass = zeros(total,1);
EddyLat = zeros(total,1);
EddyLon = zeros(total,1);
EddyAmp = zeros(total,1);
EddyGeoSpeed = zeros(total,1);
EddyIdx = zeros(total,1);
EddyPixelCount = zeros(total,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Adopt to Hung's indexing
% /project/expeditions/nguy1532/eddy_repo/code/hung/hurricane_eddy_analysis/get_eddy_index_in_tracks.m
% TrackIdx = zeros(60819,1);
% EddyAge = zeros(60819,1);
% EddyTrackLength = zeros(60819,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cur_date = IBTrACS_1992_2010_daily.EddyDate(1);
eddy_timeslice_idx = find(daily_dates == cur_date);
antiCyc = h_acyc(eddy_timeslice_idx);
cyc = h_cyc(eddy_timeslice_idx);


for i = 1 : size(IBTrACS_1992_2010_daily,1)
    lat = IBTrACS_1992_2010_daily.Latitude_for_mapping(i);
    lon = IBTrACS_1992_2010_daily.Longitude_for_mapping(i);
    
    if(cur_date ~= IBTrACS_1992_2010_daily.EddyDate(i))
        cur_date = IBTrACS_1992_2010_daily.EddyDate(i);
        eddy_timeslice_idx = find(daily_dates == cur_date);
        antiCyc = h_acyc(eddy_timeslice_idx);
        cyc = h_cyc(eddy_timeslice_idx);
        
    end

    
    [EddyClass(i), EddyLat(i), EddyLon(i),...
        EddyAmp(i), EddyGeoSpeed(i), EddyIdx(i), EddyPixelCount(i)] = ...
        calcClosest2(lat,lon, antiCyc, cyc, p2ll);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Adopt Hung's indexing
%     j = find(double(eddy_track_date_indices(:,1)) == ...
%                         track_time_slice);    
%     track = NaN;
%     found = 0;
%     search_eddy_tracks = 0;
%     TrackIdx(i) = NaN;
%     
%     if(EddyClass(i) == 1)
%         track_set = bu_anticyc_tracks;
%         a = 2; b = 3;
%         search_eddy_tracks = 1;
%     elseif(EddyClass(i) == -1)
%         track_set = bu_cyclonic_tracks;
%         a = 4; b = 5;
%         search_eddy_tracks = 1;
%     end
%     
%     if(search_eddy_tracks)
%         %disp('starting search for eddy_tracks..')
%         %toc
%         for k = double(eddy_track_date_indices(j,a)) : ...
%                 double(eddy_track_date_indices(j,b));
%            temp_track = cell2mat(track_set(k));
%            for l = 1 : size(temp_track,1)
%                if(temp_track(l,3) == j && temp_track(l,4) == EddyIdx(i))
%                    track = temp_track;
%                    found = 1;
%                    TrackIdx(i) = k;
%                    %disp('found a track!')
%                    break
%                end
%            end
%            if(found)
% %                if(size(temp_track,1) < e_track_length_thresh)
% %                    disp('removing an eddy association whose lifetime did not meet threshold');
% %                    results(i,:) = NaN;
% %                end
%                break
%            end         
%         end
%     end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %toc
    waitbar(i/60819)

end
toc

names = {'EddyClass    ';'EddyLat      ';'EddyLon      ';'EddyAmp      ';...
    'EddyGeoSpeed ';'EddyIdx      ';'EddyPixelCount'};
eddy_prox_results = dataset({[EddyClass, EddyLat, EddyLon, EddyAmp,...
    EddyGeoSpeed, EddyIdx, EddyPixelCount],names{:}});

delete(wait_h)