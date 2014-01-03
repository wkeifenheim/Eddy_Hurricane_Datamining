%Produces a table filled with the total occurances of hurricane time steps
%(by eddy) that are in a specific basin
%Row 1: cyclonic
%Row 2: anticyclonic

cyc_set = IBTrACS_cyc;
acyc_set = IBTrACS_acyc;

%the following further reduces the datasets by eddy lifetime
lifetime = 5; %the integer value represents the number of weeks in existence
c_idx = double(cyc_set(:,41)) >= lifetime;
a_idx = double(acyc_set(:,41)) >= lifetime;
cyc_set = cyc_set(c_idx,:);
acyc_set = acyc_set(a_idx,:);


tic
wait_h = waitbar(0,'Calculating totals for each basin..');

sum_eddies = size(acyc_set,1) + size(cyc_set,1);

%Only the first six are typically found in the dataset, but are left here
%in case future versions of IBTrACS start including the remaining basins
basins = cellstr(['NA';'SA';'WP';'EP';'SP';'NI';'SI';'AS';'BB';'EA';'WA';...
    'CP';'CS';'GM';'MM']);

num_per_basin = zeros(2,15);
num_per_basin = dataset({num_per_basin,basins{:}});

%Populate Cyclonic set...
for i = 1 : size(cyc_set,1)
    switch char(cyc_set.Basin(i))
        case 'NA'
            num_per_basin.NA(1) = num_per_basin.NA(1) + 1;
        case 'SA'
            num_per_basin.SA(1) = num_per_basin.SA(1) + 1;
        case 'WP'
            num_per_basin.WP(1) = num_per_basin.WP(1) + 1;
        case 'EP'
            num_per_basin.EP(1) = num_per_basin.EP(1) + 1;
        case 'SP'
            num_per_basin.SP(1) = num_per_basin.SP(1) + 1;
        case 'NI'
            num_per_basin.NI(1) = num_per_basin.NI(1) + 1;
        case 'SI'
            num_per_basin.SI(1) = num_per_basin.SI(1) + 1;
        case 'AS'
            num_per_basin.AS(1) = num_per_basin.AS(1) + 1;
        case 'BB'
            num_per_basin.BB(1) = num_per_basin.BB(1) + 1;
        case 'EA'
            num_per_basin.EA(1) = num_per_basin.EA(1) + 1;
        case 'WA'
            num_per_basin.WA(1) = num_per_basin.WA(1) + 1;
        case 'CP'
            num_per_basin.CP(1) = num_per_basin.CP(1) + 1;
        case 'CS'
            num_per_basin.CS(1) = num_per_basin.CS(1) + 1;
        case 'GM'
            num_per_basin.GM(1) = num_per_basin.GM(1) + 1;
        case 'MM'
            num_per_basin.MM(1) = num_per_basin.MM(1) + 1;
        otherwise
            sprintf('Unknown value in cyc %d \n',i)
    end
    waitbar(i/sum_eddies)
end

toc

for j = 1 : size(acyc_set,1)
    switch char(acyc_set.Basin(j))
        case 'NA'
            num_per_basin.NA(2) = num_per_basin.NA(2) + 1;
        case 'SA'
            num_per_basin.SA(2) = num_per_basin.SA(2) + 1;
        case 'WP'
            num_per_basin.WP(2) = num_per_basin.WP(2) + 1;
        case 'EP'
            num_per_basin.EP(2) = num_per_basin.EP(2) + 1;
        case 'SP'
            num_per_basin.SP(2) = num_per_basin.SP(2) + 1;
        case 'NI'
            num_per_basin.NI(2) = num_per_basin.NI(2) + 1;
        case 'SI'
            num_per_basin.SI(2) = num_per_basin.SI(2) + 1;
        case 'AS'
            num_per_basin.AS(2) = num_per_basin.AS(2) + 1;
        case 'BB'
            num_per_basin.BB(2) = num_per_basin.BB(2) + 1;
        case 'EA'
            num_per_basin.EA(2) = num_per_basin.EA(2) + 1;
        case 'WA'
            num_per_basin.WA(2) = num_per_basin.WA(2) + 1;
        case 'CP'
            num_per_basin.CP(2) = num_per_basin.CP(2) + 1;
        case 'CS'
            num_per_basin.CS(2) = num_per_basin.CS(2) + 1;
        case 'GM'
            num_per_basin.GM(2) = num_per_basin.GM(2) + 1;
        case 'MM'
            num_per_basin.MM(2) = num_per_basin.MM(2) + 1;
        otherwise
            sprintf('Unknown value in acyc %d \n',j)
    end
    waitbar((i+j)/sum_eddies)
end

delete(wait_h);
toc