%Take average of current and previous time step, subtracted from avereage
%of following two timesteps

%progress bar
bar_h = waitbar(0,'progress..');

%which column to calculate the moving average
cols = [9:2:29, 34, 36];
neu_change_result = zeros(60819,13);
ibt = IBTrACS_eddies_1992_2010_v3;
for h = 1 : 13
    col = cols(h);
    
    prec_h = (h-1) / 13;
    
    for i = 1 : 1915

        a = IBTrACS_indices.Start_Index(i);
        b = IBTrACS_indices.Stop_Index(i);

        neu_change_result(a,h) = NaN;

        for j = (a+1) : (b-2)
            neu_change_result(j,h) = (double(ibt(j+2,col)) + ...
                double(ibt(j+1,col)) / 2) - (double(ibt(j-1,col)) +...
                double(ibt(j,col)) / 2);
        end

        neu_change_result(b-1,h) = NaN;

        neu_change_result(b,h) = NaN;
        
        prec_done = i/24908 + prec_h;
        waitbar(prec_done)

    end
end
close(bar_h)
    