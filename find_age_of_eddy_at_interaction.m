%Find out the "age" at which there was a hurricane
%interaction

%Set to whichever lifetime threshold you want
ibtracs_subset = IBTrACS_five_plus;
we_done = size(ibtracs_subset,1);
eddy_age = zeros(size(ibtracs_subset,1),1);
% timeslice_idx = zeros(we_done,1);

wait_h = waitbar(0,'progress..');
for i = 1 : we_done
    j = ibtracs_subset.TrackIdx(i);
    slice = ibtracs_subset.TimeSlice(i);
    k = find(eddy_track_date_indices.Date(:) == slice);
    
    if(ibtracs_subset.EddyClass(i) == -1)
        track = cell2mat(bu_cyclonic_tracks(j));
    else
        track = cell2mat(bu_anticyc_tracks(j));
    end
    
    eddy_age(i) = find(track(:,3) == k);
    
    
    waitbar(i/we_done)
end
delete(wait_h)