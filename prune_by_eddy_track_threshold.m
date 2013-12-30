t = cputime;
%num_removed = 0;
e_track_length_thresh = 2;
%results = zeros(60819,1);

for i = 53790 : size(IBTrACS_eddies_1992_2010_v1_2,1)
    
    iso_date = datevec(cellstr(IBTrACS_eddies_1992_2010_v1_2(i,5)));
    year = iso_date(1);
    month = iso_date(2);
    day = iso_date(3);

    year_str = num2str(year);
    month_str = num2str(month);
    day_str = num2str(day);
    
    track_time_slice = findTimeSlice(year_str, month_str, day_str);
    track_time_slice = str2double(track_time_slice);
    j = find(double(eddy_track_date_indices(:,1)) == ...
                        track_time_slice); 
    track = NaN;
    found = 0;
    
    if(double(IBTrACS_eddies_1992_2010_v1_2(i,17)) == -1)
        track_set = bu_cyclonic_tracks;
        track_date_idx_start = 4;
        track_date_idx_end = 5;
    elseif(double(IBTrACS_eddies_1992_2010_v1_2(i,17)) == 1)
        track_set = bu_anticyc_tracks;
        track_date_idx_start = 2;
        track_date_idx_end = 3;
    end
      
    if(~isnan(double(IBTrACS_eddies_1992_2010_v1_2(i,17))))
        for k = double(eddy_track_date_indices(j,track_date_idx_start)) : ...
               double(eddy_track_date_indices(j,track_date_idx_end)) 
           temp_track = cell2mat(track_set(k));
           for l = 1 : size(temp_track,1)
               if(temp_track(l,3) == j && temp_track(l,4) == double(IBTrACS_eddies_1992_2010_v1_2(i,22)))
                   track = temp_track;
                   found = 1;
                   break
               end
           end
           if(found)
%                if(size(temp_track,1) < e_track_length_thresh)
%                    disp('removing an eddy association whose lifetime did not meet threshold');
%                    IBTrACS_eddies_1992_2010_v1_2.EddyType(i) = NaN;
%                    IBTrACS_eddies_1992_2010_v1_2.EddyLat(i) = NaN;
%                    IBTrACS_eddies_1992_2010_v1_2.EddyLon(i) = NaN;
%                    IBTrACS_eddies_1992_2010_v1_2.EddyAmp(i) = NaN;
%                    IBTrACS_eddies_1992_2010_v1_2.EddyGeoSpeed(i) = NaN;
%                    IBTrACS_eddies_1992_2010_v1_2.EddyIdx(i) = NaN;
%                    num_removed = num_removed + 1;
%                end
               results(i,1) = k;
               break
           end
        end
        if(~found) %No track was found for associated eddy -> remove it
%            IBTrACS_eddies_1992_2010_v1_2.EddyType(i) = NaN;
%            IBTrACS_eddies_1992_2010_v1_2.EddyLat(i) = NaN;
%            IBTrACS_eddies_1992_2010_v1_2.EddyLon(i) = NaN;
%            IBTrACS_eddies_1992_2010_v1_2.EddyAmp(i) = NaN;
%            IBTrACS_eddies_1992_2010_v1_2.EddyGeoSpeed(i) = NaN;
%            IBTrACS_eddies_1992_2010_v1_2.EddyIdx(i) = NaN;
%            num_removed = num_removed + 1;
             results(i,1) = NaN;
        end
    end
end

e = cputime -t