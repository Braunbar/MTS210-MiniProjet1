% Caracteristique du signal
frequence  = 1000000;               % Fréquence en Hertz
frequence2 = 450000;               % Fréquence en Hertz
amplitude = 1;                  % Amplitude
amplitude2 = 1                  % Amplitude
attenuation1 = 0.5;              % Atténuation1
attenuation2 = 0.2;              % Atténuation2
amplitude_bruit1 = 0.3;                  % Amplitude bruit1
amplitude_bruit2 = 1.5;                  % Amplitude bruit2


% Axe des temps
duree = 0.000004;                                           % Durée du signal (s)
nEchantillon = 101 ;                                        % Nombre d’échantillons temporel
temps = linspace(0,duree ,nEchantillon) ;                   % Calcul  des  instants d’échantillonnage
temps_total = linspace(0,duree*10 ,nEchantillon*10) ;                   % Calcul  des  instants d’échantillonnage

signalrecu = zeros (1,nEchantillon*10);
signalemis=amplitude*sin(2*pi*frequence*temps);
signalemis2=amplitude2*sin(2*pi*frequence2*temps);
signalrecu(nEchantillon*4:nEchantillon*5-1) = signalemis;
signalrecu(nEchantillon*7:nEchantillon*8-1) = signalemis2;

filtre=fliplr(signalemis);
filtre2=fliplr(signalemis2);

figure
b1 = (rand(1,nEchantillon*10)-0.5)*amplitude_bruit1;
subplot(2,2,1)
    plot(temps_total,(signalrecu)*attenuation1 + b1);
    axis([0 0.00004 -1 1]);
    xlabel('Temps');
    ylabel('Amplitude');
    title('Signal recu atténué et bruité');
    
    
b2 = (rand(1,nEchantillon*10)-0.5)*amplitude_bruit2;
subplot(2,2,2)
    plot(temps_total,(signalrecu)*attenuation2 + b2);
    %axis([0 0.00004 -1 1]);
    xlabel('Temps');
    ylabel('Amplitude');
    title('Signal recu fortement atténué et fortement bruité');
    
conv1 = conv((signalrecu)*attenuation1 + b1,filtre)+conv((signalrecu)*attenuation1 + b1,filtre2);
subplot(2,2,3)
    plot(temps_total,conv1(1:nEchantillon*10));
    %axis([0 0.00004 -1 1]);
    xlabel('Temps');
    ylabel('Amplitude');
    title('Signal recu atténué, bruité et convolué');
    
    
conv2 = conv((signalrecu)*attenuation1 + b2,filtre)+conv((signalrecu)*attenuation2 + b2,filtre2);
subplot(2,2,4)
    plot(temps_total,conv2(1:nEchantillon*10));
    %axis([0 0.00004 -1 1]);
    xlabel('Temps');
    ylabel('Amplitude');
    title('Signal recu fortement atténué, fortement bruité et convolué');


    
