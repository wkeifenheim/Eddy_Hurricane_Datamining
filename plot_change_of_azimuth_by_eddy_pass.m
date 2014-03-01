%Find the mean change of direction for each type of pass through an eddy
first_idx = false(size(IBTrACS_1992_2010,1),1);
first_idx(1) = true;
cur_hur = IBTrACS_1992_2010.Serial_Num(1);

%Az_d1 cuttoff value for pruning hurricane direction deltas
az_d_cuttoff = 32.2307;

disp_25 = prctile(IBTr_eddies.Displacement_d1(:),25);
disp_50 = prctile(IBTr_eddies.Displacement_d1(:),50);
disp_75 = prctile(IBTr_eddies.Displacement_d1(:),75);
disp_100 = prctile(IBTr_eddies.Displacement_d1(:),100);

for i = 1 : size(IBTrACS_1992_2010,1)
    if(~strcmp(cur_hur, IBTrACS_1992_2010.Serial_Num(i)))
        cur_hur = IBTrACS_1992_2010.Serial_Num(i);
        first_idx(i) = true;
    end
    
end


%remove first timesteps from dataset
ibt_no_first = IBTrACS_1992_2010(~first_idx,:);

%results needs to be in the workspace, having been computed with the
%appropriate threshold
res_no_first = results(~first_idx);

%%%%
ibt_no_first_bak = ibt_no_first;
res_no_first_bak = res_no_first;

cur_hur = ibt_no_first.Serial_Num(1);
enter_eddy = false(size(ibt_no_first,1),1);
leave_eddy = false(size(ibt_no_first,1),1);
for i = 1 : size(ibt_no_first,1) - 1
    if(~strcmp(cur_hur, ibt_no_first.Serial_Num(i)))
        cur_hur = ibt_no_first.Serial_Num(i);
    else
        if(strcmp(cur_hur,ibt_no_first.Serial_Num(i+1)))
            if(isnan(ibt_no_first.EddyClass(i)) && ~isnan(ibt_no_first.EddyClass(i+1)))
                enter_eddy(i+1) = true;
            elseif(~isnan(ibt_no_first.EddyClass(i)) && isnan(ibt_no_first.EddyClass(i+1)))
                leave_eddy(i) = true;
            end
            
        end
        
    end
    
end

%indexing below depends on eddy class, which the first step after an eddy
%encounter does not have:
% for i = 1 : length(leave_eddy)
%     if(leave_eddy(i))
%         leave_eddy(i-1) = true;
%     end
% end

%for restoring....
ibt_no_first = ibt_no_first_bak;
res_no_first = res_no_first_bak;

%pick your poison... leave_eddy or enter_eddy
ibt_no_first = ibt_no_first(leave_eddy,:);
res_no_first = res_no_first(leave_eddy,:);

%prune dataset to exclude Az_d1 larger than az_d_cuttoff
cut_idx = abs(ibt_no_first.Az_d1(:)) <= az_d_cuttoff;
ibt_no_first = ibt_no_first(cut_idx,:);
res_no_first = res_no_first(cut_idx,:);

%prune by translational distance...
% cut_idx = bitand(ibt_no_first.Displacement_d1(:) > disp_75,...
%    ibt_no_first.Displacement_d1(:) <= disp_100);
% ibt_no_first = ibt_no_first(cut_idx,:);
% res_no_first = res_no_first(cut_idx,:);


n_ratios = zeros(3,2);
s_ratios = zeros(3,2);
n_dev = zeros(3,2); %standard deviations
s_dev = zeros(3,2); %" "
n_count = zeros(3,2);
s_count = zeros(3,2);

n_cyc_left_idx = bitand(bitand(ibt_no_first.EddyClass(:) == -1,...
    ibt_no_first.Latitude_for_mapping(:) > 0), res_no_first(:) == -1);
n_cyc_center_idx = bitand(bitand(ibt_no_first.EddyClass(:) == -1,...
    ibt_no_first.Latitude_for_mapping(:) > 0), res_no_first(:) == 0);
n_cyc_right_idx = bitand(bitand(ibt_no_first.EddyClass(:) == -1,...
    ibt_no_first.Latitude_for_mapping(:) > 0), res_no_first(:) == 1);
n_acyc_left_idx = bitand(bitand(ibt_no_first.EddyClass(:) == 1,...
    ibt_no_first.Latitude_for_mapping(:) > 0), res_no_first(:) == -1);
n_acyc_center_idx = bitand(bitand(ibt_no_first.EddyClass(:) == 1,...
    ibt_no_first.Latitude_for_mapping(:) > 0), res_no_first(:) == 0);
n_acyc_right_idx = bitand(bitand(ibt_no_first.EddyClass(:) == 1,...
    ibt_no_first.Latitude_for_mapping(:) > 0), res_no_first(:) == 1);

%enable if analysing eddy exits, offsets to grab Az_d1 after exit
% n_cyc_left_idx = [false; n_cyc_left_idx(1:end-1)];
% n_cyc_center_idx = [false; n_cyc_center_idx(1:end-1)];
% n_cyc_right_idx = [false; n_cyc_right_idx(1:end-1)];
% n_acyc_left_idx = [false; n_acyc_left_idx(1:end-1)];
% n_acyc_center_idx = [false; n_acyc_center_idx(1:end-1)];
% n_acyc_right_idx = [false; n_acyc_right_idx(1:end-1)];


