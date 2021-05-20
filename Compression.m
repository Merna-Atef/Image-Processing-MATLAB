% Tutorial 10
%% Huffman Coding
symbols = [0,1,2,3,4,5,6,7];
prob = [0.19,0.25,0.21,0.16,0.08,0.06,0.03,0.02];
dic = huffmandict(symbols,prob); % construct huffman tree and create a dictionary
% dictionary is different from ours coz it uses a different algorithm

image = imread('cameraman.tif');
info = whos('image');
before = info.class; % uint8, 8 bits/pixel
[ns, symbols] = imhist(image);
prob = ns/size(image(:),1); % divide n pixels by MxN
[dic, avgLen] = huffmandict(symbols,prob); 
% construct huffman tree and create a dictionary, avgLen: avg no. of bits/level
C = 8/avgLen
compressed = huffmanenco(image(:),dic); % takes a vector, image(:) takes it column by cokumn
imgdecoded = huffmandeco(compressed,dic);% decoding the image using Huffman decoding procedure
reshaped_img = reshape(imgdecoded,256,256);% converting 1D vector to 2 D image array or reshaping

isequal(image,reshaped_img) % lossless compression



