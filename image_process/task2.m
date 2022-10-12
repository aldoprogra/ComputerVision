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

% Every filter tested for both gaussian and saltpepper noise

% Linear Filter 3x3
K=ones(3)/9;
outsl1=conv2(out,K,'same');
outgl1 = conv2(out_n,K,'same');

% Linear Filter 7x7
K=ones(7)/49;
outsl2=conv2(out,K,'same');
outgl2 = conv2(out,K,'same');

%  Median filter 3x3
outsm1=medfilt2(out,[3,3]); 
outgm1=medfilt2(out_n,[3,3]);

%  Median filter 7x7
outms2=medfilt2(out,[7,7]);
outmg2=medfilt2(out_n,[7,7]);

% Gaussian low pass filter 3x3
gauss1= filter2(fspecial('gaussian',3),out)/255;
gaussg2 = filter2(fspecial('gaussian',3),out_n)/255;

% Gaussian low pass filter 7x7
gaussg1= filter2(fspecial('gaussian',7),out_n)/255;
gauss2 = filter2(fspecial('gaussian',7),out)/255;

figure;
subplot(2, 2, 1), imagesc(out_n),colormap gray,title('Gaussian noise');
subplot(2, 2, 2), imagesc(outsl1),colormap gray,title('Linear Filter 3x3');
subplot(2, 2, 3), imagesc(out),colormap gray, title('Salt-pepper noise');
subplot(2, 2, 4), imagesc(outgl1),colormap gray,title('Linear Filter 3x3');

figure;
subplot(2, 2, 1), imagesc(out_n),colormap gray,title('Gaussian noise');
subplot(2, 2, 2), imagesc(outsl2),colormap gray,title('Linear Filter 7x7');
subplot(2, 2, 3), imagesc(out),colormap gray, title('Salt-pepper noise');
subplot(2, 2, 4), imagesc(outgl2),colormap gray,title('Linear Filter 7x7');

figure;
subplot(2, 2, 1), imagesc(out_n),colormap gray,title('Gaussian noise');
subplot(2, 2, 2), imagesc(outgm1),colormap gray,title('Median filter 3x3');
subplot(2, 2, 3), imagesc(out),colormap gray, title('Salt-pepper noise');
subplot(2, 2, 4), imagesc(outsm1),colormap gray,title('Median filter 3x3');

figure;
subplot(2, 2, 1), imagesc(out_n),colormap gray,title('Gaussian noise');
subplot(2, 2, 2), imagesc(outmg2),colormap gray,title('Median filter 7x7');
subplot(2, 2, 3), imagesc(out),colormap gray, title('Salt-pepper noise');
subplot(2, 2, 4), imagesc(outms2),colormap gray,title('Median filter 7x7');

figure;
subplot(2, 2, 1), imagesc(out_n),colormap gray,title('Gaussian noise');
subplot(2, 2, 2), imagesc(gaussg1),colormap gray,title('Gaussian Filter 3x3');
subplot(2, 2, 3), imagesc(out),colormap gray, title('Salt-pepper noise');
subplot(2, 2, 4), imagesc(gauss1),colormap gray,title('Gaussian Filter 3x3');

figure;
subplot(2, 2, 1), imagesc(out_n),colormap gray,title('Gaussian noise');
subplot(2, 2, 2), imagesc(gaussg2),colormap gray,title('Gaussian Filter 7x7');
subplot(2, 2, 3), imagesc(out),colormap gray, title('Salt-pepper noise');
subplot(2, 2, 4), imagesc(gauss2),colormap gray,title('Gaussian filter 7x7');



[x,y]=meshgrid(1:cc,1:rr);

% For Semplicity I plot few plot rether than for every cases
figure;
subplot(2,3,1), surf(x,y,outsl1,'EdgeColor','none'), title('Linear 3x3 SaltPepper');
subplot(2,3,2), histogram(out), title('Histogram before');
subplot(2,3,3), histogram(outsl1), title('Histogram after');
subplot(2,3,4), surf(x,y,outsm1,'EdgeColor','none'), title('Median 3x3 SaltPepper');
subplot(2,3,5), histogram(out), title('Histogram before');
subplot(2,3,6), histogram(outsm1), title('Histogram after');