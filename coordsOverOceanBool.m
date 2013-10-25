% Utilizes a landmask datagrid cooresponding to [Z,R] of:
%
%   coast = load('coast.mat');
%   [Z, R] = vec2mtx(coast.lat, coast.long, ...
%       4, [-90 90], [-90 270], 'filled');
%
% Note: The '4' in the vec2mtx function means that the resulting datagrid 
% is at a .25 degree resolution.
%
% This function returns a boolean result on whether or not an input lat,lon
% is over land or not.
% Based on a post by Brett Shoelson
% http://www.mathworks.com/matlabcentral/answers/1065
%
% Requires: landmask_datagrid.mat

function isOcean = coordsOverOceanBool(lat, lon)

    % Loads landmask_R and landmask_Z in to the workspace
    load('/project/expeditions/woodrow/Datasets/landmask_datagrid.mat');
    
    value_at_coords = ltln2val(landmask_Z, landmask_R, lat, lon, 'nearest');
    isOcean = (value_at_coords == 2);

end