

for i = 10 : 22
    nbins = floor(abs(min(double(ebtrkatlc_cyc(:,i)))) + abs(max(double(ebtrkatlc_cyc(...
        :,i)))) / 5);
%    nbins = 60;
    [n1,wout1] = hist(double(ebtrkatlc_acyc(:,i)),nbins);
    n1 = n1 / size(ebtrkatlc_acyc,1);
%     wout1 / size(ebtrkatlc_acyc,1);
    [n2,wout2] = hist(double(ebtrkatlc_cyc(:,i)),nbins);
    n2 = n2 / size(ebtrkatlc_cyc,1);
%     wout2 / size(ebtrkatlc_cyc,1);
    [n3,wout3] = hist(double(ebtrkatlc_miss(:,i)),nbins);
    n3 = n3 / size(ebtrkatlc_miss,1);
%     wout3 / size(ebtrkatlc_miss,1);
    plot(wout1,n1,'r')
    hold on
    plot(wout2,n2,'g')
    plot(wout3,n3,'b')

end