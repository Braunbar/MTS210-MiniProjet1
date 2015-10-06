% Caracteristique du signal
frequence = 1000000;               % Fréquence en Hertz
amplitude = 1;                  % Amplitude

% Axe des temps
duree = 0.000004;                                                 % Durée du signal (s)
nEchantillon = 101 ;                                        % Nombre d’échantillons temporel
temps = linspace(0,duree ,nEchantillon) ;                   % Calcul  des  instants d’échantillonnage

signal_emis = amplitude*sin(2*pi*frequence*temps);


figure
plot(temps, signal_emis);
xlabel('Temps');
ylabel('Amplitude');
title('Signal émis');