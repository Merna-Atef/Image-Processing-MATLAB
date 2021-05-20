function out=hbutter(im,Fc,n)
% HBUTTER(IM,D,N) creates a high-pass Butterworth filter
% of the same size as image IM, with cutoff Fc, and order N
%
% Use:
% x=imread('cameraman.tif');
% l=hbutter(x,25,2);
%
out=1-lbutter(im,Fc,n);

