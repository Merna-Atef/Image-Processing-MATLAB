%%%% Histogram Equalization
image = imread("low_contrast.tif");
eq_image = histeq(image);
figure
subplot(2,2,1)
imshow(image)
subplot(2,2,2)
imhist(image), axis tight
subplot(2,2,3)
imshow(eq_image)
subplot(2,2,4)
imhist(eq_image), axis tight
%%%%%%%%%%%%
%%%% Extra: histogram equalization vs. contrast stretching
% pollenLowCont = imread('low_contrast.tif');
% minimum = min(min(pollenLowCont));
% maximum = max(max(pollenLowCont));
% contrastStretch = imadjust(pollenLowCont, [double(minimum)/255, double(maximum)/255],[0, 1]);
% figure
% subplot(2,2,1)
% imshow(contrastStretch)
% subplot(2,2,2)
% imhist(contrastStretch), axis tight
% subplot(2,2,3)
% imshow(histeq(pollenLowCont)), axis tight
% subplot(2,2,4)
% imhist(histeq(pollenLowCont)), axis tight
