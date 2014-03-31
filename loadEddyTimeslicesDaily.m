%loads all DAILY eddy timeslices into memory.  This takes tiiiiimmeeee

wait_h = waitbar(0,'loading DAILY eddy timeslices..');
load('/project/expeditions/nguy1532/eddy_repo/code/hung/interpolation/daily_dates.mat');
total = size(daily_dates,1);
for i = 1 : 10
    
    timeslice = num2str(daily_dates(i));
    anticycFile = strcat('/project/expeditions/nguy1532/eddy_repo/code/hung/interpolation/interpolated_eddies/',...
        'anticyc_', timeslice, '.mat');
    cyclonicFile = strcat('/project/expeditions/nguy1532/eddy_repo/code/hung/interpolation/interpolated_eddies/',...
        'cyclonic_', timeslice, '.mat');
    h_acyc(i) = load(anticycFile);
    h_cyc(i) = load(cyclonicFile);
    
    waitbar(i/10)
end
delete(wait_h)