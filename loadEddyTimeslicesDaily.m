%loads all DAILY eddy timeslices into memory.  This takes tiiiiimmeeee

% wait_h = waitbar(0,'loading DAILY eddy timeslices..');
load('/project/expeditions/alindell/results/viewer_data/daily_SSH/dates_all.mat');
total = size(dates,1);
total1 = floor(total/2);
h_acyc = cell(total,1);
h_cyc = cell(total,1);
for i = 1 : total1
    
    timeslice = num2str(dates(i));
    anticycFile = strcat('/project/expeditions/alindell/results/anticyclonic_altered_threshold/',...
        'anticyc_', timeslice, '.mat');
    cyclonicFile = strcat('/project/expeditions/alindell/results/cyclonic_altered_threshold/',...
        'cyclonic_', timeslice, '.mat');
    acyc_eddies = load(anticycFile);
    h_acyc{i} = acyc_eddies.eddies;
    cyc_eddies = load(cyclonicFile);
    h_cyc{i} = cyc_eddies.eddies;
    
%     waitbar(i/total)
end

h_acyc2 = cell(total,1);
h_cyc2 = cell(total,1);

for i = total1+1 : total
    
    timeslice = num2str(dates(i));
    anticycFile = strcat('/project/expeditions/alindell/results/anticyclonic_altered_threshold/',...
        'anticyc_', timeslice, '.mat');
    cyclonicFile = strcat('/project/expeditions/alindell/results/cyclonic_altered_threshold/',...
        'cyclonic_', timeslice, '.mat');
    acyc_eddies = load(anticycFile);
    h_acyc2{i} = acyc_eddies.eddies;
    cyc_eddies = load(cyclonicFile);
    h_cyc2{i} = cyc_eddies.eddies;
end

% for i = 1 : (total - total1)
%     
%     timeslice = num2str(dates(i+total1));
%     anticycFile = strcat('/project/expeditions/alindell/results/anticyclonic_altered_threshold/',...
%         'anticyc_', timeslice, '.mat');
%     cyclonicFile = strcat('/project/expeditions/alindell/results/cyclonic_altered_threshold/',...
%         'cyclonic_', timeslice, '.mat');
%     h_acyc2(i) = load(anticycFile);
%     h_cyc2(i) = load(cyclonicFile);
%     
%     waitbar((i+total1)/total)
% end
% delete(wait_h)