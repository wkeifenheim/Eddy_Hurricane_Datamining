ends = zeros(954,1);
j_start = size(bu_cyclonic_tracks,2);
for i = 954 :-1: 1
    for j = j_start :-1: double(eddy_track_date_indices(i,4))
        b = cell2mat(bu_cyclonic_tracks(j));
        if(sum(b(:,3) == i))
            ends(i,1) = j;
            disp('the end')
            j
            clear('b');
            j_start = j;
            break
        end
        clear('b');
    end
    i
end