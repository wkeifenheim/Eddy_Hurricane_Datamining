source_path = '/project/expeditions/eddies_project_data/results/tracks_viewer_data/SSH/';
load(strcat(source_path, 'dates.mat'));
dest_path = '/project/expeditions/eddies_project_data/web_viewer/SSH/';
wait_h = waitbar(0, 'progress of converting SSH to .dat');
for i = 1 : 52
    source_file = strcat(source_path, 'ssh_', num2str(dates(i)), '.mat');
    load(source_file);
    dlmwrite(strcat(dest_path, 'ssh_', num2str(dates(i)), '.dat'), data);
    waitbar(i/52);
end
delete(wait_h);