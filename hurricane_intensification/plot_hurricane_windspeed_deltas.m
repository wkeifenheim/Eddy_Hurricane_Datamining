%plot figures of both entering and exiting hurricane and their wind speed
%delta during that time

%quarters for splitting figures by hurricane translational speed
disp_25 = prctile(IBTrACS_1992_2010.Displacement_d1(:),25);
disp_50 = prctile(IBTrACS_1992_2010.Displacement_d1(:),50);
disp_75 = prctile(IBTrACS_1992_2010.Displacement_d1(:),75);
disp_100 = max(IBTrACS_1992_2010.Displacement_d1(:));


%Determine indices of entering and exiting hurricane time-steps
data_size = size(IBTrACS_1992_2010,1);

cur_hur = IBTrACS_1992_2010.Serial_Num(1);
enter_eddy = false(data_size,1); %first time-step inside eddy
leave_eddy = false(data_size,1); %first time-step after exiting eddy

wait_h = waitbar(0,'determining enter/exit indices');
for i = 1 : data_size - 1
    if(~strcmp(cur_hur, IBTrACS_1992_2010.Serial_Num(i)))
        cur_hur = IBTrACS_1992_2010.Serial_Num(i);
    else
        if(strcmp(cur_hur,IBTrACS_1992_2010.Serial_Num(i+1)))
            if(isnan(IBTrACS_1992_2010.EddyClass(i)) && ~isnan(IBTrACS_1992_2010.EddyClass(i+1)))
                enter_eddy(i+1) = true;
            elseif(~isnan(IBTrACS_1992_2010.EddyClass(i)) && isnan(IBTrACS_1992_2010.EddyClass(i+1)))
                leave_eddy(i+1) = true;
            end
            
        end
        
    end
    waitbar(i/data_size);
end
delete(wait_h);


%plot changes of windspeed when just entering eddies
f1 = figure;
bins = (-100:5:75);
cyc_enter_idx = bitand(enter_eddy,IBTrACS_1992_2010.EddyClass(:) == -1);
acyc_enter_idx = bitand(enter_eddy,IBTrACS_1992_2010.EddyClass(:) == 1);

cyc_counts = histc(IBTrACS_1992_2010.Wind_d1(cyc_enter_idx),bins);
acyc_counts = histc(IBTrACS_1992_2010.Wind_d1(acyc_enter_idx),bins);
counts = [cyc_counts, acyc_counts];
p1 = plot(bins,cyc_counts);
hold on;
p2 = plot(bins,acyc_counts, 'r');
legend('cyclonic eddies','anticyclonic');
title('Windspeed delta at first time-step inside eddy | All translational speeds');
ylabel('count');
xlabel('Windspeed Delta (knots)');

%first quarter of translational speed..
f2 = figure;
bins = (-100:5:75);
cyc_enter_idx = bitand(bitand(enter_eddy,IBTrACS_1992_2010.EddyClass(:) == -1),...
    IBTrACS_1992_2010.Displacement_d1(:) <= disp_25);
acyc_enter_idx = bitand(bitand(enter_eddy,IBTrACS_1992_2010.EddyClass(:) == 1),...
    IBTrACS_1992_2010.Displacement_d1(:) <= disp_25);

cyc_counts = histc(IBTrACS_1992_2010.Wind_d1(cyc_enter_idx),bins);
acyc_counts = histc(IBTrACS_1992_2010.Wind_d1(acyc_enter_idx),bins);
counts = [cyc_counts, acyc_counts];
p3 = plot(bins,cyc_counts);
hold on;
p4 = plot(bins,acyc_counts, 'r');
legend('cyclonic eddies','anticyclonic');
title('Windspeed delta at first time-step inside eddy | 1-25th translational speeds');
ylabel('count');
xlabel('Windspeed Delta (knots)');

%second quarter of translational speed..
f3 = figure;
bins = (-100:5:75);
bound_idx = bitand(IBTrACS_1992_2010.Displacement_d1(:) > disp_25,...
    IBTrACS_1992_2010.Displacement_d1(:) <= disp_50);
cyc_enter_idx = bitand(bitand(enter_eddy,IBTrACS_1992_2010.EddyClass(:) == -1),...
    bound_idx);
acyc_enter_idx = bitand(bitand(enter_eddy,IBTrACS_1992_2010.EddyClass(:) == 1),...
    bound_idx);

cyc_counts = histc(IBTrACS_1992_2010.Wind_d1(cyc_enter_idx),bins);
acyc_counts = histc(IBTrACS_1992_2010.Wind_d1(acyc_enter_idx),bins);
counts = [cyc_counts, acyc_counts];
p5 = plot(bins,cyc_counts);
hold on;
p6 = plot(bins,acyc_counts, 'r');
legend('cyclonic eddies','anticyclonic');
title('Windspeed delta at first time-step inside eddy | 26th-50th translational speeds');
ylabel('count');
xlabel('Windspeed Delta (knots)');

%third quarter of translational speed..
f4 = figure;
bins = (-100:5:75);
bound_idx = bitand(IBTrACS_1992_2010.Displacement_d1(:) > disp_50,...
    IBTrACS_1992_2010.Displacement_d1(:) <= disp_75);
cyc_enter_idx = bitand(bitand(enter_eddy,IBTrACS_1992_2010.EddyClass(:) == -1),...
    bound_idx);
acyc_enter_idx = bitand(bitand(enter_eddy,IBTrACS_1992_2010.EddyClass(:) == 1),...
    bound_idx);

cyc_counts = histc(IBTrACS_1992_2010.Wind_d1(cyc_enter_idx),bins);
acyc_counts = histc(IBTrACS_1992_2010.Wind_d1(acyc_enter_idx),bins);
counts = [cyc_counts, acyc_counts];
p7 = plot(bins,cyc_counts);
hold on;
p8 = plot(bins,acyc_counts, 'r');
legend('cyclonic eddies','anticyclonic');
title('Windspeed delta at first time-step inside eddy | 51st-75th translational speeds');
ylabel('count');
xlabel('Windspeed Delta (knots)');

%fourth quarter of translational speed..
f5 = figure;
bins = (-100:5:75);
bound_idx = bitand(IBTrACS_1992_2010.Displacement_d1(:) > disp_25,...
    IBTrACS_1992_2010.Displacement_d1(:) <= disp_50);
cyc_enter_idx = bitand(bitand(enter_eddy,IBTrACS_1992_2010.EddyClass(:) == -1),...
    bound_idx);
acyc_enter_idx = bitand(bitand(enter_eddy,IBTrACS_1992_2010.EddyClass(:) == 1),...
    bound_idx);

cyc_counts = histc(IBTrACS_1992_2010.Wind_d1(cyc_enter_idx),bins);
acyc_counts = histc(IBTrACS_1992_2010.Wind_d1(acyc_enter_idx),bins);
counts = [cyc_counts, acyc_counts];
p9 = plot(bins,cyc_counts);
hold on;
p10 = plot(bins,acyc_counts, 'r');
legend('cyclonic eddies','anticyclonic');
title('Windspeed delta at first time-step inside eddy | 76th-100th translational speeds');
ylabel('count');
xlabel('Windspeed Delta (knots)');