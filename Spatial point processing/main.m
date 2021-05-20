%Arithmetic Operations %% Styling and comments
%% Addition and subtraction
coins = imread('coins.png'); 
coinsAdd = coins + 128; %%Naming conventions 
% Can also use imadd, imsubtract, immultiply, imdivide
coinsSub = coins - 128;
coinsCell = {coins, coinsAdd, coinsSub};
showImages(coinsCell) %%Repetitive code, put in a function
%% Multiplication and division
coinsMult = coins * 2; 
coinsDiv = coins / 2;
coinsCell = {coins, coinsMult, coinsDiv};
showImages(coinsCell)
%%Compare division and subtraction in darkening an image
coinsCell = {coins, coinsDiv, coinsSub};
showImages(coinsCell) 
%%Compare multiplication and addition in lightening an image
coinsCell = {coins, coinsAdd, coinsMult};
showImages(coinsCell)
%% Complement
xray = imread('mammogram.tif');
xrayNeg = imcomplement(xray);
xrayCell = {xray, xrayNeg};
showImages(xrayCell)
%%% Complement Part of an image
%%%% Complement Bright Areas Only
xrayNegBright = xray;
xreyBrighti = find(xray > 128);
xrayNegBright(xreyBrighti) = imcomplement(xray(xreyBrighti));
%%%% Complement Dark Areas Only
xrayNegDark = xray;
xreyDarki = find(xray < 128);
xrayNegDark(xreyDarki) = imcomplement(xray(xreyDarki));
xrayCell = {xray, xrayNeg, xrayNegBright, xrayNegDark};
showImages(xrayCell)

% Histograms
pout=imread('pout.tif'); % Poor contrast Image, shows count not probability, nI vs I
[counts, binLocations] = imhist(pout);
sz = size(pout);
MN = sz(1)*sz(2);
figure
subplot(1,2,1), imshow(pout) 
subplot(1,2,2), imhist(pout),axis tight % axes of the histogram are scaled to fit all the values in
figure, stem(binLocations,counts/MN) % display p(I) vs I
%% Contrast Stretching
pollenLowCont=imread('washed_out_pollen_image.tif');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
min = min(min(pollenLowCont));
max = max(max(pollenLowCont));
contrastStretch = imadjust(pollenLowCont, [double(min)/255, double(max)/255],[0, 1]);
threshold = pollenLowCont >= mean(pollenLowCont(:)); %Binary thresholding
showImages({pollenLowCont, contrastStretch, threshold})
%%% Gamma Value
t=imread('tire.tif');
th=imadjust(t,[],[],0.5);
showImages({t,th})
plot(t,th,'.'),axis tight
%%% a(i)=min, a(i+1)=max, b(i)=0, b(i+1)=255
pix=find(pollenLowCont > min(1) & pollenLowCont < max(1));
out = pollenLowCont;
out(pix)=(pollenLowCont(pix)-min(1))*ceil((255-0)/(double(max(1))-double(min(1))))+0;
showImages({pollenLowCont,out})
%% Thresholding
coins=imread('coins.png');
coinsSeg = coins>90; %% Vectorization, 0 and 1 (logical)
showImages({coins, coinsSeg})
showImages({coins, imbinarize(coins,0.35)}) %% above 0.35 turn to 1, below turn to 0 (90/255=0.35)
kidney = imread('kidney.tif');
seg = kidney>150 & kidney<220; %%Highlight kidney and vessels
showImages({kidney, seg})
%%%%%%%%%%%%% Or imshow(coins>90), imshow(kidney>150 & kidney<220)%%%%%%%%%%