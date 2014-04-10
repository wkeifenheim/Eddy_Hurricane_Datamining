%utilizes passes_left to find where hurricanes pass with respected to
%encountered eddies
% 1 - if passes on the right of an eddy
% 0 - if hurricane passes over the center of the eddy
% -1 - if passes on the left
% NaN - other.

% wait_h = waitbar(0,'determining left/right passes..');
results = zeros(size(IBTrACS_1992_2010_daily,1),1);
dists = zeros(size(IBTrACS_1992_2010_daily,1),1);

parfor i = 1 : size(IBTrACS_1992_2010_daily,1) - 1
    
   if(~isnan(IBTrACS_1992_2010_daily.EddyClass(i)))
      x1 = IBTrACS_1992_2010_daily.Latitude_for_mapping(i);
      y1 = IBTrACS_1992_2010_daily.Longitude_for_mapping(i);
      if(strcmp(IBTrACS_1992_2010_daily.Serial_Num(i), IBTrACS_1992_2010_daily.Serial_Num(i+1)));
          x2 = IBTrACS_1992_2010_daily.Latitude_for_mapping(i+1);
          y2 = IBTrACS_1992_2010_daily.Longitude_for_mapping(i+1);
      else
          x2 = NaN;
          y2 = NaN;
      end
%       [x2, y2] = reckon(dataset.Latitude_for_mapping(i),...
%           dataset.Longitude_for_mapping(i), arclen,...
%           dataset.Azimuth(i));;
      eddy_x = IBTrACS_1992_2010_daily.EddyLat(i);
      eddy_y = IBTrACS_1992_2010_daily.EddyLon(i);
      [results(i), dists(i)] = passes_right(x1, y1, x2, y2, eddy_x, eddy_y);
   else
       results(i) = NaN;
       dists(i) = NaN;
   end
%    waitbar(i/size(dataset,1))
end
% delete(wait_h);

names = {'left_center_right_pass';'dist_hurr_traj_eddy_center'};
LR_results = dataset({[results,dists],names{:}});