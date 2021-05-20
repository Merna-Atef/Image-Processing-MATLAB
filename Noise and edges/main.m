% NOISE (Chapter 7)
cm = imread('cameraman.tif');
%% Salt and pepper 
cm_sp = imnoise(cm,'salt & pepper'); % default noise density d = 0.05, 5%
cm_sp20 = imnoise(cm,'salt & pepper',0.2); % corrupts 20% of its pixels
showImages({cm,cm_sp,cm_sp20})

%% Gaussian Noise
cm_g = imnoise(cm,'gaussian'); % Mean & variance default to 0 and 0.01
cm_g02 = imnoise(cm,'gaussian', 0, 0.2);
showImages({cm,cm_g,cm_g02})

%% Speckle Noise
cm_spk = imnoise(cm, 'speckle'); % Variance default to 0.05
cm_spk01 = imnoise(cm, 'speckle', 0.1);
showImages({cm,cm_spk,cm_spk01})

%% Periodic Noise
s = size(cm);
[x, y]= meshgrid(1:s(1),1:s(2));
n = 5; % number of cycles

%%% x-direction
Wx = max(max(x)); %Length of signal (x) (ncols)
fx = n/Wx;
px = sin(2*pi*fx*x)+1;
cm_pnx = mat2gray((im2double(cm)+px));
showImages({cm,px, cm_pnx})
% 
% %%% y-direction
% Wy = max(max(y)); %Length of signal (y) (nrows)
% fy = n/Wy;
% py = sin(2*pi*fy*y)+1;
% showImages({cm,py, cm_pny})
% cm_pny = mat2gray((im2double(cm)+py));
% 
% %%% xy
% nxy = 1; 
% fx = nxy/Wx;
% fy = nxy/Wy;
% pxy = sin(2*pi*fx*x + 2*pi*fy*y)+1; 
% % Effective frequency is root(sqr(fx)+sqr(fy))
% % Effective period = 1/eff_freq = 181 pixels --> half diagonal of image,
% % giving 2 cycles at an angle of 45 degrees --> arctan(y/x)
% cm_pnxy = mat2gray((im2double(cm)+pxy));
% pxy2 = sin(3*2*pi*fx*x + sqrt(3)*2*pi*fy*y)+1; % arctan(y/x) = 30 degrees
% cm_pnxy2 = mat2gray((im2double(cm)+pxy2));
% showImages({cm, pxy, cm_pnxy, pxy2, cm_pnxy2})
% % number of cycles differed coz eff_freq is different

%% Noise removal
%%% Salt & pepper 
%%%% Average
cm_sp = imnoise(cm,'salt & pepper');
av = fspecial('average');
cm_sp_av = filter2(av,cm_sp);
showImages({cm_sp, mat2gray(cm_sp_av,[0,255])})

av7 = fspecial('average',7);
cm_sp_av7 = filter2(av7,cm_sp);
showImages({cm_sp, mat2gray(cm_sp_av7,[0,255])})

%%%%% Median
cm_sp_med = medfilt2(cm_sp);
showImages({cm_sp, cm_sp_med})

cm_sp2=imnoise(cm,'salt & pepper',0.2);
cm_sp_med3 = medfilt2(cm_sp2);
cm_sp_med5 = medfilt2(cm_sp2, [5,5]);
showImages({cm_sp2, cm_sp_med3, cm_sp_med5})

%%%% Outlier filtering
cm_sp=imnoise(cm,'salt & pepper',0.1);
cm_sp_out_2 = outlier(cm_sp, 0.2);
cm_sp_out_4 = outlier(cm_sp, 0.4);

%%% Gaussian Noise
%%%% Averaging Copies
s = size(cm);
% Create different versions of original image with gaussian noise
cm_ga10 = zeros(s(1),s(2),10);
for i=1:10
    cm_ga10(:,:,i)= imnoise(cm,'gaussian'); % calls randn (creates normally distributed random numbers)
end
cm_ga10_av=mean(cm_ga10,3); % taking average along 3d dimension representing number of noisy copies

cm_ga100 = zeros(s(1),s(2),100);
for i=1:100
    cm_ga100(:,:,i)= imnoise(cm,'gaussian');
end
cm_ga100_av=mean(cm_ga100,3);
showImages({mat2gray(cm_ga10(:,:,1),[0,255]), mat2gray(cm_ga10_av,[0,255]), mat2gray(cm_ga100_av,[0,255])})

%%%% Average Filtering
av3=fspecial('average');
av5=fspecial('average',[5,5]);
cm_g_av3=filter2(av3,cm_ga10(:,:,1));
cm_g_av5=filter2(av5,cm_ga10(:,:,1));
showImages({mat2gray(cm_ga10(:,:,1),[0,255]), mat2gray(cm_g_av3,[0,255]), mat2gray(cm_g_av5,[0,255])})

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% EDGES (Chapter 8)
circuit=imread('circuit.tif');

%% Prewitt
px=[-1 0 1;-1 0 1;-1 0 1];
cirx=filter2(px,circuit);

py=px';
ciry=filter2(py,circuit);
showImages({cirx/255,ciry/255})

edge_p=sqrt(cirx.^2+ciry.^2);
figure,imshow(edge_p/255)

edge_t=imbinarize(edge_p/255,0.3); %% above 0.3 turn to 1, below turn to 0 
edge_pf=edge(circuit,'prewitt');
showImages({edge_t,edge_pf})

%% Roberts, Sobel
edge_r=edge(circuit,'roberts');
edge_s=edge(circuit,'sobel');
showImages({edge_r,edge_s})

%% Laplacian
lap=fspecial('laplacian',0);
circ_lap=filter2(lap,circuit);
figure,imshow(circ_lap/50)

%% LoG
LoG = fspecial('log',13,2);
circ_log = filter2(LoG,circuit);
LoGe = edge(circuit,'log');

showImages({mat2gray(circ_log, [0,1]),LoGe})

%% Unsharp masking/ edge enhancement
x = cm;
f=fspecial('average');
xf=filter2(f,x);
xu=double(x)-xf/1.5;
showImages({x,(xu/70)})

u=fspecial('unsharp',0.5);
cmu=filter2(u,cm);
showImages({cm,cmu/255})

% %% Sharpening From Lecture Last Slide
% ga=fspecial('average',[5,5]);
% cm_smooth = filter2(ga,cm);
% detail = double(cm) - cm_smooth;
% sharp = double(cm) + detail;
% showImages({cm,cm_smooth/255,detail/255})
% showImages({cm,detail/255,sharp/255})


