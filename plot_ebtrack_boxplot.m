%Works best if NaN's of column 18 are converted to 0's temporarily

for i = 9 : 22
    if i ~= 18
        boxplot(double(ebtrkatlc1992_2010(:,i)),double(ebtrkatlc1992_2010(:,18)));
    end
end