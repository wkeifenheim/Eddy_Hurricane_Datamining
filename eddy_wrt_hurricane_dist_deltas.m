%Search area projected in front of hurricane path for eddies, find the
%distance of the hurricane to the eddy centers, then calculate the delta
%w.r.t. the eddy centers after the hurricane has moved to its next
%time-step

%results will contain values for the following columns:
% 1 - delta_wrt_cyc
% 2 - delte_wrt_acyc
% 3 - sum_cyc_amp
% 4 - sum_acyc_amp
% 5 - num_cyc
% 6 - num_acyc
results = zeros(size(IBTrACS_1992_2010,1),6);