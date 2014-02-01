%populate a vector of eddy pixel counts


pixel_size = zeros(60819,1);
wait_h = waitbar(0,'progress');
for i = 1 : 60819
   if(IBTrACS_1992_2010.EddyClass(i) == -1) %acyc
      slice = IBTrACS_1992_2010.TimeSlice(i);
      j = find(eddy_track_date_indices.Date(:) == slice);
      k = IBTrACS_1992_2010.EddyIdx(i);
      pixel_size(i) = size(h_cyc(j).eddies(k).Stats.PixelIdxList,1);
   elseif(IBTrACS_1992_2010.EddyClass(i) == 1) %cyc
      slice = IBTrACS_1992_2010.TimeSlice(i);
      j = find(eddy_track_date_indices.Date(:) == slice);
      k = IBTrACS_1992_2010.EddyIdx(i);
      pixel_size(i) = size(h_acyc(j).eddies(k).Stats.PixelIdxList,1);
   end
    waitbar(i/60819)
end
delete(wait_h)