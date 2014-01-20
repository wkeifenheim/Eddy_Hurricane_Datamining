% determine the amplitudes and rotation before and after interaction with a
% hurricane
%Left off on i=714
% load('/panfs/roc/groups/6/kumarv/keifenhe/Documents/Datasets/eddy_track_date_indices.mat');
% load(strcat('/project/expeditions/eddies_project_data/results/',...
%     'tracks_new_landmask_10_30_2013/lnn/bu_anticyc_new_landmask.mat'));
% load(strcat('/project/expeditions/eddies_project_data/results/',...
%     'tracks_new_landmask_10_30_2013/lnn/bu_cyclonic_new_landmask.mat'));
   

%Amplitude before, Amplitude after, GeoSpeed before, GeoSpeed after
results = zeros(size(IBTrACS_five_plus,1),4);
timeslice_indices = eddy_track_date_indices.Date(:);
wait_h = waitbar(0,'progress');
stop = size(IBTrACS_five_plus,1);

for i = 1 : stop
   
   cur_time = IBTrACS_five_plus.TimeSlice(i);
   j = find(timeslice_indices == cur_time);
   
   
   k = IBTrACS_five_plus.EddyTrackIdx(i);
   l = IBTrACS_five_plus.EddyAge(i);
   
   if(IBTrACS_five_plus.EddyClass(i) == -1) %cyclonic
       
       track = cell2mat(bu_cyclonic_tracks(k));
       %get previous values, if there are any
       if(l ~= 1)
           old_eddy_idx = track(l-1, 4);
           eddy = h_cyc(j-1).eddies(old_eddy_idx);
           results(i,1) = eddy.Amplitude;
           results(i,3) = eddy.MeanGeoSpeed;
       else
           results(i,1) = NaN;
           results(i,3) = NaN;
       end
       
       %get future values
       if(l < IBTrACS_five_plus.EddyTrackLength(i))
           future_eddy_idx = track(l+1, 4);
           eddy = h_cyc(j+1).eddies(future_eddy_idx);
           results(i,2) = eddy.Amplitude;
           results(i,4) = eddy.MeanGeoSpeed;
       else
           results(i,2) = NaN;
           results(i,4) = NaN;
       end       
       
    
   elseif(IBTrACS_five_plus.EddyClass(i) == 1) %anticyclonic
       
       track = cell2mat(bu_anticyc_tracks(k));
       %get previous values, if there are any
       if(l ~= 1)
           old_eddy_idx = track(l-1, 4);
           eddy = h_acyc(j-1).eddies(old_eddy_idx);
           results(i,1) = eddy.Amplitude;
           results(i,3) = eddy.MeanGeoSpeed;
       else
           results(i,1) = NaN;
           results(i,3) = NaN;
       end
       
       %get future values
       if(l ~= IBTrACS_five_plus.EddyTrackLength(i))
           old_eddy_idx = track(l+1, 4);
           eddy = h_acyc(j+1).eddies(old_eddy_idx);
           results(i,2) = eddy.Amplitude;
           results(i,4) = eddy.MeanGeoSpeed;
       else
           results(i,2) = NaN;
           results(i,4) = NaN;
       end
   end
   waitbar(i/stop)
end
delete(wait_h)