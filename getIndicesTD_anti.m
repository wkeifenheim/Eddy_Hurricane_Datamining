%Requires a track file to be loaded..
%requires "dates.mat" to be loaded..
%Adds a column to dates.mat corresponding to the first index in a track
%file for a given date
t = cputime;
track_size = size(td_anticyc_tracks,2);
dates = [dates, zeros(size(dates,1),1)];

dates_index = 1;
search_target = 1;

for i = 1 : track_size
    track = cell2mat(td_anticyc_tracks(i));
    
    for j = 1 : size(track,1)
        if(track(j,3) == search_target)
            dates(dates_index,4) = i;
            dates_index = dates_index + 1;
            search_target = search_target + 1;
        end 
    end
    
end
disp('elapsed time:')
e = cputime-t