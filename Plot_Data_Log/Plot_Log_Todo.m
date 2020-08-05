clear all; clc; close all;

%case 'BIN'
load('DIATOP/BIN.mat')

plot(AHR2(8308:8308+1947,2)/1000000,AHR2(8308:8308+1947,5));
legend('Yaw grid')

figure
plot(AHR2(8308:8308+1947,7),AHR2(8308:8308+1947,8),'linewidth',2);
legend('posicao grid');

figure
plot(AHR2(:,7),AHR2(:,8),'linewidth',2);
legend('completo');

%%
load('DIATOP/3BIN.mat')
As=950;
ini=4400;

plot(AHR2(ini:ini+As,2)/1000000,AHR2(ini:ini+As,5),'r');
legend('Yaw oito')

figure
plot(AHR2(ini:ini+As,7),AHR2(ini:ini+As,8),'r','linewidth',2);
legend('posicao oito');

%% Linha reta 1
As=950;
ini=1;

figure
plot(AHR2(ini:ini+As,2)/1000000,AHR2(ini:ini+As,5),'m');
legend('Yaw linha reta')

figure
plot(AHR2(ini:ini+As,7),AHR2(ini:ini+As,8),'m','linewidth',2);
legend('posicao linha reta');

%% oito 2
As=950;
ini=2700;

figure
plot(AHR2(ini:ini+As,2)/1000000,AHR2(ini:ini+As,5),'g');
legend('Yaw oito')

figure
plot(AHR2(ini:ini+As,7),AHR2(ini:ini+As,8),'g','linewidth',2);
legend('posicao oito');

%% circulo
As=750;
ini=7000;

figure
plot(AHR2(ini:ini+As,2)/1000000,AHR2(ini:ini+As,5),'g');
legend('Yaw circulo')

figure
plot(AHR2(ini:ini+As,7),AHR2(ini:ini+As,8),'g','linewidth',2);
legend('posicao circulo');

figure
plot(AHR2(:,7),AHR2(:,8),'m','linewidth',2);
legend('completo ');