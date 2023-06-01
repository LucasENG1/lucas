function DeltaErro = SimulaProcesso(K , plot_sim)

% Parâmetros do Controlador PID

Kp = K(1);
Ki = K(2);
Kd = K(3);

% Sólidos geométricos que representarão o robô diferencial BIDIMENSIONAL
% Corpo do Robô

Corpo = [ 100 , 227.5 , 227.5 , 100, -200 , -227.5 , -227.5 , -200
         -190.5 , -50, 50, 190.5 , 190.5 , 163 , -163 , -190.5]/1000;

Corpo = [Corpo ; [1 1 1 1 1 1 1 1]]; % linha de ls para transf. homogenea.
    
% Roda esquerda
RodaE = [97.5 97.5 -97.5 -97.5 
         170.5 210.5 210.5 170.5]/1000;
RodaE = [RodaE; [1 1 1 1]]; % linha de 1s para transf. homogênea

% Roda direita
RodaD = [97.5 97.5 -97.5 -97.5 
        -170.5 -210.5 -210.5 -170.5]/1000;
RodaD = [RodaD; [1 1 1 1]]; % linha de 1s para transf. homogênea

% A POSIÇÃO INICIAL DO ROBÔ

% Posição inicial do Robô bidimensional: P = (x, y, th)
% Pode ser qualquer uma. Vamos escolher a origem só por conveniência.

