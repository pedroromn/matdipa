%-----------------------------------------------------------------------
%                   UNIVERSIDAD DEL MAGDALENA
%               PROCESAMIENTO DIGITAL DE IM�GENES
%      TRANSFORMACI�N POR ECUALIZACI�N DEL HISTOGRAMA DE UNA IMAGEN
%                            DIGITAL
%
%   Integrantes:
%   + Pedro El�as Romero Nieto   
%   
%
%   Funci�n ecualiza : recibe como par�metro una imagen digital.
%   
%   Descripci�n: 
%   im : imagen a la que se le va a aplicar la transformaci�n
%   distri:    tipo de ecualizaci�n que se va a realizar sobre la imagen
%              son 5 tipos de ecualizaciones, seg�n la distribuci�n
%              que se piense emplear.
%
%               Distribuciones:
%               1. Uniforme
%               2. Exponencial
%               3. Rayleigh
%               4. Hiperc�bica
%               5. Logaritmo Hiperc�bica
%
%   alpha : factor empleado por algunas de las distribuciones
%           0 < alpha < 1.
% 
%   Un ejemplo donde se muestra la forma correcta de ejecutar 
%   la funci�n ecualiza, es:
% 
%   ecualiza(im,'uniforme');
%   ecualiza(im,'exponencial',0.5);
%-----------------------------------------------------------------------

function [im nim] = ecualiza(im,varargin)

%clc;

fprintf('Transformacion por Ecualizacion');

if isrgb(im)
    im = rgb_to_gray(im);
end

%    f : n�mero de filas de la matriz im
%    c : n�mero de columnas de la matriz im
[f,c] = size(im);

I = uint8(0:255);

%   N : vector que contiene la frecuencia de aparici�n de cada nivel 
%       de intensidad presente en la imagen
N = zeros(1,256);

%   P: vector que contiene la probabilidad de aparici�n de cada nivel
%      de intensidad presente en la imagen.
P = zeros(1,256);

for x = 1:f
    for y = 1:c
        g = im(x,y);
        N(g+1) = N(g+1) + 1;
    end
end

%   M : n�mero total de pixeles en la imagen
M = f.*c;

N = double(N);

NIM = zeros(1,256);

for x = 1:256
    P(x) = N(x)./ M;
end

%   PA : vector que contiene la probabilidad acumulada para cada nivel
%        de intensidad presente en la imagen.
PA = cumsum(P);

%   gmax = maximo nivel de intensidad presente en la imagen
gmax = double(max(max(im)));

%   gmin : m�nimo nivel de intensidad presente en la imagen
gmin = double(min(min(im)));

%   nim : copia de la imagen original, sobre la cual se realizar� la
%   transformaci�n

nim  = zeros(f,c);


argc = length(varargin);

if argc == 0
    fprintf('Cantidad de argumentos : %d\n',argc);
    fprintf('La funcion ecualiza recibe 2 o mas argumentos \n');
elseif argc == 1
    if ischar(varargin{1})
            switch varargin{1}
                case 'uniforme'
                    fprintf('\n\n');
                    fprintf('\nEcualizacion Uniforme en ejecucion ... \n');
                    for x = 1:f
                        for y = 1:c
                            g = im(x,y);
                            nim(x,y) = (gmax - gmin).*PA(g+1) + gmin;
                        end
                    end
                    fprintf('\nNueva imagen generada\n\n');
                 
                case 'hipercubica'
                    fprintf('\n\n');
                    fprintf('Ecualizacion Hipercubica en ejecucion ... \n');
                    for x = 1:f
                        for y = 1:c
                            g = im(x,y);
                            nim(x,y) = ((nthroot(gmax,3) - nthroot(gmin,3)).*PA(g+1) + nthroot(gmin,3)).^3;
                        end
                    end
                    fprintf('\nNueva imagen generada\n\n');
                    
                case 'loghiperc'
                    fprintf('\n\n');
                    fprintf('Ecualizacion Logaritmo Hiperbolica en ejecucion ... \n');
                    for x = 1:f
                        for y = 1:c
                            g = im(x,y);
                            nim(x,y) = gmin.*(gmax./gmin).*PA(g+1);
                        end
                    end
                    fprintf('\nNueva imagen generada\n\n');
                    
                    
                case 'exponencial'
                    fprintf('\n\n');
                    fprintf('\nEcualizacion Exponencial en ejecucion ... \n');
                    for x = 1:f
                        for y = 1:c
                            g = im(x,y);
                            nim(x,y) = gmin - log(1-PA(g+1));
                        end
                    end
                    fprintf('\nNueva imagen generada\n\n');
                
                
                case 'rayleigh'
                    fprintf('\n\n');
                        fprintf('\nEcualizacion Rayleigh en ejecucion ... \n');
                        for x = 1:f
                            for y = 1:c
                                g = im(x,y);
                                nim(x,y) = gmin + sqrt(2.*log(1./(1-PA(g+1))));
                            end
                        end
                fprintf('\nNueva imagen generada\n\n');
                    
                otherwise
                    fprintf('\n\n');
                    fprintf('Valor de argumento no valido, revisar la guia de la funcion ecualiza\n');
                    fprintf('help ecualiza\n\n');
            end
    end
elseif argc == 2
    if ischar(varargin{1}) && isnumeric(varargin{2})
        
        alpha = double(varargin{2});
        
        switch varargin{1}
            
            case 'exponencial'
                fprintf('\n\n');
                    fprintf('\nEcualizacion Exponencial en ejecucion ... \n');
                    for x = 1:f
                        for y = 1:c
                            g = im(x,y);
                            nim(x,y) = gmin - (1./alpha).*log(1-PA(g+1));
                        end
                    end
                    fprintf('\nNueva imagen generada\n\n');
                
                
            case 'rayleigh'
                fprintf('\n\n');
                    fprintf('\nEcualizacion Rayleigh en ejecucion ... \n');
                    for x = 1:f
                        for y = 1:c
                            g = im(x,y);
                            nim(x,y) = gmin + sqrt(2.*(alpha.^2).*log(1./(1-PA(g+1))));
                        end
                    end
                    fprintf('\nNueva imagen generada\n\n');
                
            otherwise
                fprintf('\n\n');
                fprintf('Valor de argumento no valido, revisar la guia de la funcion ecualiza\n');
                fprintf('help ecualiza\n\n');    
        end
    end
    
end


nim = uint8(nim);


for x = 1:f
    for y = 1:c
        g = nim(x,y);
        NIM(g+1) = NIM(g+1) + 1;
    end
end




im = double(im);
nim = double(nim);


%----------------------------------------------------------------------
%----------------------------------------------------------------------
%   DATOS ESTADISTICOS DE LA IMAGEN ECUALIZADA
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
max_ori = uint8(gmax);
min_ori = uint8(gmin);
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
subplot(2,2,2), subimage(nim), title('Imagen ecualizada');
subplot(2,2,3), plot(I,N), title('Histograma original'),axis([0,255,0,moda_ori+500]),xlabel('Nivel de Intensidad'), ylabel('Frecuencia');
subplot(2,2,4), plot(I,NIM), title('Histograma ecualizado'),axis([0,255,0,moda_ec+500]),xlabel('Nivel de Intensidad'), ylabel('Frecuencia');
    
    




    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    