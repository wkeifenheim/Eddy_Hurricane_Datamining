old_acyc_size = size(ebtrkatlc_acyc,1);
old_cyc_size = size(ebtrkatlc_cyc,1);
old_miss_size = size(ebtrkatlc_miss,1);

new_ebtrkatlc_acyc = dataset();
new_ebtrkatlc_cyc = dataset();
new_ebtrkatlc_miss = dataset();

acyc_removed = [];
cyc_removed = [];
miss_removed = [];


for i = 1 : old_acyc_size
    
   lat = double(ebtrkatlc_acyc(i,7));
   lon = double(ebtrkatlc_acyc(i,8));
   if(coordsOverOceanBool(lat,lon))
       new_ebtrkatlc_acyc = [new_ebtrkatlc_acyc; ebtrkatlc_acyc(i,:)];
   else
       fprintf('removing a time-step from Anticyclonic set...[%d,%d]\n', lat, lon);
       acyc_removed = [acyc_removed; [i,lat,lon]];
   end
end

for i = 1 : old_cyc_size
    
   lat = double(ebtrkatlc_cyc(i,7));
   lon = double(ebtrkatlc_cyc(i,8));
   if(coordsOverOceanBool(lat,lon))
       new_ebtrkatlc_cyc = [new_ebtrkatlc_cyc; ebtrkatlc_cyc(i,:)];
   else
       fprintf('removing a time-step from Cyclonic set...[%d,%d]\n', lat, lon);
       cyc_removed = [cyc_removed; [i, lat,lon]];
   end
end

for i = 1 : old_miss_size
    
   lat = double(ebtrkatlc_miss(i,7));
   lon = double(ebtrkatlc_miss(i,8));
   if(coordsOverOceanBool(lat,lon))
       new_ebtrkatlc_miss = [new_ebtrkatlc_miss; ebtrkatlc_miss(i,:)];
   else
       fprintf('removing a time-step from Missed set...[%d,%d]\n', lat, lon);
       miss_removed = [miss_removed; [i, lat,lon]];
   end
end