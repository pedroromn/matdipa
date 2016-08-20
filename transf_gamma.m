%-----------------------------------------------------------------------
%                   UNIVERSIDAD DEL MAGDALENA
%               PROCESAMIENTO DIGITAL DE IMÁGENES
%            TRANSFORMACIÓN GAMMA DE UNA IMAGEN DIGITAL
%
%   Integrantes:
%   + Pedro Elías Romero Nieto   
%   + Jonatan David Caraballo Henriquez
%
%   Función transf_gamma : recibe como parámetro una imagen digital.
%   
%   Descripción: 
%-----------------------------------------------------------------------

function [im nim] = transf_gamma(im,varargin)

%clc;

argc = length(varargin);

if argc == 0
    fprintf('Cantidad de argumentos : %d\n',argc);
    fprintf('La funcion transf_gamma recibe 2 o 3 argumentos \n');
    
elseif argc == 1
    g = double(varargin{1});
    
    if g > 0
        
        if isrgb(im)
            im = rgb_to_gray(im);
        end

        [f,c] = size(im);

        I = uint8(0:255);
        N = zeros(1,256);
        NIM = zeros(1,256);

        nim = zeros(f,c);
        
        if g < 1 
            for x = 1:f
                for y = 1:c
                    nim(x,y) = round(double(im(x,y)).^g);
                    if nim(x,y) > 255
                        nim(x,y) = 255;
                    end
                end
            end
        elseif g > 1
          for x = 1:f
            for y = 1:c
                nim(x,y) = double(im(x,y)).^g;
                if nim(x,y) > 255
                    nim(x,y) = 255;
                end
            end
          end
        elseif g == 1
            for x = 1:f
                for y = 1:c
                    nim(x,y) = im(x,y);
                end
            end
        end
        
        nim = uint8(nim);
        im = uint8(im);

        for x = 1:f
            for y = 1:c
                g = nim(x,y);
                p = im(x,y);
                NIM(g+1) = NIM(g+1) + 1;
                N(p+1) = N(p+1) + 1;
            end
        end

        im = double(im);
        nim = double(nim);

        %----------------------------------------------------------------------
        %----------------------------------------------------------------------
        %   DATOS ESTADISTICOS DE LA IMAGEN MODIFICADA
        %----------------------------------------------------------------------
        max_ec = max(max(nim));
        min_ec = min(min(nim));
        media_ec = mean2(nim);
        std_ec = std2(nim);
        moda_ec = max(NIM);


        %----------------------------------------------------------------------
        %----------------------------------------------------------------------
        %   DATOS ESTADISTICOS DE LA IMAGEN ORIGINAL
        %----------------------------------------------------------------------
        max_ori = max(max(im));
        min_ori = min(min(im));
        media_ori = mean2(im);
        std_ori = std2(im);
        moda_ori = max(N);

        %----------------------------------------------------------------------
        imoda_ec = 0;
        imoda_ori = 0;
        %----------------------------------------------------------------------

        for k = 1:256
            if NIM(k) == moda_ec
                imoda_ec = k-1;
            end
            if N(k) == moda_ori
                imoda_ori = k-1;
            end
        end

        %----------------------------------------------------------------------

        im = double(im);


        sim = 0;
        snim = 0;

        for x = 1:f
            for y = 1:c
                sim = (im(x,y)-media_ori).^2 + sim;
                snim = (nim(x,y)-media_ec).^2 + snim;
            end
        end


        %----------------------------------------------------------------------
        %----------------------------------------------------------------------
        %   VARIANZAS DE LAS IMAGENES
        %----------------------------------------------------------------------

        M = f.*c;
        
        varianza_ori = sim./M ;
        varianza_ec = snim./M ;

        %----------------------------------------------------------------------

        fprintf('\n\n');

        fprintf('Estadisticas de las Imagenes: \n\n');
        fprintf('Cantidad de pixeles: %d\n',M);
        fprintf('maximo_original: %d        minimo_original: %d\n',max_ori,min_ori);
        fprintf('maximo_gamma: %d        minimo_gamma: %d\n',max_ec,min_ec);
        fprintf('media_original: %.3f        media_gamma: %.3f\n',media_ori,media_ec);
        fprintf('varianza_original: %.3f        varianza_gamma: %.3f\n',varianza_ori,varianza_ec);
        fprintf('std_original: %.3f        std_gamma: %.3f\n',std_ori,std_ec);
        fprintf('moda_original: %d (%d)        media_gamma: %d (%d)\n',imoda_ori,moda_ori,imoda_ec,moda_ec);

        fprintf('\n\n');



        im = uint8(im);
        nim = uint8(nim);


        subplot(2,2,1), subimage(im), title('Imagen original');
        subplot(2,2,2), subimage(nim), title('Imagen modificada');
        subplot(2,2,3), plot(I,N), title('Histograma original'),axis([0,255,0,moda_ori+500]),xlabel('Nivel de Intensidad'), ylabel('Frecuencia');
        subplot(2,2,4), plot(I,NIM), title('Histograma modificada'),axis([0,255,0,moda_ec+500]),xlabel('Nivel de Intensidad'), ylabel('Frecuencia');
        
        
    end
