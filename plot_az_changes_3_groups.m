%plot the changes of azimuth for all eddy encounters, encounters featuring
%a hurricane trajectory that passes within a bound of the eddy center, and
%a distribution of azimuth changes of the whole-bound...

% %bounds are values in kilometers
% disp_25 = prctile(IBTr_eddies.Displacement_d1(:),25);
% disp_50 = prctile(IBTr_eddies.Displacement_d1(:),50);
% disp_75 = prctile(IBTr_eddies.Displacement_d1(:),75);
% disp_100 = max(IBTr_eddies.Displacement_d1(:));

%Subset flags.  (left_only && right_only) -> false
one_off = true;
left_only = false;
right_only = true;
lower_bound = disp_75; %translational speed
upper_bound = disp_100; %" ... "


bound_idx = bitand(pass_dist_25.Pass_dist(:) > 25,...
    pass_dist_25.Pass_dist(:) <= 50);
outside_idx = bitand(bitand(~bound_idx,~isnan(pass_dist_25.Pass(:))), pass_dist_25.Pass_dist(:) > 50);
inside_idx = bitand(bitand(~bound_idx,~isnan(pass_dist_25.Pass(:))), pass_dist_25.Pass_dist(:) <= 25);
bins = -187.5:5:187.5;
%bins = [-200, bins, 200];

f = figure;
set(f,'Name','Translational speeds in 0th-25th percentile | Single Interactions, Right of Eddy Center Trajectory');

all_eddies = IBTrACS_1992_2010(~isnan(IBTrACS_1992_2010.EddyClass(:)),:);
% all_eddies = all_eddies(bitand(all_eddies.Displacement_d1(:) >= lower_bound,...
%     all_eddies.Displacement_d1(:) < upper_bound),:);
all_eddies = all_eddies(all_eddies.Displacement_d1(:) < disp_25,:);
if(one_off)
    all_eddies = all_eddies(all_eddies.one_only(:) == true,:);
end
if(left_only)
    all_eddies = all_eddies(all_eddies.left_center_right_pass(:) == -1,:);
end
if(right_only)
    all_eddies = all_eddies(all_eddies.left_center_right_pass(:) == 1,:);
end
cyc_idx = all_eddies.EddyClass(:) == -1;
acyc_idx= all_eddies.EddyClass(:) == 1;
a1 = subplot(5,1,1);
c1 = histc(all_eddies.Az_d1(cyc_idx),bins);
a1 = histc(all_eddies.Az_d1(acyc_idx),bins);
tots = [c1 a1];
p1 = bar(bins,tots,'histc');
title('Disribution of azimuth changes for all eddy interactions');
ylabel('count');

bound_eddies = IBTrACS_1992_2010(bound_idx,:);
% bound_eddies = bound_eddies(bitand(bound_eddies.Displacement_d1(:) >= lower_bound,...
%     bound_eddies.Displacement_d1(:) < upper_bound),:);
bound_eddies = bound_eddies(bound_eddies.Displacement_d1(:) < disp_25,:);
if(one_off)
    bound_eddies = bound_eddies(bound_eddies.one_only(:) == true,:);
end
if(left_only)
    bound_eddies = bound_eddies(bound_eddies.left_center_right_pass(:) == -1,:);
end
if(right_only)
    bound_eddies = bound_eddies(bound_eddies.left_center_right_pass(:) == 1,:);
end
cyc_idx2 = bound_eddies.EddyClass(:) == -1;
acyc_idx2 = bound_eddies.EddyClass(:) == 1;
a2 = subplot(5,1,2);
c1 = histc(bound_eddies.Az_d1(cyc_idx2),bins);
a1 = histc(bound_eddies.Az_d1(acyc_idx2),bins);
tots = [c1 a1];
p2 = bar(bins,tots,'histc');
title('Disribution of azimuth changes for bound eddy interactions (25-50km)');
ylabel('count');

