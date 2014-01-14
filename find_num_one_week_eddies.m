%Determine how many eddies of only one week on a hurricane path
num_one_week = zeros(878,1);
for i = 1 : length(short_eddies)
    
    %find the starting and ending indices
    j = find(strcmp(IBTrACS_indices.IBTrACS_ID(:), short_eddies{i}));
    
    for k = IBTrACS_indices.Start_Index(j) : IBTrACS_indices.Stop_Index(j)
        if(IBTrACS_1992_2010.TrackLength(k) == 1)
            num_one_week(i) = num_one_week(i) + 1;
        end
    end
end
