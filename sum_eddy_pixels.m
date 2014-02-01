% this script checks each eddy in a given hurricane track and finds the
% number of pixels of the eddies.  Three fields are populated for each
% hurricane:
%   Sum of pixels for all cyclonic eddies
%   Sum of pixels for all anticyclonic eddies
%   Cell of strings of the form HHH:E:PPPP described below
%       HHH - The age at which the hurricane track encountered the eddy
%       C - the class of the eddy (cyc, acyc)
%       PPPP - the number of pixels (size) assigned to the eddy
%       : - a delimiter


%will contain the sum of pixels for a given hurricane, by eddy class
%i.e. pixels(1,:) = [cyc_pixels, acyc_pixels];
pixels = zeros(1915,2);

%store the first timestep at which a hurricane encountered an eddy
first_encounter = zeros(1915,1);
first_type = [];

%will contain strings following the description given above..
list = cell(1915,1);

%store the pixel size of all encountered cyc/acyc eddies
cyc_pixels = [];
acyc_pixels =[];

%running index of what hurricane track we are on. should not exceed 1915
j = 1;

%flag for keeping track of first eddy encountered in a hurricane track
first = 1;

%remember last encountered eddy so sequential time steps near that eddy
%can be tallied..
rem_ed_type = NaN;
rem_ed_idx = NaN;
rem_ed_count = 0;

cur_hur = IBTrACS_1992_2010_NewI.Serial_Num(1);
wait_h = waitbar(0,'progress');

for i = 1 : 60819
    
    %advance the hurricane counter if needed..
    if(~strcmp(cur_hur, IBTrACS_1992_2010_NewI.Serial_Num(i)))
        j = j + 1;
        cur_hur = IBTrACS_1992_2010_NewI.Serial_Num(i);
        rem_ed_type = NaN;
        rem_ed_idx = NaN;
        rem_ed_count = 0;
        first = 1;
    end
    
    %find the correct timeslice, assuming all timeslices are preloaded
    time_idx = find(eddy_track_date_indices.Date(:) == IBTrACS_1992_2010_NewI.TimeSlice(i));
    e_idx = IBTrACS_1992_2010_NewI.EddyIdx(i);
    
    if(IBTrACS_1992_2010_NewI.EddyClass(i) == -1) %cyc
        %HHH:E:PPPP
        hhh = num2str(IBTrACS_1992_2010_NewI.HurricaneAge(i));
        e = 'C';
        pppp = h_cyc(time_idx).eddies(e_idx).Stats.Area;
        pixels(j,1) = pixels(j,1) + pppp;
%         pppp = num2str(pppp);
%         list_str = strcat(hhh, ':', e, ':', pppp);
%         list{j} = strcat(list{j}, {' '}, list_str);
        cyc_pixels = [cyc_pixels; pppp];
        rem_ed_type = -1;
        rem_ed_idx = IBTrACS_1992_2010_NewI.EddyIdx(i);
        if(first)
           first_encounter(j) = str2double(hhh);
           first_type = [first_type; 'C'];
           first = 0;
        end
        
    elseif(IBTrACS_1992_2010_NewI.EddyClass(i) == 1) %acyc
        hhh = num2str(IBTrACS_1992_2010_NewI.HurricaneAge(i));
        e = 'A';
        pppp = h_acyc(time_idx).eddies(e_idx).Stats.Area;
        pixels(j,2) = pixels(j,2) + pppp;
%         pppp = num2str(pppp);
%         list_str = strcat(hhh, ':', e, ':', pppp);
%         list{j} = strcat(list{j}, {' '}, list_str);
        acyc_pixels = [acyc_pixels; pppp];
        rem_ed_type = 1;
        rem_ed_idx = IBTrACS_1992_2010_NewI.EddyIdx(i);
        if(first)
           first_encounter(j) = str2double(hhh);
           first_type = [first_type; 'A'];
           first = 0;
        end
    end
    
    if(rem_ed_type == IBTrACS_1992_2010.EddyClass(i) &&...
            rem_ed_idx == IBTrACS_1992_2010.EddyIdx(i))
        rem_ed_count = rem_ed_count + 1;
    elseif(rem_ed_count)
        rem_ed_type = NaN;
        rem_ed_idx = NaN;
        rem_ed_count = 0;
        count = num2str(rem_ed_count);
        pppp = num2str(pppp);
        list_str = strcat(hhh, ':', e, ':', count, ':', pppp);
        list{j} = strcat(list{j}, {' '}, list_str);
    end
    
    waitbar(i/60819)
end
delete(wait_h)