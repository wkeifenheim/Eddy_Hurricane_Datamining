%Considers each hurricane time-step, and performs a search to determine any
%eddy interaction (currently defined as hurricane center colocated over
%eddy body.
%
% Requires eddy timeslices to be loaded.. "loadEddyTimeslicesDaily.m"

wait_h = waitbar(0,'Progress of searching for nearest eddies..');
tic;

%Used by calcClosest2.m
p2ll = load('~/Documents/data/new_p2ll_720_1440.mat');
% 
% % load eddies and eddy tracks. this will take a long time, around 1-2
% % hours
% load('/project/expeditions/alindell/results/tracks/test_tracks/tracks_93-12_005_threshold/tolerance/cyclonic_tracks_processed.mat');
% load('/project/expeditions/alindell/results/tracks/test_tracks/tracks_93-12_005_threshold/tolerance/anticyc_tracks_processed.mat');
% load('/project/expeditions/alindell/results/viewer_data/daily_SSH/dates_all.mat');
% load('~/Documents/Datasets/IBTrACS_1993_2012.mat');
% loadEddyTimeslicesDaily;
% load('/project/expeditions/woodrow/data/daily_acyc_eddy_indexes.mat');
load('/project/expeditions/woodrow/data/daily_acyc_track_indexes.mat');
% load('/project/expeditions/woodrow/data/daily_cyc_eddy_indexes.mat');
load('/project/expeditions/woodrow/data/daily_cyc_track_indexes.mat');
% load('~/Documents/Datasets/IBTrACS_1993_2012.mat');

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
% Adapt to Hung's indexing
% /project/expeditions/nguy1532/eddy_repo/code/hung/hurricane_eddy_analysis/get_eddy_index_in_tracks.m
TrackIdx = nan(total,1);
EddyAge = nan(total,1);
EddyTrackLength = nan(total,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cur_date = IBTrACS_1993_2012.EddyDate(1);
eddy_timeslice_idx = find(dates == cur_date);
antiCyc = load(strcat('/project/expeditions/alindell/results/anticyclonic_copies/anticyc_copies_93-12_005_threshold_post_processed/anticyc_',...
    num2str(cur_date),'.mat'));
% antiCyc = h_acyc(eddy_timeslice_idx);
cyc = load(strcat('/project/expeditions/alindell/results/cyclonic_copies/cyclonic_copies_93-12_005_threshold_post_processed/cyclonic_',...
    num2str(cur_date),'.mat'));
% cyc = h_cyc(eddy_timeslice_idx);


for i = 1 : total
    lat = IBTrACS_1993_2012.Latitude_for_mapping(i);
    lon = IBTrACS_1993_2012.Longitude_for_mapping(i);
    
    if(cur_date ~= IBTrACS_1993_2012.EddyDate(i))
        cur_date = IBTrACS_1993_2012.EddyDate(i);
        eddy_timeslice_idx = find(dates == cur_date);
%         antiCyc = h_acyc{eddy_timeslice_idx};
        antiCyc = load(strcat('/project/expeditions/alindell/results/anticyclonic_copies/anticyc_copies_93-12_005_threshold_post_processed/anticyc_',...
            num2str(cur_date),'.mat'));
%         cyc = h_cyc{eddy_timeslice_idx};
        cyc = load(strcat('/project/expeditions/alindell/results/cyclonic_copies/cyclonic_copies_93-12_005_threshold_post_processed/cyclonic_',...
            num2str(cur_date),'.mat'));
        
    end

    
    [EddyClass(i), EddyLat(i), EddyLon(i),...
        EddyAmp(i), EddyGeoSpeed(i), EddyIdx(i), EddyPixelCount(i)] = ...
        calcClosest2(lat, lon, antiCyc, cyc, p2ll);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if(EddyClass(i,1) == -1) %cyclonic
        if(~isnan(cyc_eddy_indexes{eddy_timeslice_idx}(EddyIdx(i),1))) %tracked eddy
            TrackIdx(i,1) = cyc_eddy_indexes{eddy_timeslice_idx}(EddyIdx(i),1);
            EddyAge(i,1) = cyc_eddy_indexes{eddy_timeslice_idx}(EddyIdx(i),2);
            EddyTrackLength(i,1) = size(cyclonic_tracks(TrackIdx(i,1)),1);
        end
    elseif(EddyClass(i,1) == 1) %anticyclonic
        if(~isnan(acyc_eddy_indexes{eddy_timeslice_idx}(EddyIdx(i),1))) %tracked eddy
            TrackIdx(i,1) = acyc_eddy_indexes{eddy_timeslice_idx}(EddyIdx(i),1);
            EddyAge(i,1) = acyc_eddy_indexes{eddy_timeslice_idx}(EddyIdx(i),2);
            EddyTrackLength(i,1) = size(anticyc_tracks(TrackIdx(i,1)),1);
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %toc
    waitbar(i/total)

end
toc

names = {'EddyClass    ';'EddyLat      ';'EddyLon      ';'EddyAmp      ';...
    'EddyGeoSpeed ';'EddyIdx      ';'EddyPixelCount'; 'EddyTrackidx';...
    'EddyAge'; 'EddyTrackLength'};
eddy_prox_results = dataset({[EddyClass, EddyLat, EddyLon, EddyAmp,...
    EddyGeoSpeed, EddyIdx, EddyPixelCount, TrackIdx, EddyAge,...
    EddyTrackLength],names{:}});

% save('~/Documents/Datasets/daily_eddies/initial_results.mat',eddy_prox_results);

delete(wait_h)