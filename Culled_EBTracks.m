%Remove first and last two timesteps from each hurricane in
%ebtrkatlc1992_2010

ebtrkatlc_culled = dataset();

current_hurricane = cellstr(ebtrkatlc1992_2010(1,1));
start_index = 3;
end_index = NaN;

for i=4 : size(ebtrkatlc1992_2010)
    if(~strcmp(cellstr(ebtrkatlc1992_2010(i,1)), current_hurricane))
        ebtrkatlc_culled = [ebtrkatlc_culled; ebtrkatlc1992_2010(start_index:...
            i-3,:)];
        start_index = i + 2;
        current_hurricane = cellstr(ebtrkatlc1992_2010(i,1));
    end
end