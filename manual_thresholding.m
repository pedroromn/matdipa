function [bw] = manual_thresholding(image, th)
    bw = zeros(size(image));
    mask = image > th;
    bw(mask) = 1;
    bw = logical(bw);
end