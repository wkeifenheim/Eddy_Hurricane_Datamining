mins = [0 0 0];
maxs = [0 0 0];

for i=3 : 21

    % The following nbins calculation is not great when it gets greater
    % than (approx) 40, or if a given column has discrete integer values
    % that differ by more than 1 (say 5, 10 ,15, 20, etc...)
    nbins = max(double(ebtrkatlc_acyc(:,i)))- min(double(ebtrkatlc_acyc(:,i)));
    [n1,wout1] = hist(double(ebtrkatlc_acyc(:,i)),nbins);
    [n2,wout2] = hist(double(ebtrkatlc_cyc(:,i)),nbins);
    [n3,wout3] = hist(double(ebtrkatlc_miss(:,i)),nbins);
    
    plot(wout1,n1,'r');
    hold on
    plot(wout2,n2,'g');
    plot(wout3,n3,'w');
    
    waitfor(handle)
    
end