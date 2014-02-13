%Find sums of eddies per hurricane categories


idx = zeros(size(subset,1),8);
idx(:,1) = strcmp(subset.Category(:),'unknown');
idx(:,2) = strcmp(subset.Category(:),'TD');
idx(:,3) = strcmp(subset.Category(:),'TS');
idx(:,4) = strcmp(subset.Category(:),'1');
idx(:,5) = strcmp(subset.Category(:),'2');
idx(:,6) = strcmp(subset.Category(:),'3');
idx(:,7) = strcmp(subset.Category(:),'4');
idx(:,8) = strcmp(subset.Category(:),'5');
idx = logical(idx);

%row1: cyclonic
%row2: anticyclonic
sums = zeros(2,8);

for i = 1 : 8
   sums(1,i) = sum(subset.EddyClass(idx(:,i)) == -1);
   sums(2,i) = sum(subset.EddyClass(idx(:,i)) == 1);
end