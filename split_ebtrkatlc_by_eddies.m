%ebtrkatlc_miss - hurricane step with no eddy association
%ebtrkatlc_acyc = "                  " anticyclonic eddy association
%ebtrkatlc_cyc = "                   " cyclonic eddy association
%
% Also check that a time-step is not over land.  If time-step is over land
% then it is not appended to any dataset

ebtrkatlc_miss = dataset();
ebtrkatlc_acyc = dataset();
ebtrkatlc_cyc = dataset();
acyc_removed = [];
cyc_removed = [];
miss_removed = [];
acyc_original_index = [];
cyc_original_index = [];
miss_original_index = [];
load('/panfs/roc/groups/6/kumarv/keifenhe/Documents/Datasets/EBTracks_Atlantic1992-2010v4.mat'); % loads ebtrkatlc1992_2010 into workspace

for i=1 : size(ebtrkatlc1992_2010,1)
    if(isnan(double(ebtrkatlc1992_2010(i,18))))
        
        lat = double(ebtrkatlc1992_2010(i,7));
        lon = double(ebtrkatlc1992_2010(i,8));
        overOcean = coordsOverOceanBool(lat,lon);
        
        if(overOcean)
            ebtrkatlc_miss = [ebtrkatlc_miss; ebtrkatlc1992_2010(i,:)];
            miss_original_index = [miss_original_index; i];
        else
            fprintf('removing a time-step from Missed set...[%d,%d]\n', lat, lon);
            miss_removed = [miss_removed; [i,lat,lon]];
        end
        
    elseif(double(ebtrkatlc1992_2010(i,18)) == 1) %anticyclonic association
        
        lat = double(ebtrkatlc1992_2010(i,7));
        lon = double(ebtrkatlc1992_2010(i,8));
        overOcean = coordsOverOceanBool(lat,lon);
        
        if(overOcean)
            ebtrkatlc_acyc = [ebtrkatlc_acyc; ebtrkatlc1992_2010(i,:)];
            acyc_original_index = [acyc_original_index; i];
        else
            fprintf('removing a time-step from Anticyclonic set...[%d,%d]\n', lat, lon);
            acyc_removed = [acyc_removed; [i,lat,lon]];
        end
        
    elseif(double(ebtrkatlc1992_2010(i,18)) == -1) %cyclonic association
        
        lat = double(ebtrkatlc1992_2010(i,7));
        lon = double(ebtrkatlc1992_2010(i,8));
        overOcean = coordsOverOceanBool(lat,lon);
        
        if(overOcean)
            ebtrkatlc_cyc = [ebtrkatlc_cyc; ebtrkatlc1992_2010(i,:)];
            cyc_original_index = [cyc_original_index; i];
        else
            fprintf('removing a time-step from Cyclonic set...[%d,%d]\n', lat, lon);
            cyc_removed = [cyc_removed; [i,lat,lon]];
        end
        
    end
end

% Insert the original indexes in the third column
name = cellstr(['Orig_Index']);
acyc_original_index = dataset({acyc_original_index,name{:}});
cyc_original_index = dataset({cyc_original_index,name{:}});
miss_original_index = dataset({miss_original_index,name{:}});

ebtrkatlc_acyc = [ebtrkatlc_acyc(:,1:2),acyc_original_index,ebtrkatlc_acyc(:,3:end)];
ebtrkatlc_cyc = [ebtrkatlc_cyc(:,1:2),cyc_original_index,ebtrkatlc_cyc(:,3:end)];
ebtrkatlc_miss = [ebtrkatlc_miss(:,1:2),miss_original_index,ebtrkatlc_miss(:,3:end)];