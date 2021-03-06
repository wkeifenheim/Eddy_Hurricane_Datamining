%IBTrACS_miss - hurricane step with no eddy association
%IBTrACS_acyc = "                  " anticyclonic eddy association
%IBTrACS_cyc = "                   " cyclonic eddy association
%
% Also check that a time-step is not over land.  If time-step is over land
% then it is not appended to any dataset

IBTrACS_miss = dataset();
IBTrACS_acyc = dataset();
IBTrACS_cyc = dataset();
acyc_removed = [];
cyc_removed = [];
miss_removed = [];
acyc_original_index = [];
cyc_original_index = [];
miss_original_index = [];
%load('/panfs/roc/groups/6/kumarv/keifenhe/Documents/Datasets/IBTrACS_1992_2010_NewI_full.mat'); % loads IBTrACS_1992_2010_NewI_full into workspace
wait_h = waitbar(0,'now splitting by eddy interaction..');
total = size(IBTrACS_1992_2010_NewI,1);
for i=1 : size(IBTrACS_1992_2010_NewI,1)
    if(isnan(IBTrACS_1992_2010_NewI.EddyClass(i)))
        
        lat = IBTrACS_1992_2010_NewI.Latitude_for_mapping(i);
        lon = IBTrACS_1992_2010_NewI.Longitude_for_mapping(i);
        overOcean = coordsOverOceanBool(lat,lon);
        
        if(overOcean)
            IBTrACS_miss = [IBTrACS_miss; IBTrACS_1992_2010_NewI(i,:)];
            miss_original_index = [miss_original_index; i];
        else
            fprintf('removing a time-step from Missed set...[%d,%d]\n', lat, lon);
            miss_removed = [miss_removed; [i,lat,lon]];
        end
        
    elseif(IBTrACS_1992_2010_NewI.EddyClass(i) == 1) %anticyclonic association
        
        lat = IBTrACS_1992_2010_NewI.Latitude_for_mapping(i);
        lon = IBTrACS_1992_2010_NewI.Longitude_for_mapping(i);
        overOcean = coordsOverOceanBool(lat,lon);
        
        if(overOcean)
            IBTrACS_acyc = [IBTrACS_acyc; IBTrACS_1992_2010_NewI(i,:)];
            acyc_original_index = [acyc_original_index; i];
        else
            fprintf('removing a time-step from Anticyclonic set...[%d,%d]\n', lat, lon);
            acyc_removed = [acyc_removed; [i,lat,lon]];
        end
        
    elseif(IBTrACS_1992_2010_NewI.EddyClass(i) == -1) %cyclonic association
        
        lat = IBTrACS_1992_2010_NewI.Latitude_for_mapping(i);
        lon = IBTrACS_1992_2010_NewI.Longitude_for_mapping(i);
        overOcean = coordsOverOceanBool(lat,lon);
        
        if(overOcean)
            IBTrACS_cyc = [IBTrACS_cyc; IBTrACS_1992_2010_NewI(i,:)];
            cyc_original_index = [cyc_original_index; i];
        else
            fprintf('removing a time-step from Cyclonic set...[%d,%d]\n', lat, lon);
            cyc_removed = [cyc_removed; [i,lat,lon]];
        end
        
    end
    waitbar(i/total)
end

% Insert the original indexes in the second column
name = cellstr('Orig_Index');
acyc_original_index = dataset({acyc_original_index,name{:}});
cyc_original_index = dataset({cyc_original_index,name{:}});
miss_original_index = dataset({miss_original_index,name{:}});

IBTrACS_acyc = [IBTrACS_acyc(:,1),acyc_original_index,IBTrACS_acyc(:,2:end)];
IBTrACS_cyc = [IBTrACS_cyc(:,1),cyc_original_index,IBTrACS_cyc(:,2:end)];
IBTrACS_miss = [IBTrACS_miss(:,1),miss_original_index,IBTrACS_miss(:,2:end)];
delete(wait_h)