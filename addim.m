% Image Addition
P = imread('sml1.JPG');
%imshow(P, 'InitialMagnification', 25);
Q = imread('sml2.JPG');
%figure; imshow(Q, 'InitialMagnification', 25);
R = imadd(rgb2gray(P),rgb2gray(Q));
% figure; imshow(R)
% figure; imshow(R+100)
subplot(1,3,1), imshow(rgb2gray(P))
subplot(1,3,2), imshow(rgb2gray(Q))
subplot(1,3,3), imshow(R);
%imtool(R);
