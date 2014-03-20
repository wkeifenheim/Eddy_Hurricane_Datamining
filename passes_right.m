%Determine if hurricane passes to the left or right of an eddy center
%Developed with reference to:
%http://stackoverflow.com/questions/3461453/determine-which-side-of-a-line-a-point-lies
%http://www.mathworks.com/matlabcentral/newsreader/view_thread/164048
% on_left will be:
% 1 - if true
% 0 - if hurricane passes over the center of the eddy
% -1 - if passes on the left
%
% Values for x/y distances from pcarre projection....
% d = 0.0078 (50km)
% d = 0.0039 (25km)
%
% Arclength:
% d = 0.2248 (25km)
% d = 0.4497 (50km)

function [on_right, dist] = passes_right(x1, y1, x2, y2, eddy_x, eddy_y)
    
    test_result = (x2-x1)*(eddy_y - y1) - (y2-y1)*(eddy_x-x1);
    
%     Q1 = [x1 y1];
%     Q2 = [x2 y2];
%     P = [eddy_x eddy_y];
%     d = abs(det([Q2-Q1;P-Q1]))/norm(Q2-Q1);

      % Using x/y coordinates....
%     d_Q1_Q2_sqr = (x2-x1)^2 + (y2-y1)^2; %distance^2 from Q1 to Q2
%     d_Q1_eddy_sqr =(eddy_x-x1)^2 + (eddy_y-y1)^2; %d^2 from Q1 to eddy
%     d_Q2_eddy_sqr = d_Q1_eddy_sqr - d_Q1_Q2_sqr;
%     d = sqrt(d_Q2_eddy_sqr);
    
%     [d_Q1_Q2, az_Q1_Q2] = distance(x1,y1,x2,y2);
%     [d_Q1_eddy, az_Q1_eddy] = distance(x1,y1,eddy_x,eddy_y);
%     theta = abs(az_Q1_Q2 - az_Q1_eddy);
%     d = sind(theta) * d_Q1_eddy;
%     dist = d;
    dist = NaN;
% 
%     if(d < 0)
%         disp('negative distance!...')
%     end
%     
%     if(d <= 0.2248) %trajectory within 25km of eddy center
%         on_right = 0;
    if(test_result > 0)
        on_right = 1;
    elseif(test_result < 0)
        on_right = -1;
    elseif(test_result == 0)
        on_right = 0;
    else
        %errordlg('on_right: something ain`t right..');
        on_right = NaN;
    end

end