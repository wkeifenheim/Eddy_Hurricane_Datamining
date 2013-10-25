% Takes a list of indeces and a target column, and returns a vector of
% values cooresponding to the target at the input indeces + 1...
% Intended to check what values the immediate time-step has
% Contains a sanity check that inserts NaN into target_vector if an index+1
% step does not belong to the same series (hurricane).

function target_vectors = getNextStepVals(indeces,target_columns)

    target_vectors = zeros(length(indeces),length(target_columns));
    load('/project/expeditions/woodrow/Datasets/EBTracks_Atlantic1992-2010v4.mat');
    for i = 1 : length(indeces)
        
        j = indeces(i);
        if(j == size(ebtrkatlc1992_2010,1))
            target_vectors(i,:) = NaN;
            break
        end
        hurricane_ID = cellstr(ebtrkatlc1992_2010(j,1));
        next_hurricane_ID = cellstr(ebtrkatlc1992_2010(j+1,1));
        if(strcmp(hurricane_ID, next_hurricane_ID))
            target_vectors(i,:) = double(ebtrkatlc1992_2010(j+1,target_columns));
        else
            target_vectors(i,:) = NaN;
        end
        
    end
            
end