%Moving average of time-series data: IBTrACS
%Requires: IBTrACS_eddies_1992_2010_v2
%Requires: IBTrACS_indices


%which column to calculate the moving average
cols = [9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 23, 24];
mov_avg_result = zeros(60819,13);
ibt = IBTrACS_eddies_1992_2010_v2;
for h = 1 : 13
    col = cols(h);
    
    for i = 1 : 1915

        a = IBTrACS_indices.Start_Index(i);
        b = IBTrACS_indices.Stop_Index(i);

        mov_avg_result(a,h) = nanmean([double(ibt(a,col)),...
            double(ibt(a+1,col)), double(ibt(a+2,col))]);

        mov_avg_result(a+1,h) = nanmean([double(ibt(a,col)),...
            double(ibt(a+1,col)), double(ibt(a+2,col)), double(ibt(a+3,col))]);

        for j = (a+2) : (b-2)
            mov_avg_result(j,h) = nanmean([double(ibt(j-2,col)),...
                double(ibt(j-1,col)), double(ibt(j,col)),...
                double(ibt(j+1,col)), double(ibt(j+2,col))]);
        end

        mov_avg_result(b-1,h) = nanmean([double(ibt(b-3,col)),...
            double(ibt(b-2,col)), double(ibt(b-1,col)), double(ibt(b,col))]);

        mov_avg_result(b,h) = nanmean([double(ibt(b-2,col)),...
            double(ibt(b-1,col)), double(ibt(b,col))]);

    end
end
    