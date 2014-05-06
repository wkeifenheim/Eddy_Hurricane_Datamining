% Experiement to determine any latitude-dependent correlation of the
% cyclonic/anticyclonic ratios of hurricane encountered eddies.

% latitude increments
increments = 0:10:70;

% for easier generalization
data = IBTrACS_1992_2010(~isnan(IBTrACS_1992_2010.EddyClass),:);

% columns = [cyc/acyc_ratio, cyc_count, acyc_count]
n_results = NaN(7,3);
s_results = NaN(7,3);


for i = 1 : length(increments) - 1
    lower_bound = increments(i);
    upper_bound = increments(i+1);
    
    n_idx = bitand(data.Latitude_for_mapping <= upper_bound,...
        data.Latitude_for_mapping > lower_bound);
    s_idx = bitand(data.Latitude_for_mapping < -lower_bound,...
        data.Latitude_for_mapping >= -upper_bound);
    
    ibt_lat_seged.N{i} = data(n_idx,:);
    ibt_lat_seged.S{i} = data(s_idx,:);
    
    n_cyc = sum(ibt_lat_seged.N{i}.EddyClass == -1);
    n_acyc = sum(ibt_lat_seged.N{i}.EddyClass == 1);
    n_results(i,2) = n_cyc;
    n_results(i,3) = n_acyc;
    n_results(i) = n_cyc / n_acyc;
    s_cyc = sum(ibt_lat_seged.S{i}.EddyClass == -1);
    s_acyc = sum(ibt_lat_seged.S{i}.EddyClass == 1);
    s_results(i,2) = s_cyc;
    s_results(i,3) = s_acyc;
    s_results(i) = s_cyc / s_acyc;
end

ibt_lat_seged.increments = increments;

%% Further segment by hurricane category
hur_cats = {'unknown';'TS';'TD';'1';'2';'3';'4';'5'};
for i = 1 : 7
    figure;
    
    %% Northern Hemisphere
    subplot(2,1,1);
    temp = ibt_lat_seged.N{i};
    t_idx = bitor(bitor(strcmp(temp.Category, hur_cats{1}),strcmp(temp.Category, hur_cats{2})),...
        strcmp(temp.Category, hur_cats{3}));
    one_idx = strcmp(temp.Category, hur_cats{4});
    two_idx = strcmp(temp.Category, hur_cats{5});
    three_idx = strcmp(temp.Category, hur_cats{6});
    four_idx = strcmp(temp.Category, hur_cats{7});
    five_idx = strcmp(temp.Category, hur_cats{8});
    y = zeros(6,1);
    y(1) = sum(bitand(temp.EddyClass == -1, t_idx)) / sum(bitand(temp.EddyClass == 1, t_idx)); %tropical
    y(2) = sum(bitand(temp.EddyClass == -1, one_idx)) / sum(bitand(temp.EddyClass == 1, one_idx)); % cat 1
    y(3) = sum(bitand(temp.EddyClass == -1, two_idx)) / sum(bitand(temp.EddyClass == 1, two_idx));
    y(4) = sum(bitand(temp.EddyClass == -1, three_idx)) / sum(bitand(temp.EddyClass == 1, three_idx));
    y(5) = sum(bitand(temp.EddyClass == -1, four_idx)) / sum(bitand(temp.EddyClass == 1, four_idx));
    y(6) = sum(bitand(temp.EddyClass == -1, five_idx)) / sum(bitand(temp.EddyClass == 1, five_idx)); % cat 5
    plot([0; 1; 2; 3; 4; 5], y, 'o-b');
    hold on
    
    % build labels for each data point
    labels = cell(6,1);
    labels{1} = strcat(num2str(sum(bitand(temp.EddyClass == -1, t_idx))), '/', num2str(sum(bitand(temp.EddyClass == 1, t_idx))));
    labels{2} = strcat(num2str(sum(bitand(temp.EddyClass == -1, one_idx))), '/', num2str(sum(bitand(temp.EddyClass == 1, one_idx))));
    labels{3} = strcat(num2str(sum(bitand(temp.EddyClass == -1, two_idx))), '/', num2str(sum(bitand(temp.EddyClass == 1, two_idx))));
    labels{4} = strcat(num2str(sum(bitand(temp.EddyClass == -1, three_idx))), '/', num2str(sum(bitand(temp.EddyClass == 1, three_idx))));
    labels{5} = strcat(num2str(sum(bitand(temp.EddyClass == -1, four_idx))), '/', num2str(sum(bitand(temp.EddyClass == 1, four_idx))));
    labels{6} = strcat(num2str(sum(bitand(temp.EddyClass == -1, five_idx))), '/', num2str(sum(bitand(temp.EddyClass == 1, five_idx))));
    
