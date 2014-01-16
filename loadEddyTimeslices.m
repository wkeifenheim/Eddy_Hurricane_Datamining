%loads all eddy timeslices into memory.  This takes tiiiiimmeeee

wait_h = waitbar(0,'loading eddy timeslices..');
load('/panfs/roc/groups/6/kumarv/keifenhe/Documents/Datasets/eddy_track_date_indices.mat');
for i = 1 : 954
    
    timeslice = num2str(eddy_track_date_indices.Date(i));
    anticycFile = strcat('/project/expeditions/eddies_project_data/results/new_bottom_up_w_land_mask_09_16_2013/',...
        'anticyc_', timeslice, '.mat');
    cyclonicFile = strcat('/project/expeditions/eddies_project_data/results/new_bottom_up_w_land_mask_09_16_2013/',...
        'cyclonic_', timeslice, '.mat');
    h_acyc(i) = load(anticycFile);
    h_cyc(i) = load(cyclonicFile);
    
    waitbar(i/954)
end
delete(wait_h)