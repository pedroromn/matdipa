%-----------------------------------------------------------------------
%                   UNIVERSIDAD DEL MAGDALENA
%               PROCESAMIENTO DIGITAL DE IMÁGENES
%                OPERACIÓN MORFOLÓGICA : EROSIÓN
%
%   Integrantes:
%   + Pedro Elías Romero Nieto   
%   + Jonatan David Caraballo Henriquez
%
%   Función erosion_ :
%   
%   Descripción: 
%-----------------------------------------------------------------------


function ime = erosion_(im,filtro)

% if isrgb(im)
%     im = rgb_to_gray(im);
% end

[i j] = size(im);

img = im;
% img = zeros(i,j);

[fi fj] = size(filtro);

for m = 1+ fix(fi/2) : i - fix(fi/2)
    for n = 1+ fix(fi/2) : j - fix(fj/2)
        yi = m - floor(fi/2);
        yf = m + floor(fi/2);
        xi = n  - floor(fj/2);
        xf = n + floor(fj/2) ;
        vecindad = im(yi:yf,xi:xf);
        img(m,n) = productoMinimo(vecindad,filtro);
    end
end

ime = img;
ime = uint8(ime);

end

function minimo = productoMinimo(V,F)

    V = double(V);
    F = double(F);
    [f c] = size(F);
    minimo = 1000;
    
    for i = 1:f
        for j = 1:c
            if F(i,j) ~= 0
                aux = V(i,j)*F(i,j);
                if aux < minimo
                    minimo = aux;
                end
            end
        end
    end
    
end