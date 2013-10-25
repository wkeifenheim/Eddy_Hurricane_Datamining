% Find means and STD's of ebtrkatlc by eddy type

indeces = [7 8 9 10 11 12 13 14 15 16 17 19 20 21 22];

means_acyc= nanmean(double(ebtrkatlc_acyc(:,indeces)));
means_cyc = nanmean(double(ebtrkatlc_cyc(:,indeces)));
means_miss = nanmean(double(ebtrkatlc_miss(:,indeces)));

vars_acyc = nanvar(double(ebtrkatlc_acyc(:,indeces)));
vars_cyc = nanvar(double(ebtrkatlc_cyc(:,indeces)));
vars_miss = nanvar(double(ebtrkatlc_miss(:,indeces)));