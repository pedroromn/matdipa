A = imread('~/dsipimg/trui.png'); % Read in image
PSF = fspecial('gaussian', [5 5], 2); % Define Gaussian convolution kernel
h = fspecial('motion', 10, 45);
B = conv2(double(PSF),double(A));
C = imfilter(A,h,'replicate');
D = conv2(double(A),double(A));

subplot(2,2,1), imshow(A);
subplot(2,2,2), imshow(B,[]);
subplot(2,2,3), imshow(C,[]);
subplot(2,2,4), imshow(D,[]);