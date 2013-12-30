wait_h = waitbar(0,'Progress of searching for nearest eddies..');
tic;
results = zeros(66280,8);
i = 1; %Hurricane Angela, 1992.10.12

%e_track_length_thresh = 2;

% year = double(ebtrkatlc1992_2010(i,3));
% month = double(ebtrkatlc1992_2010(i,4));
% day = double(ebtrkatlc1992_2010(i,5));

% load(strcat('/project/expeditions/eddies_project_data/results/',...
%         'tracks_new_landmask_10_30_2013/lnn/bu_anticyc_new_landmask.mat'));
% load(strcat('/project/expeditions/eddies_project_data/results/',...
%         'tracks_new_landmask_10_30_2013/lnn/bu_cyclonic_new_landmask.mat'));
load(strcat('/panfs/roc/groups/6/kumarv/keifenhe/Documents/',...
            'Datasets/eddy_track_date_indices.mat'));

hurID = cellstr(IBTrACS_All_1992_2010(i,1));
iso_date = datevec(cellstr(IBTrACS_All_1992_2010(i,7)));
year = iso_date(1);
month = iso_date(2);
day = iso_date(3);

year_str = num2str(year);
month_str = num2str(month);
day_str = num2str(day);

% load initial eddy files
[anticyc_file, cyc_file] = findEddies(year_str, month_str, day_str);
antiCyc = load(anticyc_file);
cyc = load(cyc_file);

% Start a results array for returning structures
%results_structs(10860).Lat = 30;

% Account for how many time steps left in the week
 offset = iso_date(4)/6 + ((weekday(strcat(year_str,...
     '-', month_str, '-', day_str)) - 1) * 4);
 % Number of time steps until eddy boddies need to be reloaded
 nextEddyWeek = 28 - offset;
 
 % Capped to stop after 2010 dates are run
for i = 1 : 66280
    lat = double(IBTrACS_All_1992_2010(i,17));
    lon = double(IBTrACS_All_1992_2010(i,18));
    
    % Keep track of when to load next weeks eddy bodies
    % Or reload eddy files when next hurricane starts (hurricanes don't
    % necessarily end/start on consecutive days)
    if(nextEddyWeek == 0 || ~strcmpi(hurID, cellstr(IBTrACS_All_1992_2010(i,1))))
        
        hurID = cellstr(IBTrACS_All_1992_2010(i,1));
        iso_date = datevec(cellstr(IBTrACS_All_1992_2010(i,7)));
        year = iso_date(1);
        month = iso_date(2);
        day = iso_date(3);
        
        year_str = num2str(year);
        month_str = num2str(month);
        day_str = num2str(day);
            
        [anticyc_file, cyc_file] = findEddies(year_str, month_str, day_str);
        antiCyc = load(anticyc_file);
        cyc = load(cyc_file);
        
        offset = iso_date(4)/6 + ((weekday(strcat(year_str,...
            '-', month_str, '-', day_str)) - 1) * 4);
        
        nextEddyWeek = 28 - offset;
        
        [results(i,1), results(i,2), results(i,3), results(i,4),...
            results(i,5), results(i,6), results(i,7)] = ...
            calcClosest(lat,lon, antiCyc, cyc);
        
        %i = i + 1;
        
    else

        [results(i,1), results(i,2), results(i,3), results(i,4),...
            results(i,5), results(i,6), results(i,7)] = ...
            calcClosest(lat,lon, antiCyc, cyc);
        
        nextEddyWeek = nextEddyWeek - 1;
        %i = i + 1;
        
        
    end
    
    %Retain eddy association only if corresponding eddyTrack lasted longer
    %than "e_track_length_thresh"
    track_time_slice = findTimeSlice(year_str, month_str, day_str);
    track_time_slice = str2num(track_time_slice);
    j = find(double(eddy_track_date_indices(:,1)) == ...
                        track_time_slice);
    track = NaN;
    found = 0;
    search_eddy_tracks = 0;
    results(i,8) = NaN;
    
    if(results(i,2) == -1)
        track_set = bu_anticyc_tracks;
        a = 2; b = 3;
        search_eddy_tracks = 1;
    elseif(results(i,2) == 1)
        track_set = bu_cyclonic_tracks;
        a = 4; b = 5;
        search_eddy_tracks = 1;
    end
    
    if(search_eddy_tracks)
        disp('starting search for eddy_tracks..')
        toc
        for k = double(eddy_track_date_indices(j,a)) : ...
                double(eddy_track_date_indices(j,b));
           temp_track = cell2mat(track_set(k));
           for l = 1 : size(temp_track,1)
               if(temp_track(l,3) == j && temp_track(l,4) == results(i,7))
                   track = temp_track;
                   found = 1;
                   results(i,8) = k;
                   disp('found a track!')
                   break
               end
           end
           if(found)
%                if(size(temp_track,1) < e_track_length_thresh)
%                    disp('removing an eddy association whose lifetime did not meet threshold');
%                    results(i,:) = NaN;
%                end
               break
           end         
        end
    end
    
    toc
    waitbar(i/66280)

end