%%Reading Images
%%%Reading Grey Images
grey=imread('cameraman.tif');
figure,imshow(grey), impixelinfo
%%%Reading Color Images
RGB = imread('peppers.png');
figure,imshow(RGB), impixelinfo
size(RGB)
RGB(100,200,:)
%%Image Information
imfinfo('cameraman.tif')
imfinfo('peppers.png')
%%Conversions
help datatypes
a = 23;
b=uint8(a);
whos a b
r2g = rgb2gray(RGB);
figure,imshow(r2g), impixelinfo
%%imshow
cd=double(grey);
imshow(grey),figure,imshow(cd)
imshow(grey),figure,imshow(cd/255) %%%Scaling it [0-1]
c2d = im2double(grey);
imshow(grey),figure,imshow(c2d)
t = [-0.5, 0.5;0.75,1.5] %%%Example
uint8(t)
im2uint8(t)
%%Binary Images
grey1 = grey>120;
imshow(grey1)