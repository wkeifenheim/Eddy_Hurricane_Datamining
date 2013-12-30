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
%load('/panfs/roc/groups/6/kumarv/keifenhe/Documents/Datasets/IBTrACS_eddies_1992_2010_v2.mat'); % loads IBTrACS_eddies_1992_2010_v2 into workspace

for i=1 : size(IBTrACS_eddies_1992_2010_v2,1)
    if(isnan(double(IBTrACS_eddies_1992_2010_v2(i,20))))
        
        lat = double(IBTrACS_eddies_1992_2010_v2(i,7));
        lon = double(IBTrACS_eddies_1992_2010_v2(i,8));
        overOcean = coordsOverOceanBool(lat,lon);
        
        if(overOcean)
            IBTrACS_miss = [IBTrACS_miss; IBTrACS_eddies_1992_2010_v2(i,:)];
            miss_original_index = [miss_original_index; i];
        else
            fprintf('removing a time-step from Missed set...[%d,%d]\n', lat, lon);
            miss_removed = [miss_removed; [i,lat,lon]];
        end
        
    elseif(double(IBTrACS_eddies_1992_2010_v2(i,20)) == 1) %anticyclonic association
        
        lat = double(IBTrACS_eddies_1992_2010_v2(i,7));
        lon = double(IBTrACS_eddies_1992_2010_v2(i,8));
        overOcean = coordsOverOceanBool(lat,lon);
        
        if(overOcean)
            IBTrACS_acyc = [IBTrACS_acyc; IBTrACS_eddies_1992_2010_v2(i,:)];
            acyc_original_index = [acyc_original_index; i];
        else
            fprintf('removing a time-step from Anticyclonic set...[%d,%d]\n', lat, lon);
            acyc_removed = [acyc_removed; [i,lat,lon]];
        end
        
    elseif(double(IBTrACS_eddies_1992_2010_v2(i,20)) == -1) %cyclonic association
        
        lat = double(IBTrACS_eddies_1992_2010_v2(i,7));
        lon = double(IBTrACS_eddies_1992_2010_v2(i,8));
        overOcean = coordsOverOceanBool(lat,lon);
        
        if(overOcean)
            IBTrACS_cyc = [IBTrACS_cyc; IBTrACS_eddies_1992_2010_v2(i,:)];
            cyc_original_index = [cyc_original_index; i];
        else
            fprintf('removing a time-step from Cyclonic set...[%d,%d]\n', lat, lon);
            cyc_removed = [cyc_removed; [i,lat,lon]];
        end
        
    end
end

% Insert the original indexes in the second column
name = cellstr(['Orig_Index']);
acyc_original_index = dataset({acyc_original_index,name{:}});
cyc_original_index = dataset({cyc_original_index,name{:}});
miss_original_index = dataset({miss_original_index,name{:}});

IBTrACS_acyc = [IBTrACS_acyc(:,1),acyc_original_index,IBTrACS_acyc(:,2:end)];
IBTrACS_cyc = [IBTrACS_cyc(:,1),cyc_original_index,IBTrACS_cyc(:,2:end)];
IBTrACS_miss = [IBTrACS_miss(:,1),miss_original_index,IBTrACS_miss(:,2:end)];