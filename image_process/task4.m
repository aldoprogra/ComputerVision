
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
subplot(2, 2, 3), imagesc(log(abs(fftshift(fft2(img))))),colormap gray,title('Log Magnitude Original');
subplot(2, 2, 4),imagesc(log(abs(fftshift(fft2(img_identity))))), colormap gray,title('Log Magnitude Identity');




% Shift left 

A = [0 0 0 0 0 0 0; 0 0 0 0 0 0 0; 0 0 0 0 0 0 0; 0 0 0 0 0 0 1; 0 0 0 0 0 0 0; 0 0 0 0 0 0 0; 0 0 0 0 0 0 0];
img_shift = conv2(double(img),A, 'same');
figure;
subplot(2, 2, 1), imagesc(img), colormap gray, title('Original image');
subplot(2, 2, 2), imagesc(img_shift), colormap gray, title('Shift image');
subplot(2, 2, 3), imagesc(log(abs(fftshift(fft2(img))))),colormap gray,title('Log Magnitude Original');
subplot(2, 2, 4),imagesc(log(abs(fftshift(fft2(img_shift))))), colormap gray,title('Log Magnitude Shift');


% Blurred

A = ones(7)/49;
img_blur = conv2(img, A, 'same');
figure;
subplot(2, 2, 1), imagesc(img), colormap gray, title('Original image');
subplot(2, 2, 2), imagesc(img_blur), colormap gray, title('Blurred image');
subplot(2, 2, 3), imagesc(log(abs(fftshift(fft2(img))))),colormap gray,title('Log Magnitude Original');
subplot(2, 2, 4),imagesc(log(abs(fftshift(fft2(img_blur))))), colormap gray,title('Log Magnitude Blurred');




% Sharpening

A =( [0 0 0 0 0 0 0; 0 0 0 0 0 0 0; 0 0 0 0 0 0 0; 0 0 0 2 0 0 0; 0 0 0 0 0 0 0; 0 0 0 0 0 0 0; 0 0 0 0 0 0 0] - ones(7)/49);
img_sharp = conv2(img, A, 'same');
figure;
subplot(2, 2, 1), imagesc(img), colormap gray, title('Original image');
subplot(2, 2, 2), imagesc(img_sharp), colormap gray, title('Sharpened image');
subplot(2, 2, 3), imagesc(log(abs(fftshift(fft2(img))))),colormap gray,title('Log Magnitude Original');
subplot(2, 2, 4),imagesc(log(abs(fftshift(fft2(img_sharp))))), colormap gray,title('Log Magnitude Sharpened');

% Detail

smooth = img_blur;
detail = double(img) - img_blur;
figure;
subplot(2, 2, 1), imagesc(img), colormap gray, title('Original image');
subplot(2, 2, 2), imagesc(detail), colormap gray, title('Detailed image');
subplot(2, 2, 3), imagesc(log(abs(fftshift(fft2(img))))),colormap gray,title('Log Magnitude Original');
subplot(2, 2, 4),imagesc(log(abs(fftshift(fft2(detail))))), colormap gray,title('Log Magnitude Detailed');

% Gaussian filter to the 101x101 pixels with sigma 5
G_101 = filter2(fspecial('gaussian',101,5),img)/255;
FZ_2=fftshift(fft2(Kgaussian_101));
figure;
subplot(2, 2, 1), imagesc(img), colormap gray, title('Original image');
subplot(2, 2, 2), imagesc(G_101), colormap gray, title('Gaussian 101 filtered image');
subplot(2, 2, 3), imagesc(log(abs(fftshift(fft2(img))))),colormap gray,title('Log Magnitude Original');
subplot(2, 2, 4), imagesc(log(abs(FZ_2))), colormap gray,title('Log Magnitude Gaussian 101 ');


% FFT using for the sharpened image

K_1 = zeros(7);
K_1(4,4) = 1;
K_2 = ones(7)/49;
K_sharpened = conv2(double(img), (K_1 + K_1 - K_2), 'same');
FZ_3=fftshift(fft2(K_sharpened));

figure;

subplot(1, 2, 1), imagesc(K_sharpened),colormap gray,title('Sharpened image');
subplot(1, 2, 2), imagesc((abs(FZ_3))),colormap gray,title('Log Magnitude');