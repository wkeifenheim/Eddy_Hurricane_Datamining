
category = cell(60819,1);
% load('/project/expeditions/woodrow/Datasets/landmask_datagrid.mat');
wait_h = waitbar(0, 'progress');

for i = 1 : 60819
        windspeed = IBTrACS_1992_2010.WindWMO(i);
        if(isnan(windspeed))
            category{i} = 'unknown';
        elseif(windspeed >= 64 && windspeed <= 82)
            category{i} = '1';
        elseif(windspeed >= 83 && windspeed <= 95)
            category{i} = '2';
        elseif(windspeed >= 96 && windspeed <= 112)
            category{i} = '3';
        elseif(windspeed >= 113 && windspeed <= 136)
            category{i} = '4';
        elseif(windspeed >= 137)
            category{i} = '5';
        elseif(windspeed <= 33)
            category{i} = 'TD'; %tropical depression
        elseif(windspeed > 33 && windspeed < 64)
            category{i} = 'TS'; %tropical storm
        else
            category{i} = 'unknown';
        end
    waitbar(i/60819)
end
delete(wait_h)