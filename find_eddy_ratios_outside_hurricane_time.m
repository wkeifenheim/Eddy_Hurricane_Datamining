%% get cyc/acyc counts and area within 3-degrees of TC time-step for eddies 1993-1998

na_ibt = IBTrACS_1992_2010(strcmp(IBTrACS_1992_2010.Basin,'NA'),:);
load('~/Documents/Datasets/week_dates_with_month.mat') % loads 'dates' with datenumber and month number in second column

% populate a list of hurricane locations from the NA basin
lats = na_ibt.Latitude_for_mapping(1:2000);
lons = na_ibt.Longitude_for_mapping(1:2000);
cyc_count = zeros(12,1);
cyc_area = zeros(12,1);
acyc_count = zeros(12,1);
acyc_area = zeros(12,1);

% run with eddies of timeslice indices 2-307
wait_h = waitbar(0,'Progress of NA Basin Eddy Ratios Along Hurricane Tracks');
tic
for i = 2 : 307
    
    for j = 1 : 2000
        % cyclonic eddies
        include_eddy = distance(lats(j), lons(j), [h_cyc(i).eddies(:).Lat]', [h_cyc(i).eddies(:).Lon]') <= 3;
        if(any(include_eddy))
            count = sum(include_eddy);
            cyc_count(dates(i,2)) = cyc_count(dates(i,2)) + count;
            idx = find(include_eddy);
            for k = 1 : length(idx);
                cyc_area(dates(i,2)) = cyc_area(dates(i,2)) + length(h_cyc(i).eddies(idx(k)).Stats.PixelIdxList);
            end
        end
        
        % anticyclonic eddies
        include_eddy = distance(lats(j), lons(j), [h_acyc(i).eddies(:).Lat]', [h_acyc(i).eddies.Lon]') <= 3;
        if(any(include_eddy))
            count = sum(include_eddy);
            acyc_count(dates(i,2)) = acyc_count(dates(i,2)) + count;
            idx = find(include_eddy);
            for k = 1 : length(idx);
                acyc_area(dates(i,2)) = acyc_area(dates(i,2)) + length(h_acyc(i).eddies(idx(k)).Stats.PixelIdxList);
            end
        end
    end
    toc
    waitbar(i/307);
end