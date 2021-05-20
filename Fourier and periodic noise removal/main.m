% Chapter 9 Fourier

%% Tutorial 7

%% 1D DFT
a = [1,2,3,4,5,6]'; %%Must be in column vector form
fft(a)

%% Shifting
x = [2,3,4,5,6,7,8,1];
n = 0:7;
figure
subplot(1,3,1)
stem(n, x) ; grid;
title('Original Sequence')
xlabel('n') ;
x1=(-1).^(0:7).*x; %% vectorization, 
X=fft(x');
subplot(1,3,2)
stem(n, abs(X)) ; grid;
title('Original Sequence FT')
xlabel('f') ;
X1=fft(x1');
subplot(1,3,3)
stem(n, abs(X1)) ; grid;
title('Shifted Sequence to M/2=4 FT')
xlabel('f') ;
%% Conjugate Symmetry
fx = [2,3,4,5]'
Fu = fft(fx) %X2 = conj(X2) --> real, X1=conj(X3), (X0,1,2,3)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% STOPPED

%% Tutorial 8

%% 2D DFT
a = [100 200 100 200 100 200 100 200
100 200 100 200 100 200 100 200
100 200 100 200 100 200 100 200
100 200 100 200 100 200 100 200
100 200 100 200 100 200 100 200
100 200 100 200 100 200 100 200
100 200 100 200 100 200 100 200
100 200 100 200 100 200 100 200]; 
af = fft2(a); 

% FT of different shapes
%% A vertical edge (unit step)
a=[zeros(256,128) ones(256,128)];
figure, imshow(a)
af=fftshift(fft2(a));
fftshow(af)

%% A box
a=zeros(256,256);
a(78:178,78:178)=1;
imshow(a)
af=fftshift(fft2(a));
figure,fftshow(af)

%% rotated box
a45 = imrotate(a,45);
imshow(a45)
bf=fftshift(fft2(a45));
figure,fftshow(bf)

%% A circle
imageSizeOfX = 256; %%Size of image
imageSizeOfY = 256;
[colInImage, rowsInImage] = meshgrid(1 : imageSizeOfX, 1 : imageSizeOfY); %% 2D grid coordinates
x = colInImage;
y = rowsInImage;
centerOfX = 256/2; %%Center of circle
centerOfY = 256/2;
radius = 15; %%radius
Pixels = (y - centerOfY).^2+ (x - centerOfX).^2 <= radius.^2; %%logical matrix for a solid circle 
imshow(Pixels)
bf=fftshift(fft2(Pixels));
figure,fftshow(bf)

% Filtering
cm = imread('cameraman.tif');
cf = fftshift(fft2(cm));
figure, fftshow(cf,'log')

%% Low pass
cfl = cf.*Pixels;
figure, fftshow(cfl,'log')
cfli = ifft2(cfl); %% still complex coz fft2 gives approcximations, using abs rounds out errors
figure, fftshow(cfli, 'abs') %% ringing coz of sharp cutoff
% smaller circle more blurred, larger less blurred
radius = 5;
cir5 = (y - centerOfY).^2+ (x - centerOfX).^2 <= radius.^2;
cfl = cf.*cir5;
cfli = ifft2(cfl); 
figure, fftshow(cfli, 'abs') 
radius = 30;
cir30 = (y - centerOfY).^2+ (x - centerOfX).^2 <= radius.^2;
cfl = cf.*cir30;
cfli = ifft2(cfl); 
figure, fftshow(cfli, 'abs') 

%% High pass %opposite of low pass (0 at low freq)
radius = 15;
cir = (y - centerOfY).^2+ (x - centerOfX).^2 >= radius.^2;
figure, imshow(cir)
cfh = cf.*cir;
figure, fftshow(cfh, 'log') 
cflhi = ifft2(cfh); 
figure, fftshow(cflhi, 'abs') 
% If the cutoff is large, more information removed from the transform, leaving only the highest frequencies.
figure,
radius = 5;
cir = (y - centerOfY).^2+ (x - centerOfX).^2 >= radius.^2;
cfh = cf.*cir;
subplot(2,2,1), fftshow(cfh, 'log') 
cflhi = ifft2(cfh); 
subplot(2,2,2), fftshow(cflhi, 'abs') 
radius = 30;
cir = (y - centerOfY).^2+ (x - centerOfX).^2 >= radius.^2;
cfh = cf.*cir;
subplot(2,2,3), fftshow(cfh, 'log') 
cflhi = ifft2(cfh); 
subplot(2,2,4), fftshow(cflhi, 'abs') 

%% Butterworth
Fc = 15;
sz = size(cm);
[x, y] = meshgrid(1 : sz(2), 1 : sz(1)); %% 2D grid coordinates
r = sqrt((y - sz(1)/2).^2+ (x - sz(2)/2).^2);
% Low
bl=1./(1.0+(r/Fc).^2); % order 1
figure,imshow(bl)
cfbl=cf.*bl;
figure,fftshow(cfbl,'log')
cfbil=ifft2(cfbl);
figure,fftshow(cfbil,'abs')
% High
bh=hbutter(cm,15,1);
figure, imshow(bh)
cfbh=cf.*bh;
figure,fftshow(cfbh,'log')
cfbhi=ifft2(cfbh);
figure,fftshow(cfbhi,'abs')

%% Gaussian
% Create gaussian kernel
g1=mat2gray(fspecial('gaussian',256,10)); %%fspecial function on its own produces a low pass
    %filter with a very small maximum, So we need to scale the result so that
    %the central value will be 1, mat2gray does this
% multiply by transform
cg1=cf.*g1;
figure
subplot(2,2,1)
fftshow(cg1,'log')
cgi1=ifft2(cg1);
subplot(2,2,2)
fftshow(cgi1,'abs');

g2=mat2gray(fspecial('gaussian',256,30));
cg2=cf.*g2;
subplot(2,2,3)
fftshow(cg2,'log')
cgi2=ifft2(cg2);
subplot(2,2,4)
fftshow(cgi2,'abs');
%larger the standard deviation, the wider the function, and so the greater amount of the transform
%is preserved.

%% Removal of periodic noise 
%% Adding Periodic Noise
s = size(cm);
[x, y]= meshgrid(1:s(2),1:s(1));
n = 4; % number of cycles

%%% x-direction
Wx = max(max(x)); %Length of signal (x) (ncols)
fx = n/Wx;
px = sin(2*pi*fx*x)+1;
showImages({px,log(abs(fftshift(fft2(px))))}), impixelinfo 
% fmax = 1/2pixels, fx = 4/256 = 1/64 = fmax/32 --> 128->fmax, f->128/32=4
% peak at 4 pixels from center = 129+4 = 133
cm_pnx = mat2gray((im2double(cm)+px));
showImages({cm,px, cm_pnx})
% 
%%% y-direction
Wy = max(max(y)); %Length of signal (y) (nrows)
fy = n/Wy;
py = sin(2*pi*fy*y)+1;
showImages({cm,py, cm_pny})
cm_pny = mat2gray((im2double(cm)+py));

%%% xy
nxy = 1; 
fx = nxy/Wx;
fy = nxy/Wy;
pxy = sin(2*pi*fx*x + 2*pi*fy*y)+1; 
% Effective frequency is root(sqr(fx)+sqr(fy))
% Effective period = 1/eff_freq = 181 pixels --> half diagonal of image,
% giving 2 cycles at an angle of 45 degrees --> arctan(y/x)
cm_pnxy = mat2gray((im2double(cm)+pxy));
pxy2 = sin(3*2*pi*fx*x + sqrt(3)*2*pi*fy*y)+1; % arctan(y/x) = 30 degrees
cm_pnxy2 = mat2gray((im2double(cm)+pxy2));
showImages({cm, pxy, cm_pnxy, pxy2, cm_pnxy2})
% number of cycles differed coz eff_freq is different


%% Removing Periodic Noise
cm = imread('cameraman.tif');
[x,y]=meshgrid(1:256,1:256);
s=1+sin(x+y/1.5); %range  0-2
cp=(double(cm)/128+s)/4; %% adjusts the cameraman
%image to be in the same range; 
%adds the sine function to it, 
%and divides by 4 to produce a matrix of scaling 0-1
cpf=fftshift(fft2(cp));
fftshow(cpf), impixelinfo
[x,y]=meshgrid(-128:127,-128:127); %% A matrix of distances
z=sqrt(x.^2+y.^2);
z(156,170) %% distance of 2 spikes from centre 49
z(102,88) 

%% Method 1 Band reject
br = (z < 47 | z > 51); % reject band of frequencies around spikes
cpfbr=cpf.*br;
figure
subplot(1,2,1), fftshow(cpfbr);
subplot(1,2,2), fftshow((ifft2(cpfbr)));


%% Method 2 notch filter 
% make the rows and columns of the spikes zero:
cpf(156,:)=0;
cpf(102,:)=0;
cpf(:,170)=0;
cpf(:,88)=0;
figure
subplot(1,2,1), fftshow(cpf);
subplot(1,2,2), fftshow((ifft2(cpf)));
% Making more rows and columns of the transform zero would result in a larger reduction of noise.


%% Method 3 put 0 at noise freq
[x, y]= meshgrid(1:sz(1),1:sz(2));
n = 5; % number of cycles
%%% x-direction
Wx = max(max(x)); %Length of signal (x) (ncols)
fx = n/Wx; 
px = sin(2*pi*fx*x)+1;
cm_noisy = mat2gray((im2double(cm)+px));
showImages({cm,px, cm_noisy})

%% Fourier Transform
freqImageOriginal = fftshift(fft2(cm));
magImageOriginal = log(abs(freqImageOriginal));
freqImageNoisy = fftshift(fft2(cm_noisy));
magImageNoisy = log(abs(freqImageNoisy));
showImages({magImageOriginal,magImageNoisy}), impixelinfo
figure,surf(abs(freqImageNoisy),'EdgeColor','none');

%% Filtering in Fourier Domain
%%% Mask
mask = ones(size(magImageNoisy));
mask(129,134) = 0;
mask(129,124) = 0;
figure,imshow(mask);
filtered = mask.*freqImageNoisy;
amplitudeImage = log(abs(filtered));
filteredImage = ifft2(ifftshift(filtered));
ampFilteredImage = abs(filteredImage);
minValue = min(min(ampFilteredImage));
maxValue = max(max(ampFilteredImage));
figure,imshow(ampFilteredImage, [minValue maxValue]);