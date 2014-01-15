%retrieve the age of an eddy during an interaction

ages = zeros(60819,1);
% s = load(strcat('/project/expeditions/eddies_project_data/results/',...
%     'tracks_new_landmask_10_30_2013/lnn/bu_anticyc_new_landmask.mat'));
% bu_anti_tracks = s.bu_anticyc_tracks;
% s = load(strcat('/project/expeditions/eddies_project_data/results/',...
%     'tracks_new_landmask_10_30_2013/lnn/bu_cyclonic_new_landmask.mat'));
% bu_cyc_tracks = s.bu_cyclonic_tracks;
wait_handle = waitbar(0,'finding eddy ages..');

for i = 1 : 60819
    if(~isnan(IBTrACS_1992_2010.EddyClass(i)))
        if(isnan(IBTrACS_1992_2010.TrackIdx(i)))
            ages(i) = 1;
        else
                if(IBTrACS_1992_2010.EddyClass(i) == 1)
                    track_set = bu_anticyc_tracks;
                elseif(IBTrACS_1992_2010.EddyClass(i) == -1)
                    track_set = bu_cyclonic_tracks;
                end
                
                track = cell2mat(track_set(IBTrACS_1992_2010.TrackIdx(i)));
                j = find(eddy_track_date_indices.Date(:) == ...
                    IBTrACS_1992_2010.TimeSlice(i));
                ages(i) = find(track(:,3) == j);
                
        end
    else
        ages(i) = NaN;
    end
    waitbar(i/60819)
end
delete(wait_handle)
            