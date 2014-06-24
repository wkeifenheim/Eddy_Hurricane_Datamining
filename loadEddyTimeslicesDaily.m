%loads all DAILY eddy timeslices into memory.  This takes tiiiiimmeeee

wait_h = waitbar(0,'loading DAILY eddy timeslices..');
load('/project/expeditions/alindell/results/viewer_data/daily_SSH/dates_all.mat');
total = size(dates,1);
for i = 1 : total
    
    timeslice = num2str(dates(i));
    anticycFile = strcat('/project/expeditions/alindell/results/anticyclonic_copies/anticyc_copies_93-12_post_processed/',...
        'anticyc_', timeslice, '.mat');
    cyclonicFile = strcat('/project/expeditions/alindell/results/cyclonic_copies/cyclonic_copies_93-12_post_processed/',...
        'cyclonic_', timeslice, '.mat');
    h_acyc(i) = load(anticycFile);
    h_cyc(i) = load(cyclonicFile);
    
    waitbar(i/total)
end
delete(wait_h)