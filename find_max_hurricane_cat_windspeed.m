%retrieve max hurricane category attained during a hurricane along with
%the max wind
max_cat = cell(1915,1);
max_wind = zeros(1915,1);
wait_h = waitbar(0,'progress');
for i = 1 : 1915
   cur_hur = bu_table.IBTrACS_ID(i);
   idx = strcmp(IBTrACS_1992_2010.Serial_Num(:),cur_hur);
   subset_cat = IBTrACS_1992_2010.Category(idx);
   subset_wind = IBTrACS_1992_2010.WindWMO(idx);
   [n j] = max(subset_wind);
   max_wind(i) = subset_wind(j);
   max_cat{i} = subset_cat{j};;
   waitbar(i/1915)
end
delete(wait_h)