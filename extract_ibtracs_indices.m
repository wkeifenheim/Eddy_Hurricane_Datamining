t = cputime;

% a = mat2dataset(zeros(1915,2))
% res2 = dataset({res',{IBTrACS_ID}});
% a = [res2, a];
% b = cellstr(['IBTrACS_ID '; 'Start_Index'; 'Stop_Index ']);
% IBTrACS_indices = dataset(a,{b{:}});

IBTrACS_indices.IBTrACS_ID(1) = IBTrACS_eddies_1992_2010_v1.Serial_Num(1);
IBTrACS_indices.Start_Index(1) = 1;

cur_id = IBTrACS_eddies_1992_2010_v1.Serial_Num(1);
indices_idx = 1;


for i = 2 : size(IBTrACS_eddies_1992_2010_v1,1) - 1;
    if(~strcmp(cur_id, IBTrACS_eddies_1992_2010_v1.Serial_Num(i)))
        IBTrACS_indices.Stop_Index(indices_idx) = i - 1;
        indices_idx = indices_idx + 1;
        IBTrACS_indices.Start_Index(indices_idx) = i;
        cur_id = IBTrACS_eddies_1992_2010_v1.Serial_Num(i);
    end

end

disp('elapsed time:')
e = cputime-t