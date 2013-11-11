t = cputime;
 results = zeros(66280,7);
i = 1; %Hurricane Francis - 1992/10/22

% year = double(ebtrkatlc1992_2010(i,3));
% month = double(ebtrkatlc1992_2010(i,4));
% day = double(ebtrkatlc1992_2010(i,5));
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
while(i <= 66280)
    lat = double(IBTrACS_All_1992_2010(i,17));
    lon = double(IBTrACS_All_1992_2010(i,18));
    
    % Keep track of when to load next weeks eddy bodies
    % Or reload eddy files when next hurricane starts (hurricanes don't
    % necessarily end/start on consecutive days)
    if(nextEddyWeek == 0 || ~strcmpi(hurID, cellstr(IBTrACS_All_1992_2010(i,1))))
        
%         year = double(ebtrkatlc1992_2010(i,3));
%         month = double(ebtrkatlc1992_2010(i,4));
%         day = double(ebtrkatlc1992_2010(i,5));
%         hurID = cellstr(ebtrkatlc1992_2010(i,2));

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
        
        
        % Calculating offset is often redundant, but necessary to account
        % for begining a new hurricane
         offset = iso_date(4)/6 + ((weekday(strcat(year_str,...
            '-', month_str, '-', day_str)) - 1) * 4);
        
        nextEddyWeek = 28 - offset;
        
        [results(i,1), results(i,2), results(i,3), results(i,4),...
            results(i,5), results(i,6), results(i,7)] = calcClosest(...
            lat,lon, antiCyc, cyc);
        
        i = i + 1;
        
    else

        [results(i,1), results(i,2), results(i,3), results(i,4),...
            results(i,5), results(i,6), results(i,7)] = calcClosest(...
            lat,lon, antiCyc, cyc);
        
        nextEddyWeek = nextEddyWeek - 1;
        i = i + 1;
        
        
    end

end

    e = cputime -t

