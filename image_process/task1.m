% Load an image
img_o = imread('boccadasse.jpg');
img = rgb2gray(img_o);


% Gaussian noise
out_n = double(img)+20*randn(size(img)); % 20 is the standard deviation
a_n = randn(1,100);

% Salt and pepper noise
img = double(img);
[rr,cc] = size(img);
maxv = max(max(img));
indices = full(sprand(rr,cc,0.2));  % 20% is the noise density
mask1 = indices>0 & indices<0.5;  
mask2 = indices>=0.5; 
out = img.*(~mask1) ;
out = out.*(~mask2)+maxv*mask2;

figure;
subplot(3, 2, 1), imagesc(img_o), title('Original Image');
subplot(3, 2, 2), histogram(img_o), title('Histogram of Original Image');
subplot(3, 2, 3), imagesc(out_n),colormap gray,title('Gaussian noise');
subplot(3, 2, 4), histogram(out_n), title('Histogram of image with Gaussian noise');
subplot(3, 2, 5), imagesc(out),colormap gray, title('Salt-pepper image');
subplot(3, 2, 6), histogram(out), title('Histogram of image with Salt-pepper');
