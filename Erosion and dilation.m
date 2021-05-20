%% Question 1

%% Erosion
A1 = [0 0 0 0 0 0 0 0 
0 0 0 1 1 1 1 0 
0 0 0 1 1 1 1 0 
0 1 1 1 1 1 1 0
0 1 1 1 1 1 1 0
0 1 1 1 1 0 0 0
0 1 1 1 1 0 0 0
0 0 0 0 0 0 0 0];


B1 = [0,1,0;
     1,1,1;
     0,1,0];
 
Ap = padarray(A1,[1,1],0,'both'); %%Pad by 1 row and 1 column at start and end with 0
C1 = imerode(Ap,B1);
C1 = C1(2:end-1,2:end-1); %%Unpad

B3 = [1,0,0;
      0,0,0;
      0,0,1];

Ap = padarray(A1,[1,1],0,'both'); %%Pad by 1 row and 1 column at start and end with 0
C3 = imerode(Ap,B3);
C3 = C3(2:end-1,2:end-1); %%Unpad

%% Dilation
A2 = [
0 0 0 0 0 0 0 0 
0 1 1 1 1 1 1 0 
0 1 1 1 1 1 1 0 
0 1 1 0 0 1 1 0 
0 1 1 0 0 1 1 0 
0 1 1 1 1 1 1 0 
0 1 1 1 1 1 1 0 
0 0 0 0 0 0 0 0 ];

D1 = imdilate(A2,B1);

Ap = padarray(A2,[1,1],0,'both'); %%Pad by 1 row and 1 column at start and end with 0
D2 = imdilate(Ap,B3);
D2 = D2(2:end-1,2:end-1); %%Unpad

%% Opening
A3 = [
    0 0 0 0 0 0 0 0
    0 0 0 0 0 1 1 0
    0 1 1 1 0 1 1 0
    0 1 1 1 0 1 1 0
    0 1 1 1 0 1 1 0
    0 1 1 1 0 0 0 0
    0 1 1 1 0 0 0 0
    0 0 0 0 0 0 0 0 ];

O1 = imopen(A3,B1);

Ap = padarray(A3,[1,1],0,'both'); %%Pad by 1 row and 1 column at start and end with 0
O2 = imopen(Ap, B3);
O2 = O2(2:end-1,2:end-1); %%Unpad

%% Closing
C1 = imclose(A1, B1);

Ap = padarray(A3,[1,1],0,'both'); %%Pad by 1 row and 1 column at start and end with 0
C2 = imclose(Ap, B3);
C2 = C2(2:end-1,2:end-1); %%Unpad

%% Question 2

circuit = imread('circbw.tif');
circ = imread('circles.png');
logo = imread('logo.tif');
t = imread('testpat1.png');

% Square
SE_sq = strel('square',3);
figure
subplot(2,4,1), imshow(circuit)
subplot(2,4,2), imshow(circ)
subplot(2,4,3), imshow(logo)
subplot(2,4,4), imshow(t)
subplot(2,4,5), imshow(imerode(circuit,SE_sq))
subplot(2,4,6), imshow(imerode(circ,SE_sq))
subplot(2,4,7), imshow(imerode(logo,SE_sq))
subplot(2,4,8), imshow(imerode(t,SE_sq))


% Cross
nhood = B1; 
SE_cr = strel(nhood);
figure
subplot(2,4,1), imshow(circuit)
subplot(2,4,2), imshow(circ)
subplot(2,4,3), imshow(logo)
subplot(2,4,4), imshow(t)
subplot(2,4,5), imshow(imerode(circuit,SE_cr))
subplot(2,4,6), imshow(imerode(circ,SE_cr))
subplot(2,4,7), imshow(imerode(logo,SE_cr))
subplot(2,4,8), imshow(imerode(t,SE_cr))

%% Hit or Miss
text = imread('text.png');
B1 = ones(11,3); % Find vertical line
B2 = padarray(~B1,[1,1],1,'both');
tb1 = imerode(text, B1);
tb2 = imerode(~text, B2);
hmt = tb1&tb2;
figure, imshow(text)
figure,imshow(hmt)