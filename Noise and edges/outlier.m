function res=outlier(im,d)
% OUTLIER(IMAGE,D) removes salt and pepper noise using an outlier method.
% This is done by using the following algorithm:
%
% For each pixel in the image, if the difference between its grey value
% and the average of its eight neighbours is greater than D, it is
% classified as noisy, and its grey value is changed to that of the
% average of its neighbours.
%
% IMAGE can be of type UINT8 or DOUBLE; the output is of type
% UINT8. The threshold value D must be chosen to be between 0 and 1.

%% Step 1 Average of 8 neighbors
f=[0.125 0.125 0.125; 0.125 0 0.125; 0.125 0.125 0.125]; 
imd=im2double(im);
imf=filter2(f,imd);

%% Step 2 Matrix of 1's at noisy pixels
r=abs(imd-imf)-d > 0;

%% Step 3 Replace noisy pixels with mean
rep_noise = r.*imf;

%% Step 4 Get original values of non-noisy pixels
non_noisy = (1-r).*imd;

%% Output
res=im2uint8(rep_noise + non_noisy);
end