P = [0;           % X inicial do Robô [m]
     0;           % Y inicial do Robô [m]
     deg2rad(0)]; % th inicial do Robô [rad]
 
 R = P; % Histórico de posições do Robô
 
 % Parâmetros do Robô, obtidos do manual do fabricante, ou então, medidos
 % diretamento no Robô
 
 % Raio da roda (r) [m]
 r = 1/2 * (195/1000); %[m]
 
 % Metade do comprimento do eixo das rodas (l) [m]
 l = 1/2 * (381/1000); %[m]
 
 
 % Armazena a posiçã inicial (para cálculo dos erros)
 Pini = P;
 
 % O PONTO OBJETIVO
 
 g_r = 3;             % raio a ser aplicado para o cálculo [m]
 g_th = deg2rad(145); % ângulo a ser aplicado para o cálculo [rad]
 
 % A posição objetivo (Goal) estará distante da posição inicial (Pini)
 
 G = [Pini(1) + g_r * cos(g_th);
      Pini(2) + g_r * sin(g_th);];
  
  
 % Obtém o caminho ótimo (desejado) entre ambos: linha reta
 
 % Equação Geral da Reta formada entre dois pontos a * x + b * y + c = 0
 % Se P1(x1, y1) e P2(x2, y2), então:
 
 %     | x y  1 |
 % det |x1 y1 1 | = 0
 %     |x2 y2 1 |
 
 % Nos dá os parâmetros "a" , "b" e "c" da reta.
 % Sendo, portanto: (y1 - y2) * x +(x2 - x1) * y + (x1 * y2 - x2 * y1) = 0
 % Assim, se P1 = G e P2 = Pini:
 % a = y1 - y2
 
 a = G(2) - Pini(2);
 b = Pini(1) - G(1);
 
 % c = x1 * y2 - x2 * y1
 c = G(1) * Pini(2) - Pini(1) * G(1);
 
 % Esta é a reta que liga o ponto inicial (Pini) ao ponto objetivo (G).
 % Deseja-se que o Robô ande por cima desta reta, o melhor que puder, pois
 % ela é o melhor caminho (mais segura/mais rápido) entre ambos.
 % Assim, os erros deste algoritmo serão calculados por meio da distância
 % do Robô (ponto P) à reta (a * x + b * y + c = 0)
 
 % Erro da posição do Robô ate o caminho ótimo, utilizado para calcular
 % quão bem o Robô esta fazendo o caminho desejado. Distancia do ponto a
 % reta : 
 
 Erro = abs(a * P(1) + b * P(2) + c)/sqrt(a^2 + b^2);
 
 % Sinais de controle do robô
 
 % Neste controlador PID, a velocidade linear será limitada por velocidade
 % máxima "vmáx" escolhida pelo programados.
 
 vmax = 0.25; % [m/s]
 
 % Neste controlador PID, a velocidade angular será limitada por velocidade
 % máxima "wmax" escolhida pelo programador.
 
 wmax = deg2rad(180); %[rad/s]
 
 % PID:
 % Integral do erro do controlador PID (alpha)
 int_alpha = 0;
 % Derivada do erro do controlador PID (alpha)
 dif_alpha = 0;
 % Variável para o cálculo do termo diferencial do PID (alpha_(t-1))
 alpha_old = 0;
 
 % Contadores de tempo
 
 % Tempo corrente da simulação [s]
 t=0; % tempo inicial.
 
 % Tempo máximo permitido para a simulação [s] : a ser escolhido pelo
 % programador
 
 tmax = 10 * sqrt((G(1) - Pini(1))^2 + (G(2) - Pini(2))^2)/vmax;
 
 
 % Loop de Controle
 
 % Parâmetros de término de simulação:
 
 delta = 0.1 ; % Distancia métrica do objetivo [m]
 
 % Calcula os parâmetros
 % Erros realimentados:
 Dx = G(1) - P(1);
 Dy = G(2) - P(2);
 
 % RHO: Distância do Robô ao objetivo.
 rho = sqrt(Dx^2 + Dy^2);
 % GAMMA: Ângulo da posição do Robô ao objetivo
 gamma = AjustaAngulo(atan2(Dy , Dx));
 % ALPHA: Ângulo entre a frente do Robô e o objetivo.
 alpha = AjustaAngulo(gamma - P(3));
 
 % Tempo de amostragem
 dt = 0.1;
 
 while (rho > delta) && (t <= tmax)
     % Evolui o tempo.
     t = t + dt;
     
     % Calcula os parâmetros
     % Erros realimentados:
     Dx = G(1) - P(1);
     Dy = G(2) - P(2);
     
     % RHO: Distância do Robô ao objetivo.
     rho = sqrt(Dx^2 + Dy^2);
     % GAMMA: Ângulo da posição do Robô ao objetivo
     gamma = AjustaAngulo(atan2(Dy , Dx));
     % ALPHA: Ângulo entre a frente do Robô e o objetivo.
     alpha = AjustaAngulo(gamma - P(3));
     
     % PID: Parâmetros de integração e derivação.
     dif_alpha = (alpha - alpha_old); alpha_old = alpha;
     int_alpha = int_alpha + alpha;
     
     % Lei de Controle (u):
     v = min(rho, vmax);
     
     % Objetivos da parte de trás (comentar ou não à gosto)
     
       % if abs(alpha) > pi/2
            %v = -v;
            %alpha = AjustaAngulo(alpha + pi);
       % end
     
     % Velocidade angular (w): PID
     w = Kp * alpha + Ki * int_alpha + Kd * dif_alpha;
     w = sign(w) * min(abs(w), wmax);
     
     
     % Robô diferencial - modelo diferencial
     % Cálculo da variação da velocidade no instante de tempo 't' atual
     
     dPdt = [v * cos(P(3)); % v_x(t) é a decomposição em x de v(t)
             v * sin(P(3)); % v_y(t) é a decomposição em y de v(t)
             w];            % w(t) é o próprio w(t)
         
     % Calcula a nova posição do Robô no tempo 't' atual
     P = P + dPdt * dt;
     P(3) = AjustaAngulo(P(3));
     
     % Armazena as posições do Robô ao longo do tempo (Histórico)
     R = [R, P];
     
     % Erro da posição do Robô com relação ao caminho ótimo
     Erro = [Erro; abs(w) + abs(a * P(1) + b * P(2) + c)/sqrt(a^2 + b^2)]; 
     
     % Plot
     
     if isequal(plot_sim, 1)
         PlotSimulaProcesso;
     end
 end
 
 % Desempenho do algoritmo nesta rodada, a média de todos os erros.
 DeltaErro = mean(Erro);
 
end
 
 
 
 
 
 
      
      

