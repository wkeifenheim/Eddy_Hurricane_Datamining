%The following will create plots based on the percentage of
%hurricane time steps, by their eddy association, occur within a given
%basin as well as what hemispheres.

load('/panfs/roc/groups/6/kumarv/keifenhe/Documents/HE_tables/tables_for_matlab.mat');

titles = cell(9,1);
titles(1) = cellstr('Northern Hemisphere');
titles(2) = cellstr('Southern Hemisphere');
titles(3) = cellstr('North Atlantic');
titles(4) = cellstr('South Atlantic');
titles(5) = cellstr('West Pacific');
titles(6) = cellstr('East Pacific');
titles(7) = cellstr('South Pacific');
titles(8) = cellstr('North Indian');
titles(9) = cellstr('South Indian');

for i = 1 : 9
    
   plot_me = [one_week(i,:); two_weeks(i,:); three_weeks(i,:);...
       four_weeks(i,:); five_weeks(i,:)];
   
   plot_me_too = ones(5,2);
   plot_me_too(:,1) = plot_me_too(:,1) * all_weeks(i,1);
   plot_me_too(:,2) = plot_me_too(:,2) * all_weeks(i,2);
   
   plot_h.plot = plot(plot_me,'*-');
   plot_h.title = title(titles(i));
   plot_h.xlabel = xlabel('Weeks');
   plot_h.ylabel = ylabel('Percent');
   plot_h.legend = legend('Cyclonic','Anticyclonic','Location','NorthWest');
   hold on
   plot_h.plot2 = plot(plot_me_too,'--');
   
   delete(gca)
end