%% get_eddy_size_ratio_per_basin.m
% Produces a table of the ratio (cyclonic/anticyclonic) of (mean) eddy size
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

size_ratio_per_basin = zeros(1,17);
size_ratio_per_basin = dataset({size_ratio_per_basin,basins{:}});
size_ratio_per_basin.NH(1) = mean(cyc_set.EddyPixelCount(cyc_set.Latitude_for_mapping(:) >= 0))...
    / mean(acyc_set.EddyPixelCount(acyc_set.Latitude_for_mapping(:) >= 0));
size_ratio_per_basin.SH(1) = mean(cyc_set.EddyPixelCount(cyc_set.Latitude_for_mapping(:) < 0))...
    / mean(acyc_set.EddyPixelCount(acyc_set.Latitude_for_mapping(:) < 0));

% populate the rest of the table..
size_ratio_per_basin.NA(1) = mean(cyc_set.EddyPixelCount(strcmp(cyc_set.Basin, 'NA')))...
    / mean(acyc_set.EddyPixelCount(strcmp(acyc_set.Basin, 'NA')));
size_ratio_per_basin.SA(1) = mean(cyc_set.EddyPixelCount(strcmp(cyc_set.Basin, 'SA')))...
    / mean(acyc_set.EddyPixelCount(strcmp(acyc_set.Basin, 'SA')));
size_ratio_per_basin.WP(1) = mean(cyc_set.EddyPixelCount(strcmp(cyc_set.Basin, 'WP')))...
    / mean(acyc_set.EddyPixelCount(strcmp(acyc_set.Basin, 'WP')));
size_ratio_per_basin.EP(1) = mean(cyc_set.EddyPixelCount(strcmp(cyc_set.Basin, 'EP')))...
    / mean(acyc_set.EddyPixelCount(strcmp(acyc_set.Basin, 'EP')));
size_ratio_per_basin.SP(1) = mean(cyc_set.EddyPixelCount(strcmp(cyc_set.Basin, 'SP')))...
    / mean(acyc_set.EddyPixelCount(strcmp(acyc_set.Basin, 'SP')));
size_ratio_per_basin.NI(1) = mean(cyc_set.EddyPixelCount(strcmp(cyc_set.Basin, 'NI')))...
    / mean(acyc_set.EddyPixelCount(strcmp(acyc_set.Basin, 'NI')));
size_ratio_per_basin.SI(1) = mean(cyc_set.EddyPixelCount(strcmp(cyc_set.Basin, 'SI')))...
    / mean(acyc_set.EddyPixelCount(strcmp(acyc_set.Basin, 'SI')));

toc