elseif argc == 2
    
    g = double(varargin{1});
    d = double(varargin{2});
    %
    if g > 0 && d > 0
        
        if isrgb(im)
            im = rgb_to_gray(im);
        end

        [f,c] = size(im);

        I = uint8(0:255);
        N = zeros(1,256);
        NIM = zeros(1,256);

        nim = zeros(f,c);
        im = double(im);
        
        if g < 1 
            for x = 1:f
                for y = 1:c
                    nim(x,y) = d.*round(double(im(x,y)).^g);
                    if nim(x,y) > 255
                        nim(x,y) = 255;
                    end
                end
            end
        elseif g > 1
          for x = 1:f
            for y = 1:c
                nim(x,y) = d.*double(im(x,y)).^g;
                if nim(x,y) > 255
                    nim(x,y) = 255;
                end
            end
          end
        elseif g == 1
            for x = 1:f
                for y = 1:c
                    nim(x,y) = d.*double(im(x,y));
                    if nim(x,y) > 255
                        nim(x,y) = 255;
                    end
                end
            end
        end
    end
    
    nim = uint8(nim);
    im = uint8(im);
    
    for x = 1:f
        for y = 1:c
            g = nim(x,y);
            p = im(x,y);
            NIM(g+1) = NIM(g+1) + 1;
            N(p+1) = N(p+1) + 1;
        end
    end
    
    im = double(im);
    nim = double(nim);
    
    %----------------------------------------------------------------------
    %----------------------------------------------------------------------
    %   DATOS ESTADISTICOS DE LA IMAGEN MODIFICADA
    %----------------------------------------------------------------------
    max_ec = max(max(nim));
    min_ec = min(min(nim));
    media_ec = mean2(nim);
    std_ec = std2(nim);
    moda_ec = max(NIM);


    %----------------------------------------------------------------------
    %----------------------------------------------------------------------
    %   DATOS ESTADISTICOS DE LA IMAGEN ORIGINAL
    %----------------------------------------------------------------------
    max_ori = max(max(im));
    min_ori = min(min(im));
    media_ori = mean2(im);
    std_ori = std2(im);
    moda_ori = max(N);

    %----------------------------------------------------------------------
    imoda_ec = 0;
    imoda_ori = 0;
    %----------------------------------------------------------------------

    for k = 1:256
        if NIM(k) == moda_ec
            imoda_ec = k-1;
        end
        if N(k) == moda_ori
            imoda_ori = k-1;
        end
    end

    %----------------------------------------------------------------------

    im = double(im);


    sim = 0;
    snim = 0;

    for x = 1:f
        for y = 1:c
            sim = (im(x,y)-media_ori).^2 + sim;
            snim = (nim(x,y)-media_ec).^2 + snim;
        end
    end


    %----------------------------------------------------------------------
    %----------------------------------------------------------------------
    %   VARIANZAS DE LAS IMAGENES
    %----------------------------------------------------------------------
    
    M = f.*c;
    varianza_ori = sim./M ;
    varianza_ec = snim./M ;

    %----------------------------------------------------------------------

    fprintf('\n\n');

    fprintf('Estadisticas de las Imagenes: \n\n');
    fprintf('Cantidad de pixeles: %d\n',M);
    fprintf('maximo_original: %d        minimo_original: %d\n',max_ori,min_ori);
    fprintf('maximo_ecualizada: %d        minimo_ecualizada: %d\n',max_ec,min_ec);
    fprintf('media_original: %.3f        media_ecualizada: %.3f\n',media_ori,media_ec);
    fprintf('varianza_original: %.3f        varianza_ecualizada: %.3f\n',varianza_ori,varianza_ec);
    fprintf('std_original: %.3f        std_ecualizada: %.3f\n',std_ori,std_ec);
    fprintf('moda_original: %d (%d)        media_ecualizada: %d (%d)\n',imoda_ori,moda_ori,imoda_ec,moda_ec);

    fprintf('\n\n');



    im = uint8(im);
    nim = uint8(nim);


    subplot(2,2,1), subimage(im), title('Imagen original');
    subplot(2,2,2), subimage(nim), title('Imagen modificada');
    subplot(2,2,3), plot(I,N), title('Histograma original'),axis([0,255,0,moda_ori+500]),xlabel('Nivel de Intensidad'), ylabel('Frecuencia');
    subplot(2,2,4), plot(I,NIM), title('Histograma modificada'),axis([0,255,0,moda_ec+500]),xlabel('Nivel de Intensidad'), ylabel('Frecuencia');
    
    
    
    
    
    
end
         



    


