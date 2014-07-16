%% Find estimated translational speed for tracked eddies


tc = one_week_tracked;
total = size(tc,1);
eddy_track_dist = zeros(total,1);

for i = 1 : total
   eclass = tc.EddyClass(i);
   trackidx = tc.EddyTrackIdx(i);
   if(eclass == -1) 
       start = bu_cyclonic_tracks{trackidx}(1,1:2);
       stop = bu_cyclonic_tracks{trackidx}(end,1:2);
       eddy_track_dist(i) = deg2km(distance(start(1),start(2), stop(1), stop(2))) /...
           size(bu_cyclonic_tracks{trackidx},1);
   elseif(eclass == 1)
       start = bu_anticyc_tracks{trackidx}(1,1:2);
       stop = bu_anticyc_tracks{trackidx}(end,1:2);
       eddy_track_dist(i) = deg2km(distance(start(1),start(2), stop(1), stop(2))) /...
           size(bu_anticyc_tracks{trackidx},1);
   end
end



% % extract first and last coordinates of eddy tracks
% for i = 1 : size(tc,1)
%    eclass = tc.EddyClass(i);
%    trackidx = tc.EddyTrackIdx(i);
%    if(eclass == -1) 
%        start = bu_cyclonic_tracks{trackidx}(1,1:2);
%        stop = bu_cyclonic_tracks{trackidx}(end,1:2);
%        cyc_t(cyc_idx,:) = [start, stop];
%        cyc_idx = cyc_idx + 1;
%    elseif(eclass == 1)
%        start = bu_anticyc_tracks{trackidx}(1,1:2);
%        stop = bu_anticyc_tracks{trackidx}(end,1:2);
%        acyc_t(acyc_idx,:) = [start, stop];
%        acyc_idx = acyc_idx + 1;
%    end
% end
% 
% % convert to distance (km)
% cyc_eddy_track_dists = deg2km(distance(cyc_t(:,1), cyc_t(:,2), cyc_t(:,3), cyc_t(:,4)));
% acyc_eddy_track_dists = deg2km(distance(acyc_t(:,1), acyc_t(:,2), acyc_t(:,3), acyc_t(:,4)));