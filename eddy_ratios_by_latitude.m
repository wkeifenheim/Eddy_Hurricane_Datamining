% Experiement to determine any latitude-dependent correlation of the
% cyclonic/anticyclonic ratios of hurricane encountered eddies.

% latitude increments
increments = 0:15:75;

% for easier generalization
data = IBTrACS_1992_2010(~isnan(IBTrACS_1992_2010.EddyClass),:);

n_results = NaN(5,1);
s_results = NaN(5,1);


for i = 1 : length(increments) - 1
    lower_bound = increments(i);
    upper_bound = increments(i+1);
    
    n_idx = bitand(data.Latitude_for_mapping <= upper_bound,...
        data.Latitude_for_mapping > lower_bound);
    s_idx = bitand(data.Latitude_for_mapping < -lower_bound,...
        data.Latitude_for_mapping >= -upper_bound);
    
    ibt_lat_seged.N{i} = data(n_idx,:);
    ibt_lat_seged.S{i} = data(s_idx,:);
    
    n_results(i) = sum(ibt_lat_seged.N{i}.EddyClass == -1) /...
        sum(ibt_lat_seged.N{i}.EddyClass == 1);
    s_results(i) = sum(ibt_lat_seged.S{i}.EddyClass == -1) /...
        sum(ibt_lat_seged.S{i}.EddyClass == 1);
end

ibt_lat_seged.increments = increments;

