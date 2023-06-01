% Twiddle

clear ;clc; close all;

% Obtem os parâmetros iniciais do controlador

% Trata-se de um PID:
% K=[Kp, Ki, Kd]

K = [0 0 0];

% Parâmentros do TWIDDLE:

% Diferencial de alteração dos parâmetros
dK = [1 , 1 , 1];

% Diferencial de alteração de 'dK', caso este falhe
ksi = 1/100;

% Limiar de finalização
delta = 0.001;

% Obtem o primeiro erro. Como é o único existente, é o melhor de todos.
Erro_best = SimulaProcesso(K , 0);

% Loop de otimização
k = 0; % contador de iterações
while sum(dK) > delta
    % Contador de iterações
    k = k + 1;
    
    % Para cada um dos "i" parâmetros do controlador
    for i = 1:length(K)
        
        % Procura pelos melhores parâmetros afrente do original
        
        % Incrementa o parâmetro "i"
        K(i) = K(i) + dK(i);
        
        %Calcula o erro associado ao novo conjunto de parâmetros
        Erro = SimulaProcesso(K , 0);
        
        % Se o erro calculado no momento atual é melhor que o melhor erro
        % calculado até o momento (Erro_best), então, substitui-se o erro.
        
        if Erro < Erro_best
            Erro_best = Erro;
            % Aumente o diferencial dK
            % Se o erro melhorou (diminuiu), então significa que estamos
            % procurando o parâmetro no sentido correto. Assim, para
            % acelerar a busca, aumentamos a variação deste parâmetro.
            
            dK(i) = dK(i) * (1 + ksi);
        else
            % Procura pelos melhores parâmetros na direção contraria
            % Inverta o sentido do parâmetro K_i
            
            K(i) = K(i)- 2 * dK(i);
            
            % Calcula o erro associado ao novo parâmetro
            Erro = SimulaProcesso(K, 0);
            
            % Se o erro calculado eh melhor que o melhor erro do momento
            if Erro < Erro_best
                % Armazena o erro
                Erro_best = Erro;
                % Aumente o diferencial dK
                dK(i) = dK(i) * (1 + ksi);
                
            else
                % Nenhum dos sentidos funcionou
                % Retorne o parâmetro K_i para seu valor original
                K(i) = K(i) + dK(i);
                % Diminua o diferencial dK_i
                dK(i) = dK(i) * (1-ksi);
                
            end
        end
    end
    fprintf('Rodada = %i: Melhor erro = %.4f, soma(dK)= %.6f\n', k, Erro_best, sum(dK))
end
fprintf('Parâmetros: P = %.4f, I = %.4f, D = %.4f\n', K(1), K(2), K(3))
Erro_best = SimulaProcesso(K, 1);
            
            
    
    

