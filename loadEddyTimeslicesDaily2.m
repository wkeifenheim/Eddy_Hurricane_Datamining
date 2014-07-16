%% load eddies
function eddies_cells = load_eddies_cells(type, dates)
if strcmp(type, 'cyclonic') == 1
    eddy_dir = '/project/expeditions/alindell/results/cyclonic_copies/cyclonic_copies_93-12_005_threshold_post_processed';
else
    eddy_dir = '/project/expeditions/alindell/results/anticyclonic_copies/anticyc_copies_93-12_005_threshold_post_processed';
end

%load('/project/expeditions/alindell/results/viewer_data/daily_SSH/dates_all.mat');

eddies_cells = cell(size(dates));
parfor i = 1:2500
    temp = load([eddy_dir type '_' num2str(dates(i)) '.mat']);
    eddies = temp.eddies;
    eddies_cells{i} = eddies;
end
parfor i = 2501:5000
    temp = load([eddy_dir type '_' num2str(dates(i)) '.mat']);
    eddies = temp.eddies;
    eddies_cells{i} = eddies;
end
parfor i = 5001:7305
    temp = load([eddy_dir type '_' num2str(dates(i)) '.mat']);
    eddies = temp.eddies;
    eddies_cells{i} = eddies;
end