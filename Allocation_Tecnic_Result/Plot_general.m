function Plot_general(Theta,FM,i)
%% Função para plotar o barco com motores
% i     -> Indice da coluna da matriz com os valores Theta e F para todos os motores
% Theta -> Matriz (ou Vetor) com os angulos de todos os motores
% PWM   -> Matriz (ou Vetor) com as forças  de todos os motores
%
% Theta e PWM são organizados da seguinte maneira:
%                -------------------i--------------------
% Index          |1 | 2| 3| 4| 5| 6| 7| 8| 9|10|11|12|13|
% Theta_M1       |  |  |  |  |  |  |  |  |  |  |  |  |  |
% Theta_M2       |  |  |  |  |  |  |  |  |  |  |  |  |  |
% Theta_M3       |  |  |  |  |  |  |  |  |  |  |  |  |  |
% Theta_M4       |  |  |  |  |  |  |  |  |  |  |  |  |  |

%%
global ROV 

PlotBarco;

% motor 1 (superior DIREITO)
XYZ = [(ROV.dcbby),ROV.Loa/4,0];
PlotMotor(Theta(1,i),FM(1,i)*ROV.k1, XYZ)

% motor 2 (inferior esquerdo)
XYZ = [ROV.dceby,-ROV.Loa/4,0];
PlotMotor(Theta(2,i),FM(2,i)*ROV.k1,XYZ)

% motor 3 (superior esquerdo)
XYZ = [(ROV.dceby),ROV.Loa/4,0];
PlotMotor(Theta(3,i),FM(3,i)*ROV.k1,XYZ)

% motor 4 (inferior direito)
XYZ = [ROV.dcbby,-ROV.Loa/4,0];
PlotMotor(Theta(4,i),FM(4,i)*ROV.k1,XYZ);
axis([-2 2 -4 4 0 1])
view(2)
drawnow
end