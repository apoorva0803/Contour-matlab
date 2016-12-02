function [vis] = vis_acm ( f, pts )
imshow ( f ); 
%pts_temp = [pts, pts([2:end 1], :)]; 
pts_temp = [pts(:,2), pts(:,1), pts([2:end 1],2), pts([2:end 1],1)];
vis = insertShape ( f, 'Line', pts_temp );