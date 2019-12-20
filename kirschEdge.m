function [imageOut kirschImage] = kirschEdge(imageIn)
% kirschEdge.m
% J. Jenkinson, UTSA ECE, SiViRT, May 5, 2015.
if length(size(imageIn)) == 3
        imageIn = rgb2gray(imageIn);     
end
imageIn = double(imageIn);
[N M L] = size(imageIn);
g = double( (1/15)*[5 5 5;-3 0 -3; -3 -3 -3] );
kirschImage = zeros(N,M,6);
th = zeros(3,3,8);
for j = 1:8
    theta = (j-1)*45;
    gDirection = imrotate(g,theta,'crop');
    th(:,:,j) = gDirection;
    kirschImage(:,:,j) = conv2(imageIn, gDirection,'same');
end
imageOut = zeros(N,M);
for n = 1:N
    for m = 1:M
        imageOut(n,m) = max(kirschImage(n,m,:));
    end
end


% filter_response(:,:,1) = max(kirschImage(:,:,1:3),[],3);
% filter_response(:,:,2) = max(kirschImage(:,:,4:6),[],3);
% filter_response(:,:,3) = max(kirschImage(:,:,7:9),[],3);
end
