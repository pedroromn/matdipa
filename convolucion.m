function img = convolucion(im,filtro)

% if isrgb(im)
%     im = rgb_to_gray(im);
% end

[i j] = size(im);
B = zeros(i,j);
[filtro_i filtro_j] = size(filtro);

for m = 1 + round(filtro_i/2) : i - round(filtro_i/2)
    for n = 1 + round(filtro_j/2) : j - round(filtro_j/2)
        desde_h  = m - floor(filtro_i/2);
        hasta_h = m + floor(filtro_i/2);
        desde_w = n - floor(filtro_j/2);
        hasta_w = n + floor(filtro_j/2) ;
        vecinos = im(desde_h:hasta_h,desde_w:hasta_w);
        B(m,n) = suma(vecinos,filtro);
    end
end

img = B;
img = uint8(img);

end

function s = suma (A,B)
A=uint8(A);
B=uint8(B);
s=sum(sum(A.*B));
end