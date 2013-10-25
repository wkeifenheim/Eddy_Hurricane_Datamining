indexes = [9 10 11 12 13 14 15 16 17 21 22];

for i = 9 : 11
    disp(indexes(i))
    ztest(double(ebtrkatlc_acyc(:,indexes(i))),cyc_means(i),cyc_sigma(i))
    %ztest(double(ebtrkatlc_acyc(:,indexes(i))),miss_means(i),miss_sigma(i))
end