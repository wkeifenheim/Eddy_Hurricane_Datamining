%utilizes passes_left to find where hurricanes pass with respected to
%encountered eddies
% 1 - if passes on the right of an eddy
% 0 - if hurricane passes over the center of the eddy
% -1 - if passes on the left
% NaN - other..
%

% axesm('pcarre'); %required for mfwdtran to work

%wait_h = waitbar(0,'determining left/right passes..');
arclen = 2;
results = zeros(size(IBTrACS_1992_2010,1),1);
dists = zeros(size(IBTrACS_1992_2010,1),1);

parfor i = 1 : size(IBTrACS_1992_2010,1)
    
   if(~isnan(IBTrACS_1992_2010.EddyClass(i)))
%       [x1, y1] = mfwdtran(IBTrACS_1992_2010.Latitude_for_mapping(i),...
%           IBTrACS_1992_2010.Longitude_for_mapping(i));
      x1 = IBTrACS_1992_2010.Latitude_for_mapping(i);
      y1 = IBTrACS_1992_2010.Longitude_for_mapping(i);
      if(strcmp(IBTrACS_1992_2010.Serial_Num(i), IBTrACS_1992_2010.Serial_Num(i+1)));
          x2 = IBTrACS_1992_2010.Latitude_for_mapping(i+1);
          y2 = IBTrACS_1992_2010.Longitude_for_mapping(i+1);
      else
          x2 = NaN;
          y2 = NaN;
      end
%       [x2, y2] = reckon(IBTrACS_1992_2010.Latitude_for_mapping(i),...
%           IBTrACS_1992_2010.Longitude_for_mapping(i), arclen,...
%           IBTrACS_1992_2010.Azimuth(i));
%       [x2, y2] = mfwdtran(a,b);
%       [eddy_x, eddy_y] = mfwdtran(IBTrACS_1992_2010.EddyLat(i),...
%           IBTrACS_1992_2010.EddyLon(i));
      eddy_x = IBTrACS_1992_2010.EddyLat(i);
      eddy_y = IBTrACS_1992_2010.EddyLon(i);
      [results(i), dists(i)] = passes_right(x1, y1, x2, y2, eddy_x, eddy_y);
   else
       results(i) = NaN;
       dists(i) = NaN;
   end
   %waitbar(i/size(IBTrACS_1992_2010,1))
end
%delete(wait_h);