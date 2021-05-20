function out=lbutter(im,Fc,n)
% LBUTTER(IM,D,N) creates a low-pass Butterworth filter
% of the same size as image IM, with cutoff Fc, and order N
%
% Use:
% x=imread('cameraman.tif');
% l=lbutter(x,25,2);
%
sz = size(im); % (mrows,ncols)->(y,x)
[x, y] = meshgrid(1 : sz(2), 1 : sz(1)); % 2D grid coordinates
r = sqrt((y - sz(1)/2).^2+ (x - sz(2)/2).^2); % radius fn of position
out=1./(1.0+(r/Fc).^(2*n)); 

