function [text] = extractImageText(fname)
% [text] = extractImageText(fname) loads the image specified by the path 'fname'
% and returns the next contained in the image as a string.

im = imread(fname);
[lines, bw] = findLetters(im);
%imshow(im)

load('nist36_model_800_nodes_01lr.mat')
%load('../data/nist26_model_60iters.mat')

alphamap = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H',...
            'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',...
            'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X',...
            'Y', 'Z', '0', '1', '2', '3', '4', '5',...
            '6', '7', '8', '9'];

text="";
%figure(1)
%imshow(bw)
for i = 1:size(lines,2)
    line = lines{i};
    for j=1:size(line,1)
        box = round(line(j,:));
        %rectangle('Position',[box(1) box(2) box(3)-box(1) box(4)-box(2)], 'EdgeColor', 'r', 'Linewidth',1)
        letter = bw(box(2):box(4), box(1):box(3));
        scale = 32/max(size(letter));
        letter=imresize(letter, scale);
        xdiff = floor((32-size(letter,1))/2);
        ydiff = floor((32-size(letter,2))/2);

        letter = padarray(letter, [xdiff ydiff], 1, 'both');

        if size(letter,2)<32
            letter(:,end+1) = 1;    
        elseif size(letter,1)<32
            letter(end+1,:) = 1;    
        end
        %figure
        %imshow(letter) 
        output = Classify(W,b, letter(:)');
        [~,ind] = max(output);
        alphamap(ind);


        text =strcat(text,alphamap(ind));     
    end

end
    text


