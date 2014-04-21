%populate a table of the ratios between cyc/acyc eddies by how old they
%were upon interaction (or being created by) a hurricane/tropical storm..
% 1-20 weeks seems sufficient, at 21 weeks there are only 93 hurricane
% interactions and EddyAge > 20 accounts for only 4.5% of total

% load('/panfs/roc/groups/6/kumarv/keifenhe/Documents/Datasets/with_daily_eddies/IBTrACS_1992_2010.mat');

disp_25 = prctile(IBTrACS_1992_2010.Displacement_d1(~isnan(IBTrACS_1992_2010.EddyClass(:))),25);
disp_50 = prctile(IBTrACS_1992_2010.Displacement_d1(~isnan(IBTrACS_1992_2010.EddyClass(:))),50);
disp_75 = prctile(IBTrACS_1992_2010.Displacement_d1(~isnan(IBTrACS_1992_2010.EddyClass(:))),75);
disp_100 = max(IBTrACS_1992_2010.Displacement_d1(~isnan(IBTrACS_1992_2010.EddyClass(:))));

disp_25_idx = bitand(IBTrACS_1992_2010.Displacement_d1(:) <= disp_25, ~isnan(IBTrACS_1992_2010.EddyClass(:)));
disp_50_idx = bitand(bitand(IBTrACS_1992_2010.Displacement_d1(:) > disp_25,...
    IBTrACS_1992_2010.Displacement_d1(:) <= disp_50), ~isnan(IBTrACS_1992_2010.EddyClass(:)));
disp_75_idx = bitand(bitand(IBTrACS_1992_2010.Displacement_d1(:) > disp_50,...
    IBTrACS_1992_2010.Displacement_d1(:) <= disp_75), ~isnan(IBTrACS_1992_2010.EddyClass(:)));
disp_100_idx = bitand(bitand(IBTrACS_1992_2010.Displacement_d1(:) > disp_75,...
    IBTrACS_1992_2010.Displacement_d1(:) <= disp_100), ~isnan(IBTrACS_1992_2010.EddyClass(:)));

labels = {'1stQuadrant';'2ndQuadrant';'3rdQuadrant';'4thQuadrant'};
indices = [disp_25_idx, disp_50_idx, disp_75_idx, disp_100_idx];

%Columns: Count, % of total (21106), acyc/cyc ratio, count >= 14 weeks,
%ratio of eddies lived >= 14 weeks.
results = zeros(20,5,4);

data_labels = {'Count','Percentge','Ratio','NumAtLeast2Weeks','2WeekRatio'}';


for l = 1 : 4
    wait_h = waitbar(0,'progress');
    data = IBTrACS_1992_2010(indices(:,l),:);
    for i = 1 : 20
        results(i,1,l) = sum(data.EddyAge(:) == i);
        results(i,2,l) = results(i,1) / size(data(~isnan(data.EddyClass),:),1);
        num_acyc = sum(bitand(data.EddyAge(:) == i,...
            data.EddyClass(:) == 1));
        num_cyc = sum(bitand(data.EddyAge(:) == i,...
            data.EddyClass(:) == -1));
        results(i,3,l) = num_cyc / num_acyc;
        results(i,4,l) = sum(bitand(data.EddyAge(:) == i,data.EddyTrackLength >= 14));
        num_acyc = sum(bitand(bitand(data.EddyAge(:) == i,...
            data.EddyClass(:) == 1), data.EddyTrackLength >= 14));
        num_cyc = sum(bitand(bitand(data.EddyAge(:) == i,...
            data.EddyClass(:) == -1), data.EddyTrackLength >= 14));
        results(i,5,l) = num_cyc / num_acyc;
        waitbar(i/20);
    end
    delete(wait_h);

%     eddy_age_ratios = dataset({results,data_labels{:}});

    names = {'Count       ';'Percent of total  ';'Cyc_Acyc_ratio';'AtLeast14';'Ratio14'};
    eddy_ratio_for_hurr_interaction = dataset({squeeze(results(:,:,l)), names{:}});

    
    stop = find(isinf(squeeze(results(:,3,l))),1) - 1;
    figure;
    scatter([1:20],eddy_ratio_for_hurr_interaction.Cyc_Acyc_ratio(1:20));
    title(strcat('Ratio of cyc/acyc eddies, per eddy age, during hurricane interaction | ',labels{l}));
    lsline
    ylabel('cyc/acyc ratio');
    xlabel('eddy age (weeks)');
    legend('ratio at day(x)','least-squares line','Location','North');
    saveas(gcf,strcat('eddy_','ratio_',labels{l},'.eps'),'epsc');

    age_cutoff = prctile(data.EddyAge,99);
    bins = 1:1:age_cutoff;
    cyc_totals = histc(data.EddyAge(data.EddyClass == -1),bins);
    acyc_totals = histc(data.EddyAge(data.EddyClass == 1),bins);
    figure;
    plot(bins, cyc_totals);
    hold on
    plot(bins, acyc_totals,'r');
    title(strcat('Histogram of eddy ages at hurricane interaction | ',labels{l}));
    ylabel('count');
    xlabel('eddy age (weeks)');
    legend(strcat('cyclonic | Mean: ',num2str(nanmean(data.EddyAge(data.EddyClass == -1)))),...
        strcat('anticyclonic | Mean: ', num2str(nanmean(data.EddyAge(data.EddyClass == 1)))))
    saveas(gcf,strcat('eddy_','hist_',labels{l},'.eps'),'epsc');
    
    figure;

    data_eddies = data(~isnan(data.EddyClass(:)),:);
    type = cell(size(data_eddies,1),1);

    for i = 1 : size(data_eddies,1)
        if(data_eddies.EddyClass(i) == -1)
            type{i} = 'cyclonic';
        elseif(data_eddies.EddyClass(i) == 1)
            type{i} = 'anticyclonic';
        end
    end
    

    boxplot(data_eddies.EddyAge, type);
    title(strcat('Box plot of eddy age at hurricane interaction | ',labels{l}));
    ylabel('age (day)');
    saveas(gcf,strcat('eddy_','box_',labels{l},'.eps'),'epsc');
    
    waitfor(msgbox('click OK to continue..'));
end