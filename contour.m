clear; clc; close all;
mainImage = imread('circle.png');
mainImage = imfilter(mainImage,ones(13,13)/13^2);
[R,C] = size(mainImage);
alpha = 1;
beta = 1;
stepSize = 5;
points = 5;

pts = zeros(40,2);
pts(1:10,1) = 1;
pts(1:10,2) = floor(1:C/10:C);

pts(11:20,1) = floor(1:R/10:R);
pts(11:20,2) = C;

pts(21:30,1) = R;
pts(21:30,2) = floor(C:-C/10:1);

pts(31:40,1) = floor(R:-R/10:1);
pts(31:40,2) = 1;

Npts = size(pts,1);
imshow(vis_acm(mainImage,pts));

gx = imfilter(single(mainImage),[-1 1]);
gy = imfilter(single(mainImage),[-1 1]');

[fst,scnd,~] = findInternalEnergy(pts,alpha,beta);
ext = findExternalEnergy(mainImage,pts,gx,gy);
originalEnergy = ext + fst + scnd;
for i=1:100001     
    oldPoints = pts;
    
    randPoint = randi(Npts);
    pts(randPoint,1) = ceil(pts(randPoint,1) + randi(stepSize) - ceil(stepSize/2));
    pts(randPoint,2) = ceil(pts(randPoint,2) + randi(stepSize) - ceil(stepSize/2));
    
    if pts(randPoint,1) <= 0
        pts(randPoint,1) = 1;
    end
    if pts(randPoint,1) > R
        pts(randPoint,1) = R;
    end
    
    if pts(randPoint,2) <= 0
        pts(randPoint,2) = 1;
    end
    if pts(randPoint,2) > C
        pts(randPoint,2) = C;
    end
    
    [fst,scnd,internal] = findInternalEnergy(pts,alpha,beta);
    ext = findExternalEnergy(mainImage,pts,gx,gy);
    newEnergy = ext + internal;
    if newEnergy < originalEnergy
        originalEnergy = newEnergy;
    else
        pts = oldPoints;
    end
    
    if (i == 1000 || i == 30000 || i == 100000)
        figure; imshow(vis_acm(mainImage,pts));
        title(sprintf('Iteration: %d Ext Energy: %d 1st Deriv: %0.2f  \n 2nd Deriv: %0.2f  Total Energy: %0.2f',i,ext,fst,scnd,originalEnergy));
    end
end



