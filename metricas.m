%-----------------------------------------------------------------------
%                   UNIVERSIDAD DEL MAGDALENA
%               PROCESAMIENTO DIGITAL DE IMÁGENES
%       CUANTIFICACIÓN DEL RUIDO O ERROR EN IMÁGENES DIGITALES
%                 MÉTRICAS DE CALIDAD DE IMAGENES
%
%   Integrantes:
%   + Pedro Elías Romero Nieto   
%   + Jonatan David Caraballo Henriquez
%
%   Función metrica_calidad : recibe como parámetro una imagen digital.
%   
%   Descripción: 
%-----------------------------------------------------------------------

function [RMSE SNR Q] = metricas(im,nim)

%clc;

[f,c] = size(im);
[fn, cn] = size(nim);

% if isrgb(im)
%     im = rgb_to_gray(im);
% end

if f == fn && c == cn

    MN = f.*c;
    im = double(im);
    nim = double(nim);

     %--------------------------------------------------------------
     %--------------------------------------------------------------
     % ERROR CUADRÁTICO MEDIO
     % MSE = suma_mse ./ MN;              
       suma_mse = 0; 
     %--------------------------------------------------------------
     %--------------------------------------------------------------
     %--------------------------------------------------------------
     %--------------------------------------------------------------
     % ERROR TOTAL      
        error_total = 0;
     %--------------------------------------------------------------
     %--------------------------------------------------------------
     % RELACIÓN SEÑAL A RUIDO
     % SNR = num_snr ./ den_snr;
     num_snr = 0;
     den_snr = 0;
     %--------------------------------------------------------------
     %--------------------------------------------------------------
     %--------------------------------------------------------------
     % DIFERENCIA MEDIA 
     % AD = sum_ad ./ MN;
        suma_ad = 0;
     %--------------------------------------------------------------
     %--------------------------------------------------------------
     %--------------------------------------------------------------
     % MAXIMA DIFERENCIA
%          MD = MAX abs( im(i,j) - nim(i,j ) ;
     %--------------------------------------------------------------
     %--------------------------------------------------------------
     %--------------------------------------------------------------
     % ERROR ABSOLUTO MEDIO
%          MAE = suma_mae ./ NM;
       suma_mae = 0;
     %--------------------------------------------------------------
     %--------------------------------------------------------------
     %--------------------------------------------------------------
     % ERROR CUADRATICO MEDIO DEBIL
%          PMSE = suma_mse ./ ( MN .* ( maximo_im ).^2) ;

       maximo_im = max(max(im)); 
     %--------------------------------------------------------------
     %--------------------------------------------------------------
     %--------------------------------------------------------------
     % CONTENIDO ESTRUCTURAL
%          
%          SC = suma_nim_sqr ./ suma_im_sqr;
%           
         suma_nim_sqr = 0;
         suma_im_sqr = 0;
     %--------------------------------------------------------------
     %--------------------------------------------------------------
     %--------------------------------------------------------------
     % MULTICORRELACIÓN NORMALIZADA
%          
%           NK = suma_pro_img ./ suma_im_sqr;
%          
        suma_pro_img = 0;
     %--------------------------------------------------------------
     %--------------------------------------------------------------
     %--------------------------------------------------------------
     %          
     % INDICE DE CALIDAD DE IMAGEN
     %          
     %--------------------------------------------------------------
        media_im = mean2(im);
        media_nim = mean2(nim);
        suma_sigmac_im = 0;
        suma_sigmac_nim = 0;
        suma_corr = 0;
     %--------------------------------------------------------------

     for i = 1:f
         for j = 1:c
             suma_mse = ( im(i,j) - nim(i,j) ).^2 + suma_mse;
             error_total = abs(nim(i,j) - im(i,j)) + error_total;
             num_snr = ( im(i,j) - media_im ).^2 + num_snr;
             den_snr = ( im(i,j) - nim(i,j) ).^2 + den_snr;
             suma_ad = ( im(i,j) - nim(i,j) ) + suma_ad;
             suma_nim_sqr = (nim(i,j)).^2 + suma_nim_sqr;
             suma_im_sqr = (im(i,j)).^2 + suma_im_sqr;
             suma_pro_img = ( im(i,j) .* nim(i,j)) + suma_pro_img;
             suma_sigmac_im = ( im(i,j) - media_im ).^2 + suma_sigmac_im;
             suma_sigmac_nim = ( nim(i,j) - media_nim ).^2 + suma_sigmac_nim;
             suma_corr =  ( im(i,j) - media_im ).*( nim(i,j) - media_nim ) + suma_corr;
         end
     end
     
     %  MSE : ERROR CUADRÁTICO MEDIO
     MSE = suma_mse ./ MN;
     
     %  SNR : RELACIÓN SEÑAL A RUIDO
     SNR = num_snr ./ den_snr;
     
     %  AD : DIFERENCIA MEDIA
     AD = suma_ad ./ MN;

     %  SC : CONTENIDO ESTRUCTURAL
     SC = suma_nim_sqr ./ suma_im_sqr;
     
     % NK : MULTICORRELACIÓN NORMALIZADA
     NK = suma_pro_img ./ suma_im_sqr;
     
     sigma_im = sqrt(suma_sigmac_im./(MN - 1));
     sigma_nim = sqrt(suma_sigmac_nim./(MN - 1));
     sigma_im_nim = suma_corr./(MN-1);

     L = sigma_im_nim./(sigma_im.*sigma_nim);
     C = (2.*media_im.*media_nim)./((media_im).^2 + (media_nim).^2);
     S = (2.*sigma_im.*sigma_nim)./((suma_sigmac_im./(MN - 1)) + (suma_sigmac_nim./(MN - 1)));

     % Q: INDICE UNIVERSAL DE CALIDAD DE IMAGEN
     Q = L.*C.*S;
     RMSE = sqrt(MSE);
    

end
