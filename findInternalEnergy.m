function [part1,part2,internalEnergy] = findInternalEnergy (pts,alpha,beta )
internalEnergy = 0;

part1 = 0;
for i=1:size(pts,1)-1
    part1 = part1 + sqrt(sum(abs(pts(i,:)-pts(i+1,:)).^2));
end
part1 = part1 + sqrt(sum(abs(pts(size(pts,1),:)-pts(1,:)).^2));

part2 = 0;
part2 = part2 + sqrt(sum(abs(pts(end,:)-(2*pts(1,:))+pts(2,:)).^2));
for i=2:size(pts,1)-1
    part2 = part2 + sqrt(sum(abs(pts(i-1,:)-(2*pts(i,:))+pts(i+1,:)).^2));
end
part2 = part2 + sqrt(sum(abs(pts(end-1,:)-(2*pts(end,:))+pts(1,:)).^2));

internalEnergy = (alpha*part1)+(beta*part2);