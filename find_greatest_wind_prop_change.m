%% TC Intensification
% Find TC timesteps that encounter an eddy and then display an increase in
% WindWMO or Displacement_d1

windIdx = bitand(IBTrACS_1992_2010.Wind_d1 >= 25, IBTrACS_1992_2010.WindWMO ~= IBTrACS_1992_2010.Wind_d1);
propIdx = IBTrACS_1992_2010.Displacement_d1 >= 500;

for i = 1 : size(windIdx,1 )
    if(windIdx(i))
        if(isnan(IBTrACS_1992_2010.EddyClass(i-1)))
            windIdx(i) = 0;
        elseif(IBTrACS_1992_2010.Traj_Eddy_Center_Pass_dist(i-1) > 25)
            windIdx(i) = 0;
        end
    end
    if(propIdx(i))
        if(isnan(IBTrACS_1992_2010.EddyClass(i-1)))
            propIdx(i) = 0;
        elseif(IBTrACS_1992_2010.Traj_Eddy_Center_Pass_dist(i-1) > 25)
            propIdx(i) = 0;
        end
    end
            
end

p2 = IBTrACS_1992_2010(propIdx,:);
w2 = IBTrACS_1992_2010(windIdx,:);