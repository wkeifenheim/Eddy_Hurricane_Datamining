%% Compile the daily eddies into one data grid
% Three dimensionsal structure 720x1440x2
% The first 720x1440 matrix features -1/1 for cyclonic/anticyclonic
% respectively.  The second 720x1440 matrix contains the eddy ID in the
% "pixel" corresponding to the first matrix.
% Also checks to ensure that eddies of opposite types are not being defined
% in the same location

load('/project/expeditions/alindell/results/viewer_data/daily_SSH/dates_all.mat');
save_dir = '/project/expeditions/woodrow/data/colormaps/';
total = length(dates);
cyc_map = zeros(720,1440);
cyc_idx_map = zeros(720,1440);
acyc_map = zeros(720,1440);
acyc_idx_map = zeros(720,1440);
colormap = zeros(720,1440,2);

wait_h = waitbar(0,'progress of compiling eddies -> colormaps');
tic
for i = 1 : total
    antiCyc = load(strcat('/project/expeditions/alindell/results/anticyclonic_copies/anticyc_copies_93-12_005_threshold_post_processed/anticyc_',...
        num2str(dates(i)),'.mat'));
    cyc = load(strcat('/project/expeditions/alindell/results/cyclonic_copies/cyclonic_copies_93-12_005_threshold_post_processed/cyclonic_',...
        num2str(dates(i)),'.mat'));
    cyc_total = size(cyc.eddies,2);
    for j = 1 : cyc_total
        pidx = cyc.eddies(j).Stats.PixelIdxList;
        cyc_map(pidx) = -1;
        cyc_idx_map(pidx) = j;
    end
    acyc_total = size(antiCyc.eddies,2);
    for j =1 : acyc_total
        pidx = antiCyc.eddies(j).Stats.PixelIdxList;
        acyc_map(pidx) = 1;
        acyc_idx_map(pidx) = j;
    end
    
    if(any(bitand(abs(cyc_map) == 1, acyc_map == 1)))
        disp('captian, we have a problem in engineering');
        fprintf('Index of problem %d\n',i);
    end
    
    colormap(:,:,1) = cyc_map + acyc_map;
    colormap(:,:,2) = cyc_idx_map + acyc_idx_map;
    save(strcat(save_dir,'colormap_',num2str(dates(i)),'.mat'), 'colormap');
    cyc_map(:) = 0; cyc_idx_map(:) = 0;
    acyc_map(:) = 0; acyc_idx_map(:) = 0;
    
    
    
    waitbar(i/total);
    toc
end
delete(wait_h);