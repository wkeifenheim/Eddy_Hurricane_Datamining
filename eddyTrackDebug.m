for i = 1 : size(bu_cyclonic_tracks,2)
    track = cell2mat(bu_anticyc_tracks(i));
    for j = 1 : size(track,1)
        if(track(j,3) == 1)
            if(abs(track(j,2) - -58.5650158199514) < 0.1)
                    disp('found track')
                    i
            end
        end
    end
end