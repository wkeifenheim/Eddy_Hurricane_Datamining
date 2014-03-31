total = size(IBTrACS_1992_2010_daily,1);
wait_h = waitbar(0,'progress');
eddydates = zeros(total,1);
parfor i = 1 : total
    [y,m,d] = datevec(IBTrACS_1992_2010_daily.ISO_time(i));
    if(m < 10)
        m = strcat('0',num2str(m));
    else
        m = num2str(m);
    end
    if(d < 10)
        d = strcat('0',num2str(d));
    else
        d = num2str(d);
    end
    date_str = strcat(num2str(y),m,d);
    eddydates(i) = str2double(date_str);
    waitbar(i/total)
end
delete(wait_h)