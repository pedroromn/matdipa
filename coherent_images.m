A = imread('~/dsipimg/cameraman.tif');
[rows, dims] = size(A);
Abuild = zeros(size(A));

% Randomly sample 1% of points and convolve with Gaussian PSF

sub = rand(rows .* dims,1) < 0.1;
Abuild(sub) = A(sub);
h = fspecial('gaussian', [5 5], 2);
C = conv2(double(h),Abuild);
B10 = filter2(h, Abuild);

subplot(1,3,1); imagesc(Abuild); axis image; axis off; colormap(gray);
title('Object Points');
subplot(1,3,2); imagesc(C); axis image; axis off; colormap(gray);
title('Conv2');
subplot(1,3,3); imagesc(B10); axis image; axis off; colormap(gray);
title('Filter2');
