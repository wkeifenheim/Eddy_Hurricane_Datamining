%Pick a hurricane and plot projected movement along with the actual track
%how to step to next week of eddy data

handles.hurr_choice = '1997212N11265';
handles.hurr_idx = strcmp(IBTrACS_1992_2010.Serial_Num(:), handles.hurr_choice);
handles.track_subset = IBTrACS_1992_2010(handles.hurr_idx,:);
handles.length_subset = size(handles.track_subset,1);

handles.timeslice = handles.track_subset.TimeSlice(1);
%count how many timeslice changes ocurr.
handles.num_timeslices = 1;
handles.ts_list = {handles.timeslice};
temp = handles.timeslice;
for i = 1 : handles.length_subset
   if(temp ~= handles.track_subset.TimeSlice(i))
       handles.num_timeslices = handles.num_timeslices + 1;
       temp = handles.track_subset.TimeSlice(i);
       handles.ts_list = [handles.ts_list; temp];
   end
end

for j = 1 : handles.num_timeslices
    
    handles.timeslice = handles.ts_list{j};
    
    handles.anticycFile = strcat('/project/expeditions/eddies_project_data/results/new_bottom_up_w_land_mask_09_16_2013/',...
        'anticyc_', num2str(handles.timeslice), '.mat');
    handles.cyclonicFile = strcat('/project/expeditions/eddies_project_data/results/new_bottom_up_w_land_mask_09_16_2013/',...
        'cyclonic_', num2str(handles.timeslice), '.mat');

    handles.ssh = load('/project/expeditions/eddies_project_data/ssh_data/data/global_ssh_1992_2011_with_new_landmask.mat',...
        'lat','lon');

    handles.canvas = zeros(721, 1440, 'uint8');

    handles.axes1 = axesm('pcarre', 'Origin', [0 180 0]);%, 'MapLatLimit', [0 70], 'MapLonLimit', [-120 0]);
    load coast
    plotm(lat,long)
    whitebg('k')

    %find bounds for displaying eddies...
    % Columns: Latitute Longitude
    % Rows: Min Max
    p.lats = handles.track_subset.Latitude_for_mapping(:);
    p.lons = handles.track_subset.Longitude_for_mapping(:);
    p.min_lat = floor(min(p.lats)/0.25)*0.25 - 5;
    p.max_lat = floor(max(p.lats)/0.25)*0.25 + 5;
    p.min_lon = floor(min(p.lons)/0.25)*0.25;
    p.max_lon = floor(max(p.lons)/0.25)*0.25;

    a = find(handles.ssh.lat == p.min_lat);
    b = find(handles.ssh.lat == p.max_lat);
    c = find(handles.ssh.lon == p.min_lon);
    d = find(handles.ssh.lon == p.max_lon);

    %Repair the coordinate limits if 0 or 180 degrees latitude is crossed
    if((p.min_lon < 0 && p.max_lon > 0))

        p.pos_lons = p.lons(p.lons(:) >= 0);
        p.neg_lons = p.lons(p.lons(:) < 0);
        p.min_pos = floor(min(p.pos_lons)/0.25)*0.25 - 5;
        p.max_neg = floor(max(p.neg_lons)/0.25)*0.25 + 5;


        %track cross 180 degrees longitude
        if((p.max_lon-180) <= 2 && (p.max_lon-180) >= -2)
            p.min_pos = find(handles.ssh.lon == p.min_pos);
            p.max_neg = find(handles.ssh.lon == p.max_neg);
            handles.coordLimits{1,2} = (p.min_pos:p.max_neg);
            handles.case = 2;
        else %Crosses 0 degress longitude
            handles.coordLimits{1,2} = [1:(d+20), (c-20):1440];
            handles.case = 3;
        end
        handles.coordLimits{1,1} = (a:b);
    else
        handles.case = 1;
        handles.coordLimits{1,1} = (a:b);
        p.min_lon = p.min_lon - 5;
        if(p.max_lon < -5)
            p.max_lon = p.max_lon + 5;
        end
        c = find(handles.ssh.lon == p.min_lon);
        d = find(handles.ssh.lon == p.max_lon);
        handles.coordLimits{1,2} = (c:d);
    end

    %---------------------------------------------

    %Takes approx. 1.3 seconds to load these two files..
    handles.eddy2 = load(handles.anticycFile);
    handles.eddy1 = load(handles.cyclonicFile);

    subset = handles.track_subset(handles.track_subset.EddyTrackLength(:) == 1,:);
    cyclonic_eddies = subset(subset.EddyClass(:) == -1,:); %cyclonic
    anticyc_eddies = subset(subset.EddyClass(:) == 1,:); %anticyclonic
    %--------------------------------------------------%
    a = handles.coordLimits{1,1};
    b = handles.coordLimits{1,2};
    lats = handles.ssh.lat(a);
    lons = handles.ssh.lon(b);

    %I hate that I have to do this....
    pos_lons = lons(lons >= 0);
    neg_lons = lons(lons < 0);


    if(handles.case > 1)
        % 1 seconds
        for i = 1:length(handles.eddy1.eddies)

            if((handles.eddy1.eddies(i).Lat >= min(lats) &&...
                    handles.eddy1.eddies(i).Lat <= max(lats))...
                    &&...
                    (((handles.eddy1.eddies(i).Lon >= pos_lons(1)) &&...
                    (handles.eddy1.eddies(i).Lon <= pos_lons(end))) ||...
                    ((handles.eddy1.eddies(i).Lon <= neg_lons(end)) &&...
                    (handles.eddy1.eddies(i).Lon >= neg_lons(1)))))

                % The following if statement colors an eddy a different shade if it
                % does not have a lifetime longer than one week, but interacts with
                % a hurricane
                if sum(cyclonic_eddies.EddyIdx(:) == i)
                    handles.canvas(handles.eddy1.eddies(i).Stats.PixelIdxList) = 1; %cyclonic
                else
                    handles.canvas(handles.eddy1.eddies(i).Stats.PixelIdxList) = 2; %cyclonic
                end
            end


        end
        for i = 1:length(handles.eddy2.eddies)

            if((handles.eddy2.eddies(i).Lat >= min(lats) &&...
                    handles.eddy2.eddies(i).Lat <= max(lats))...
                    &&...
                    (((handles.eddy2.eddies(i).Lon >= pos_lons(1)) &&...
                    (handles.eddy2.eddies(i).Lon <= pos_lons(end))) ||...
                    ((handles.eddy2.eddies(i).Lon <= neg_lons(end)) &&...
                    (handles.eddy2.eddies(i).Lon >= neg_lons(1)))))

                if sum(anticyc_eddies.EddyIdx(:) == i)
                    handles.canvas(handles.eddy2.eddies(i).Stats.PixelIdxList) = 3;  %anticyclonic
                else
                    handles.canvas(handles.eddy2.eddies(i).Stats.PixelIdxList) = 4;
                end
            end

        end
    else
        for i = 1:length(handles.eddy1.eddies)

            if((handles.eddy1.eddies(i).Lat >= min(lats) &&...
                    handles.eddy1.eddies(i).Lat <= max(lats))...
                    &&...
                    (handles.eddy1.eddies(i).Lon >= min(lons) &&...
                    handles.eddy1.eddies(i).Lon <= max(lons)))

                % The following if statement colors an eddy a different shade if it
                % does not have a lifetime longer than one week, but interacts with
                % a hurricane
                if sum(cyclonic_eddies.EddyIdx(:) == i)
                    handles.canvas(handles.eddy1.eddies(i).Stats.PixelIdxList) = 1; %cyclonic
                else
                    handles.canvas(handles.eddy1.eddies(i).Stats.PixelIdxList) = 2; %cyclonic
                end
            end


        end
        for i = 1:length(handles.eddy2.eddies)

            if((handles.eddy2.eddies(i).Lat >= min(lats) &&...
                    handles.eddy2.eddies(i).Lat <= max(lats))...
                    &&...
                    (handles.eddy2.eddies(i).Lon >= min(lons) &&...
                    handles.eddy2.eddies(i).Lon <= max(lons)))

                if sum(anticyc_eddies.EddyIdx(:) == i)
                    handles.canvas(handles.eddy2.eddies(i).Stats.PixelIdxList) = 3;  %anticyclonic
                else
                    handles.canvas(handles.eddy2.eddies(i).Stats.PixelIdxList) = 4;
                end
            end

        end
    end
    %--------------------------------------------------%

    pcolorm(handles.ssh.lat(a), handles.ssh.lon(b), handles.canvas(a,b));
    
    plotm(handles.track_subset.Latitude_for_mapping(:),...
        handles.track_subset.Longitude_for_mapping(:),'-.','Color',[1 1 1],'LineWidth',2);
    idx = handles.track_subset.TimeSlice(:) == handles.ts_list{j};
    arclength = km2deg(handles.track_subset.Displacement_d1(idx));
    azimuth = handles.track_subset.Azimuth(idx);
    [latouts, lonouts] = reckon(handles.track_subset.Latitude_for_mapping(idx),...
        handles.track_subset.Longitude_for_mapping(idx), arclength, azimuth);
    projected = quiverm(handles.track_subset.Latitude_for_mapping(idx),...
        handles.track_subset.Longitude_for_mapping(idx), latouts, lonouts,...
         'm',2);
     waitfor(msgbox('Close to display next timeslice'));
     delete(projected);

end
