%retrieve the duration of an eddy; if encountered by a hurricane time-step

lengths = zeros(60819,1);
s = load(strcat('/project/expeditions/eddies_project_data/results/',...
    'tracks_new_landmask_10_30_2013/lnn/bu_anticyc_new_landmask.mat'));
bu_anti_tracks = s.bu_anticyc_tracks;
s = load(strcat('/project/expeditions/eddies_project_data/results/',...
    'tracks_new_landmask_10_30_2013/lnn/bu_cyclonic_new_landmask.mat'));
bu_cyc_tracks = s.bu_cyclonic_tracks;
wait_handle = waitbar(0,'finding eddy lifetimes..');

for i = 1 : 60819
    if(~isnan(IBTrACS_eddies_1992_2010_working.EddyType(i)))
        if(IBTrACS_eddies_1992_2010_working.Eddy_Trk_Idx(i) == 0)
            lengths(i) = 1;
        else
                if(IBTrACS_eddies_1992_2010_working.EddyType(i) == 1)
                    track_set = bu_anti_tracks;
                    a = 2; b = 3;
                    search_eddy_tracks = 1;
                elseif(IBTrACS_eddies_1992_2010_working.EddyType(i) == -1)
                    track_set = bu_cyc_tracks;
                    a = 4; b = 5;
                    search_eddy_tracks = 1;
                end
                
                track = cell2mat(track_set(IBTrACS_eddies_1992_2010_working.Eddy_Trk_Idx(i)));
                lengths(i) = size(track,1);
                
        end
    end
    waitbar(i/60819)
end
            