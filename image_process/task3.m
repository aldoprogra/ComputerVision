
% Load an image
img_o = imread('boccadasse.jpg');
img = rgb2gray(img_o);
[x,y]= meshgrid(1:size(img,2),size(img,1):-1:1);



% Identity

A = [0 0 0 0 0 0 0; 0 0 0 0 0 0 0; 0 0 0 0 0 0 0; 0 0 0 1 0 0 0; 0 0 0 0 0 0 0; 0 0 0 0 0 0 0; 0 0 0 0 0 0 0];

img_identity = conv2(double(img),A, 'same');
figure;
subplot(2, 2, 1), imagesc(img), colormap gray, title('Original image');
subplot(2, 2, 2), imagesc(img_identity), colormap gray, title('Identity image');
subplot(2, 2, 3), surf(x,y,img,'EdgeColor','none');
subplot(2, 2, 4), surf(x,y,img_identity,'EdgeColor','none');




% Shift left 

A = [0 0 0 0 0 0 0; 0 0 0 0 0 0 0; 0 0 0 0 0 0 0; 0 0 0 0 0 0 1; 0 0 0 0 0 0 0; 0 0 0 0 0 0 0; 0 0 0 0 0 0 0];
img_shift = conv2(double(img),A, 'same');
figure;
subplot(2, 2, 1), imagesc(img), colormap gray, title('Original image');
subplot(2, 2, 2), imagesc(img_shift), colormap gray, title('Shifted image');
subplot(2, 2, 3), surf(x,y,img,'EdgeColor','none');
subplot(2, 2, 4), surf(x,y,img_shift,'EdgeColor','none');


% Blurred

A = ones(7)/49;
img_blur = conv2(img, A, 'same');
figure;
subplot(2, 2, 1), imagesc(img), colormap gray, title('Original image');
subplot(2, 2, 2), imagesc(img_blur), colormap gray, title('Blurred image');
subplot(2, 2, 3), surf(x,y,img,'EdgeColor','none');
subplot(2, 2, 4), surf(x,y,img_blur,'EdgeColor','none');


% Sharpening

A =( [0 0 0 0 0 0 0; 0 0 0 0 0 0 0; 0 0 0 0 0 0 0; 0 0 0 2 0 0 0; 0 0 0 0 0 0 0; 0 0 0 0 0 0 0; 0 0 0 0 0 0 0] - ones(7)/49);
img_sharp = conv2(img, A, 'same');
figure;
subplot(2, 2, 1), imagesc(img), colormap gray, title('Original image');
subplot(2, 2, 2), imagesc(img_sharp), colormap gray, title('Sharped image ');
subplot(2, 2, 3), surf(x,y,img,'EdgeColor','none');
subplot(2, 2, 4), surf(x,y,img_sharp,'EdgeColor','none');

% Detail

smooth = img_blur;
detail = double(img) - img_blur;
figure;
subplot(2, 2, 1), imagesc(img), colormap gray, title('Original image');
subplot(2, 2, 2), imagesc(detail), colormap gray, title('Detailed image (pg 45)');
subplot(2, 2, 3), surf(x,y,img,'EdgeColor','none');
subplot(2, 2, 4), surf(x,y,detail,'EdgeColor','none');

% Sharpened

a = 1;
sharpened = (double(img) + a * detail);
figure;
subplot(2, 2, 1), imagesc(img), colormap gray, title('Original image');
subplot(2, 2, 2), imagesc(sharpened), colormap gray, title('Sharpened image (pg 45)');
subplot(2, 2, 3), surf(x,y,img,'EdgeColor','none');
subplot(2, 2, 4), surf(x,y,sharpened,'EdgeColor','none');