s_cyc_left_idx = bitand(bitand(ibt_no_first.EddyClass(:) == -1,...
    ibt_no_first.Latitude_for_mapping(:) < 0), res_no_first(:) == -1);
s_cyc_center_idx = bitand(bitand(ibt_no_first.EddyClass(:) == -1,...
    ibt_no_first.Latitude_for_mapping(:) < 0), res_no_first(:) == 0);
s_cyc_right_idx = bitand(bitand(ibt_no_first.EddyClass(:) == -1,...
    ibt_no_first.Latitude_for_mapping(:) < 0), res_no_first(:) == 1);
s_acyc_left_idx = bitand(bitand(ibt_no_first.EddyClass(:) == 1,...
    ibt_no_first.Latitude_for_mapping(:) < 0), res_no_first(:) == -1);
s_acyc_center_idx = bitand(bitand(ibt_no_first.EddyClass(:) == 1,...
    ibt_no_first.Latitude_for_mapping(:) < 0), res_no_first(:) == 0);
s_acyc_right_idx = bitand(bitand(ibt_no_first.EddyClass(:) == 1,...
    ibt_no_first.Latitude_for_mapping(:) < 0), res_no_first(:) == 1);

%enable if analysing eddy exits
% s_cyc_left_idx = [false; s_cyc_left_idx(1:end-1)];
% s_cyc_center_idx = [false; s_cyc_center_idx(1:end-1)];
% s_cyc_right_idx = [false; s_cyc_right_idx(1:end-1)];
% s_acyc_left_idx = [false; s_acyc_left_idx(1:end-1)];
% s_acyc_center_idx = [false; s_acyc_center_idx(1:end-1)];
% s_acyc_right_idx = [false; s_acyc_right_idx(1:end-1)];

n_ratios(1,1) = nanmean(ibt_no_first.Az_d1(n_cyc_left_idx));
n_ratios(1,2) = nanmean(ibt_no_first.Az_d1(n_acyc_left_idx));
n_ratios(2,1) = nanmean(ibt_no_first.Az_d1(n_cyc_center_idx));
n_ratios(2,2) = nanmean(ibt_no_first.Az_d1(n_acyc_center_idx));
n_ratios(3,1) = nanmean(ibt_no_first.Az_d1(n_cyc_right_idx));
n_ratios(3,2) = nanmean(ibt_no_first.Az_d1(n_acyc_right_idx));

n_dev(1,1) = nanstd(ibt_no_first.Az_d1(n_cyc_left_idx));
n_dev(1,2) = nanstd(ibt_no_first.Az_d1(n_acyc_left_idx));
n_dev(2,1) = nanstd(ibt_no_first.Az_d1(n_cyc_center_idx));
n_dev(2,2) = nanstd(ibt_no_first.Az_d1(n_acyc_center_idx));
n_dev(3,1) = nanstd(ibt_no_first.Az_d1(n_cyc_right_idx));
n_dev(3,2) = nanstd(ibt_no_first.Az_d1(n_acyc_right_idx));

n_count(1,1) = sum(n_cyc_left_idx);
n_count(1,2) = sum(n_acyc_left_idx);
n_count(2,1) = sum(n_cyc_center_idx);
n_count(2,2) = sum(n_acyc_center_idx);
n_count(3,1) = sum(n_cyc_right_idx);
n_count(3,2) = sum(n_acyc_right_idx);

s_ratios(1,1) = nanmean(ibt_no_first.Az_d1(s_cyc_left_idx));
s_ratios(1,2) = nanmean(ibt_no_first.Az_d1(s_acyc_left_idx));
s_ratios(2,1) = nanmean(ibt_no_first.Az_d1(s_cyc_center_idx));
s_ratios(2,2) = nanmean(ibt_no_first.Az_d1(s_acyc_center_idx));
s_ratios(3,1) = nanmean(ibt_no_first.Az_d1(s_cyc_right_idx));
s_ratios(3,2) = nanmean(ibt_no_first.Az_d1(s_acyc_right_idx));

s_dev(1,1) = nanstd(ibt_no_first.Az_d1(s_cyc_left_idx));
s_dev(1,2) = nanstd(ibt_no_first.Az_d1(s_acyc_left_idx));
s_dev(2,1) = nanstd(ibt_no_first.Az_d1(s_cyc_center_idx));
s_dev(2,2) = nanstd(ibt_no_first.Az_d1(s_acyc_center_idx));
s_dev(3,1) = nanstd(ibt_no_first.Az_d1(s_cyc_right_idx));
s_dev(3,2) = nanstd(ibt_no_first.Az_d1(s_acyc_right_idx));

s_count(1,1) = sum(s_cyc_left_idx);
s_count(1,2) = sum(s_acyc_left_idx);
s_count(2,1) = sum(s_cyc_center_idx);
s_count(2,2) = sum(s_acyc_center_idx);
s_count(3,1) = sum(s_cyc_right_idx);
s_count(3,2) = sum(s_acyc_right_idx);

n_stats = [n_count(:,1),n_ratios(:,1),n_dev(:,1),...
    n_count(:,2),n_ratios(:,2),n_dev(:,2)];

s_stats = [s_count(:,1),s_ratios(:,1),s_dev(:,1),...
    s_count(:,2),s_ratios(:,2),s_dev(:,2)];