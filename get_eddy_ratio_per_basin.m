%% get_eddy_ratio_per_basin.m
% Produces a table of the ratio (cyclonic/anticyclonic) of (sum) eddy size
%  per hemisphere and by basin

cyc_set = IBTrACS_cyc;
acyc_set = IBTrACS_acyc;

%the following further reduces the datasets by eddy lifetime
% lifetime = 5; %the integer value represents the number of weeks in existence
% c_idx = cyc_set.EddyAge(:) >= lifetime;
% a_idx = acyc_set.EddyAge(:) >= lifetime;
% cyc_set = cyc_set(c_idx,:);
% acyc_set = acyc_set(a_idx,:);


tic

sum_eddies = size(acyc_set,1) + size(cyc_set,1);

%Only the first six are typically found in the dataset, but are left here
%in case future versions of IBTrACS start including the remaining basins
basins = cellstr(['NH';'SH';'NA';'SA';'WP';'EP';'SP';'NI';'SI';'AS';'BB';...
    'EA';'WA';'CP';'CS';'GM';'MM']);

ratio_per_basin = zeros(2,17);
ratio_per_basin = dataset({ratio_per_basin,basins{:}});
ratio_per_basin.NH(1) = sum(cyc_set.Latitude_for_mapping(:) >= 0);
ratio_per_basin.NH(2) = sum(acyc_set.Latitude_for_mapping(:) >= 0);
ratio_per_basin.SH(1) = sum(cyc_set.Latitude_for_mapping(:) < 0);
ratio_per_basin.SH(2) = sum(acyc_set.Latitude_for_mapping(:) < 0);

% populate the rest of the table..
ratio_per_basin.NA(1) = sum(strcmp(cyc_set.Basin, 'NA'));
ratio_per_basin.NA(2) = sum(strcmp(acyc_set.Basin, 'NA'));
ratio_per_basin.SA(1) = sum(strcmp(cyc_set.Basin, 'SA'));
ratio_per_basin.SA(2) = sum(strcmp(acyc_set.Basin, 'SA'));
ratio_per_basin.WP(1) = sum(strcmp(cyc_set.Basin, 'WP'));
ratio_per_basin.WP(2) = sum(strcmp(acyc_set.Basin, 'WP'));
ratio_per_basin.EP(1) = sum(strcmp(cyc_set.Basin, 'EP'));
ratio_per_basin.EP(2) = sum(strcmp(acyc_set.Basin, 'EP'));
ratio_per_basin.SP(1) = sum(strcmp(cyc_set.Basin, 'SP'));
ratio_per_basin.SP(2) = sum(strcmp(acyc_set.Basin, 'SP'));
ratio_per_basin.NI(1) = sum(strcmp(cyc_set.Basin, 'NI'));
ratio_per_basin.NI(2) = sum(strcmp(acyc_set.Basin, 'NI'));
ratio_per_basin.SI(1) = sum(strcmp(cyc_set.Basin, 'SI'));
ratio_per_basin.SI(2) = sum(strcmp(acyc_set.Basin, 'SI'));

toc