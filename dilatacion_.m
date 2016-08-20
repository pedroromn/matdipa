%-----------------------------------------------------------------------
%                   UNIVERSIDAD DEL MAGDALENA
%               PROCESAMIENTO DIGITAL DE IMÁGENES
%               OPERACIÓN MORFOLÓGICA : DILATACIÓN
%
%   Integrantes:
%   + Pedro Elías Romero Nieto   
%   + Jonatan David Caraballo Henriquez
%
%   Función dilatacion_ :
%   
%   Descripción: 
%-----------------------------------------------------------------------

function imd = dilatacion_(im,filtro)

% if isrgb(im)
%     im = rgb_to_gray(im);
% end

[i j] = size(im);

img = im;

% img = zeros(i,j);

% for x = 1:i
%     for y = 1:j
%         img(x,y) = 255;
%     end
% end

[fi fj] = size(filtro);

for m = 1 + fix(fi/2) : i - fix(fi/2)
    for n = 1 + fix(fi/2) : j - fix(fj/2)
        yi = m - floor(fi/2);
        yf = m + floor(fi/2);
        xi = n  - floor(fj/2);
        xf = n + floor(fj/2) ;
        vecindad = im(yi:yf,xi:xf);
        img(m,n) = productoMaximo(vecindad,filtro);
    end
end

imd = img;
imd = uint8(imd);

end

function maximo = productoMaximo(V,F)

    V = double(V);
    F = double(F);
    [f c] = size(F);
    
    maximo = -1;
    
    for i = 1:f
        for j = 1:c
            if F(i,j) ~= 0
                aux = V(i,j)*F(i,j);
                if aux > maximo
                    maximo = aux;
                end
            end
        end
    end
    
end