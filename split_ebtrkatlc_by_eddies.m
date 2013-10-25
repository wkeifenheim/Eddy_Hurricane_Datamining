%ebtrkatlc_miss - hurricane step with no eddy association
%ebtrkatlc_acyc = "                  " anticyclonic eddy association
%ebtrkatlc_cyc = "                   " cyclonic eddy association

ebtrkatlc_miss = dataset();
ebtrkatlc_acyc = dataset();
ebtrkatlc_cyc = dataset();
load('/panfs/roc/groups/6/kumarv/keifenhe/Documents/Datasets/EBTracks_Atlantic1992-2010v4.mat'); % loads ebtrkatlc1992_2010 into workspace

for i=1 : size(ebtrkatlc1992_2010,1)
    if(isnan(double(ebtrkatlc1992_2010(i,18))))
        ebtrkatlc_miss = [ebtrkatlc_miss; ebtrkatlc1992_2010(i,:)];
    elseif(double(ebtrkatlc1992_2010(i,18)) == 1) %anticyclonic association
        ebtrkatlc_acyc = [ebtrkatlc_acyc; ebtrkatlc1992_2010(i,:)];
    elseif(double(ebtrkatlc1992_2010(i,18)) == -1) %cyclonic association
        ebtrkatlc_cyc = [ebtrkatlc_cyc; ebtrkatlc1992_2010(i,:)];
    end
end