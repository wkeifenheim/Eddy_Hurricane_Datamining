wait_h = waitbar(0,'progress..');
pruned_ibtrk = dataset();
for i = 1 : 66280
    isovec = datevec(cellstr(IBTrACS_All_1992_2010(i,7)));
    hour = isovec(4);
    if(mod(hour,6) == 0)
        pruned_ibtrk = [pruned_ibtrk; IBTrACS_All_1992_2010(i,:)];
    end
    waitbar(i/66280)
end
delete(wait_h)