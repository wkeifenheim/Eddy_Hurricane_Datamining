wait_h = waitbar(0,'progress..');
time_slices = zeros(60819,1);
for i = 1 : 60819
    isovec = datevec(cellstr(IBTrACS_All_1992_2010(i,7)));
    year = num2str(isovec(1));
    month = num2str(isovec(2));
    day = num2str(isovec(3));
    time_slices(i) = str2double(findTimeSlice(year,month,day));
    waitbar(i/60819)
end
delete(wait_h)