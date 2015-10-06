clear all;
% Systeme de localisaion d'un bateau à partir de 3 signaux avec un symbole
% émis dedans.

% Chargement des signaux recus
load('signal1.mat'); %sig1
load('signal2.mat'); %sig2
load('signal3.mat'); %sig3

load('symbole.mat'); %s_signal

%Variable de la simulation
Fe = 500e3; %Fréquence d'échantillonage
V = 3e8;    %Vitesse de propagation de l'onde



%Affichage des signaux reçus.
figure(1);
    subplot(3,1,1);
        plot(sig1);
    title('Signaux reçus');
    subplot(3,1,2);
        plot(sig2);
    subplot(3,1,3);
        plot(sig3);


%Affichage du symbole.
figure(2);
    plot(s_signal);
    title('Symbole émis');
    
%Définition du filtre
filtre=fliplr(s_signal);

%Application du filtre
corre1 = conv(sig1,filtre);
corre2 = conv(sig2,filtre);
corre3 = conv(sig3,filtre);

       
%Determination des pics maximums correspondants à la fin du symbole
[val_max1, indice_max1] = max(corre1);
[val_max2, indice_max2] = max(corre2);
[val_max3, indice_max3] = max(corre3);

%Affichage des signaux filtrés.
figure(3);
    subplot(3,1,1);
        plot(corre1);%hold on;
        text(indice_max1-15,val_max1+15,['\downarrow ' int2str(val_max1) ' @ ' int2str(indice_max1)]);
        axis([0 2100 -50 100]);
        %plot(indice_max1,val_max1+0.1,'kv','markerfacecolor',[0 0 0]);
    title('Signaux reçus filtré');
    subplot(3,1,2);
        plot(corre2);%hold on;
        text(indice_max2-15,val_max2+15,['\downarrow ' int2str(val_max2) ' @ ' int2str(indice_max2)]);
        axis([0 2100 -50 100]);
        %plot(indice_max2,val_max2+0.1,'kv','markerfacecolor',[0 0 0]);
    subplot(3,1,3);
        plot(corre3);%hold on;
        text(indice_max3-15,val_max3+15,['\downarrow ' int2str(val_max3) ' @ ' int2str(indice_max3)]);
        axis([0 2100 -50 100]);
        %plot(indice_max3,val_max3+0.1,'kv','markerfacecolor',[0 0 0]);
        
%TODO add marker
%TODO legend

%Calcul des ecarts (en temporel) 
delta_temps1 = (indice_max1 - indice_max2) / Fe;
delta_temps2 = 0;
delta_temps3 = (indice_max3 - indice_max2) / Fe;

 %Calcul des ecarts (en distance) 
delta_dist1 = delta_temps1 * V;
delta_dist2 = delta_temps2 * V;
delta_dist3 = delta_temps3 * V;

% Résolution avec fsolve

P1 = [0,0];
P2 = [40000,0];
P3 = [0,40000];

B = [0,0,0]; %B3 correspond à la distance parcouru avant la detection par P1


equation = @(B)[
                    (B(1)-P1(1))^2 + (B(2)-P1(2))^2 - (delta_dist1 + B(3))^2;
                    (B(1)-P2(1))^2 + (B(2)-P2(2))^2 - (delta_dist2 + B(3))^2;
                    (B(1)-P3(1))^2 + (B(2)-P3(2))^2 - (delta_dist3 + B(3))^2;
            ];
            

x=fsolve(equation, B)


        