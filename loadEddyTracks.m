%loads the bottom-up eddy tracks into the workspace

please_wait = msgbox('Loading eddy track files, this will take up to 30 seconds..');
load(strcat('/project/expeditions/eddies_project_data/results/',...
        'tracks_new_landmask_10_30_2013/lnn/bu_anticyc_new_landmask.mat'));
load(strcat('/project/expeditions/eddies_project_data/results/',...
    'tracks_new_landmask_10_30_2013/lnn/bu_cyclonic_new_landmask.mat'));
delete(please_wait)