% Filters (Chapter 6)
x = uint8(10 * magic(5))
m1 = mean2(x(1:3,1:3))
m2 = mean2(x(1:3,2:4))
box_flt = ones(3,3)/9
filter2(box_flt, x, 'same')
filter2(box_flt, x,'valid')
filter2(box_flt, x,'full')

%% Low pass
%%% Average
cm = imread('cameraman.tif');
avg3 = fspecial('average');
avg9 = fspecial('average', 9);
avg25 = fspecial('average', 25);
cm_avg_fltr3 = filter2(avg3, cm); %% double not image (divide by 255)
cm_avg_fltr9 = filter2(avg9, cm);
cm_avg_fltr25 = filter2(avg25, cm);
showImages({cm, cm_avg_fltr3/255, cm_avg_fltr9/255, cm_avg_fltr25/255}) 
cm_avg_fltr25v = filter2(avg25, cm,'valid');
showImages({cm_avg_fltr25/255, cm_avg_fltr25v/255});


%%% Gaussian
a=50;s=3;
g=fspecial('gaussian',[a a],s);
surf(1:a,1:a,g)
s=9;
g2=fspecial('gaussian',[a a],s);
figure,surf(1:a,1:a,g2)

g5=fspecial('gaussian',5);
g5_2=fspecial('gaussian',5,2);
g11_1=fspecial('gaussian',11,1);
g11_5=fspecial('gaussian',11,5);

cm_g5 = filter2(g5,cm);
cm_g5_2 = filter2(g5_2,cm);
cm_g11_1 = filter2(g11_1,cm);
cm_g11_5 = filter2(g11_5,cm);

showImages({cm_g5/255,cm_g5_2/255,cm_g11_1/256,cm_g11_5/255})

% Big standard deviation approximates average filter
g3100 = fspecial('gaussian',3,100)

%% High pass
%%% Laplacian
lap = fspecial('laplacian',0)
lap = fspecial('laplacian')
cm_lap = filter2(lap,cm);
showImages({cm,(cm_lap)/100})
showImages({cm,mat2gray(cm_lap, [0,255])})

%%% LoG
log = fspecial('log')
cm_log = filter2(log,cm);
showImages({cm,(cm_log)/100})
showImages({cm,mat2gray(cm_log, [0,255])})

%% Non-linear
cmax=nlfilter(cm,[3,3],'max(x(:))');
cmin=nlfilter(cm,[3,3],'min(x(:))');
showImages({cm,cmax,cmin})
% other option ordfilt2

