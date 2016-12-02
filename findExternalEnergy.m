function [externalEnergy] = findExternalEnergy ( f, pts,gx,gy )
externalEnergy = 0;

for i=1:size(pts,1)
    externalEnergy = externalEnergy + abs(gx(pts(i,1),pts(i,2)))^2 + abs(gy(pts(i,1),pts(i,2)))^2;
end