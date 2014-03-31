%Determine if hurricane passes to the left or right of an eddy center
%Developed with reference to:
%http://stackoverflow.com/questions/3461453/determine-which-side-of-a-line-a-point-lies
% on_left will be:
% 1 - if true
% 0 - if hurricane passes over the center of the eddy
% -1 - if passes on the right
%

function on_right = passes_right(x1, y1, x2, y2, eddy_x, eddy_y)
    
    %mfwdtran requires a map projection to be in use...
%     [p1.x, p1.y] = mfwdtran(x1, y1);
%     [p2.x, p2.y] = mfwdtran(x2, y2);
%     [e.x, e.y] = mfwdtran(eddy_x, eddy_y);
    
    test_result = (x2-x1)*(eddy_y - y1) - (y2-y1)*(eddy_x-x1);
    if(test_result > 0)
        on_right = 1;
    elseif(test_result < 0)
        on_right = -1;
    elseif(test_result == 0)
        on_right = 0;
    else
        %errordlg('on_left: something ain`t right..');
        on_right = NaN;
    end


end