outside_eddies = IBTrACS_1992_2010(outside_idx,:);
% outside_eddies = outside_eddies(bitand(outside_eddies.Displacement_d1(:) >= lower_bound,...
%     outside_eddies.Displacement_d1(:) < upper_bound),:);
outside_eddies = outside_eddies(outside_eddies.Displacement_d1(:) < disp_25,:);
if(one_off)
    outside_eddies = outside_eddies(outside_eddies.one_only(:) == true,:);
end
if(left_only)
    outside_eddies = outside_eddies(outside_eddies.left_center_right_pass(:) == -1,:);
end
if(right_only)
    outside_eddies = outside_eddies(outside_eddies.left_center_right_pass(:) == 1,:);
end
cyc_idx3 = outside_eddies.EddyClass(:) == -1;
acyc_idx3 = outside_eddies.EddyClass(:) == 1;
a3 = subplot(5,1,3);
c1 = histc(outside_eddies.Az_d1(cyc_idx3),bins);
a1 = histc(outside_eddies.Az_d1(acyc_idx3),bins);
tots = [c1 a1];
p3 = bar(bins,tots,'histc');
title('Disribution of azimuth changes of eddy interactions outside bound (>50km)');
ylabel('count');
xlabel('change of azimuth')

inside_eddies = IBTrACS_1992_2010(inside_idx,:);
% inside_eddies = inside_eddies(bitand(inside_eddies.Displacement_d1(:) >= lower_bound,...
%     inside_eddies.Displacement_d1(:) < upper_bound),:);
inside_eddies = inside_eddies(inside_eddies.Displacement_d1(:) < disp_25,:);
if(one_off)
    inside_eddies = inside_eddies(inside_eddies.one_only(:) == true,:);
end
if(left_only)
    inside_eddies = inside_eddies(inside_eddies.left_center_right_pass(:) == -1,:);
end
if(right_only)
    inside_eddies = inside_eddies(inside_eddies.left_center_right_pass(:) == 1,:);
end
inside_eddies = inside_eddies(inside_eddies.Latitude_for_mapping(:) > 0,:);
cyc_idx3 = inside_eddies.EddyClass(:) == -1;
acyc_idx3 = inside_eddies.EddyClass(:) == 1;
a4 = subplot(5,1,4);
c1 = histc(inside_eddies.Az_d1(cyc_idx3),bins);
a1 = histc(inside_eddies.Az_d1(acyc_idx3),bins);
tots = [c1 a1];
p4 = bar(bins,tots,'histc');
title('Disribution of North hemisphere azimuth changes of eddy interactions inside bound (<=25km)');
ylabel('count');
xlabel('change of azimuth')

inside_eddies = IBTrACS_1992_2010(inside_idx,:);
% inside_eddies = inside_eddies(bitand(inside_eddies.Displacement_d1(:) >= lower_bound,...
%     inside_eddies.Displacement_d1(:) < upper_bound),:);
inside_eddies = inside_eddies(inside_eddies.Displacement_d1(:) < disp_25,:);
if(one_off)
    inside_eddies = inside_eddies(inside_eddies.one_only(:) == true,:);
end
if(left_only)
    inside_eddies = inside_eddies(inside_eddies.left_center_right_pass(:) == -1,:);
end
if(right_only)
    inside_eddies = inside_eddies(inside_eddies.left_center_right_pass(:) == 1,:);
end
inside_eddies = inside_eddies(inside_eddies.Latitude_for_mapping(:) < 0,:);
cyc_idx3 = inside_eddies.EddyClass(:) == -1;
acyc_idx3 = inside_eddies.EddyClass(:) == 1;
a5 = subplot(5,1,5);
c1 = histc(inside_eddies.Az_d1(cyc_idx3),bins);
a1 = histc(inside_eddies.Az_d1(acyc_idx3),bins);
tots = [c1 a1];
bar(bins,tots,'histc')
title('Disribution of South hemisphere azimuth changes of eddy interactions inside bound (<=25km)');
ylabel('count');
xlabel('change of azimuth')