%     text([0; 1; 2; 3; 4; 5],(y+0.25), labels{:});
    text(0+0.2,y(1),labels{1})
    text(1+0.2,y(2),labels{2})
    text(2+0.2,y(3),labels{3})
    text(3+0.2,y(4),labels{4})
    text(4+0.2,y(5),labels{5})
    text(5+0.2,y(6),labels{6})
    
    title(strcat('Northern Hemisphere Latitude: ', num2str(increments(i)), ' to ',...
        num2str(increments(i+1))))
    ylabel('cyc/acyc ratio')
    xlabel('Hurricane Category')
    
    %% Southern Hemisphere
        subplot(2,1,2);
    temp = ibt_lat_seged.S{i};
    t_idx = bitor(bitor(strcmp(temp.Category, hur_cats{1}),strcmp(temp.Category, hur_cats{2})),...
        strcmp(temp.Category, hur_cats{3}));
    one_idx = strcmp(temp.Category, hur_cats{4});
    two_idx = strcmp(temp.Category, hur_cats{5});
    three_idx = strcmp(temp.Category, hur_cats{6});
    four_idx = strcmp(temp.Category, hur_cats{7});
    five_idx = strcmp(temp.Category, hur_cats{8});
    y = zeros(6,1);
    y(1) = sum(bitand(temp.EddyClass == -1, t_idx)) / sum(bitand(temp.EddyClass == 1, t_idx)); %tropical
    y(2) = sum(bitand(temp.EddyClass == -1, one_idx)) / sum(bitand(temp.EddyClass == 1, one_idx)); % cat 1
    y(3) = sum(bitand(temp.EddyClass == -1, two_idx)) / sum(bitand(temp.EddyClass == 1, two_idx));
    y(4) = sum(bitand(temp.EddyClass == -1, three_idx)) / sum(bitand(temp.EddyClass == 1, three_idx));
    y(5) = sum(bitand(temp.EddyClass == -1, four_idx)) / sum(bitand(temp.EddyClass == 1, four_idx));
    y(6) = sum(bitand(temp.EddyClass == -1, five_idx)) / sum(bitand(temp.EddyClass == 1, five_idx)); % cat 5
    plot([0; 1; 2; 3; 4; 5], y, 'o-b');
    hold on
    
        
    % build labels for each data point
    labels = cell(6,1);
    labels{1} = strcat(num2str(sum(bitand(temp.EddyClass == -1, t_idx))), '/', num2str(sum(bitand(temp.EddyClass == 1, t_idx))));
    labels{2} = strcat(num2str(sum(bitand(temp.EddyClass == -1, one_idx))), '/', num2str(sum(bitand(temp.EddyClass == 1, one_idx))));
    labels{3} = strcat(num2str(sum(bitand(temp.EddyClass == -1, two_idx))), '/', num2str(sum(bitand(temp.EddyClass == 1, two_idx))));
    labels{4} = strcat(num2str(sum(bitand(temp.EddyClass == -1, three_idx))), '/', num2str(sum(bitand(temp.EddyClass == 1, three_idx))));
    labels{5} = strcat(num2str(sum(bitand(temp.EddyClass == -1, four_idx))), '/', num2str(sum(bitand(temp.EddyClass == 1, four_idx))));
    labels{6} = strcat(num2str(sum(bitand(temp.EddyClass == -1, five_idx))), '/', num2str(sum(bitand(temp.EddyClass == 1, five_idx))));
    
%     text([0; 1; 2; 3; 4; 5],(y+0.25), labels{:});
    text(0+0.2,y(1),labels{1})
    text(1+0.2,y(2),labels{2})
    text(2+0.2,y(3),labels{3})
    text(3+0.2,y(4),labels{4})
    text(4+0.2,y(5),labels{5})
    text(5+0.2,y(6),labels{6})
    
    
    title(strcat('Southern Hemisphere Latitude: -', num2str(increments(i)), ' to -',...
        num2str(increments(i+1))))
    ylabel('cyc/acyc ratio')
    xlabel('Hurricane Category')
end
