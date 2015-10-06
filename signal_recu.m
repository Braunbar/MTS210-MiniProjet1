% Caracteristique du signal
frequence = 1000000;               % Fréquence en Hertz
amplitude = 1;                  % Amplitude
attenuation1 = 0.5;              % Atténuation1
attenuation2 = 0.2;              % Atténuation2
amplitude_bruit1 = 0.3;                  % Amplitude bruit1
amplitude_bruit2 = 1.5;                  % Amplitude bruit2


% Axe des temps
duree = 0.000004;                                                 % Durée du signal (s)
nEchantillon = 101 ;                                        % Nombre d’échantillons temporel
temps = linspace(0,duree ,nEchantillon) ;                   % Calcul  des  instants d’échantillonnage
temps_total = linspace(0,duree*10 ,nEchantillon*10) ;                   % Calcul  des  instants d’échantillonnage

signalrecu = zeros (1,nEchantillon*10);

signalrecu(nEchantillon*4:nEchantillon*5-1) = amplitude*sin(2*pi*frequence*temps);

figure
subplot(2,2,1)
    plot(temps_total,signalrecu);
    axis([0 0.00004 -1 1]);
    xlabel('Temps');
    ylabel('Amplitude');
    title('Signal recu');
    
subplot(2,2,2)
    plot(temps_total,signalrecu*attenuation1);
    axis([0 0.00004 -1 1]);
    xlabel('Temps');
    ylabel('Amplitude');
    title('Signal recu atténué');
   
b = (rand(1,nEchantillon*10)-0.5)*amplitude_bruit1;
subplot(2,2,3)
    plot(temps_total,(signalrecu)*attenuation1 + b);
    axis([0 0.00004 -1 1]);
    xlabel('Temps');
    ylabel('Amplitude');
    title('Signal recu atténué et bruité');
    
    
b = (rand(1,nEchantillon*10)-0.5)*amplitude_bruit2;
subplot(2,2,4)
    plot(temps_total,(signalrecu)*attenuation2 + b);
    %axis([0 0.00004 -1 1]);
    xlabel('Temps');
    ylabel('Amplitude');
    title('Signal recu fortement atténué et fortement bruité');
