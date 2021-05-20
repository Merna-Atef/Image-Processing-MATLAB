function showImages(images)
%showImages Display images in a figure
%   Takes a number of images (nCol) placed in a cell array of size 1 x
%   nCol. And loops over images and displays them all in a single figure.
nCol = size(images,2);
figure
for iCol = 1:nCol
subplot(1,nCol,iCol)
imshow(images{1,iCol})
end
end

%%%%%%%% Cell array
% A cell array is a data type with indexed data containers called cells, 
% where each cell can contain any type of data. 
% Cell arrays commonly contain either lists of text, combinations of text 
% and numbers, or numeric arrays of different sizes. 
% Refer to sets of cells by enclosing indices in smooth parentheses, (). 
% Access the contents of cells by indexing with curly braces, {}.
