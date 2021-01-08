function [Th,PWM,Erro_final,F_out] = Allocation_FCA(F,Th,PWM,i)

global k1 Lx Ly Pwmmax Pwmmin;

% Inicialização
iteracao_Maxim = 10; %Numero máximo iterações do FCA

j   = 0;

% Variáveis da Alocação Anterior
Th1 = Th(1,i-1);
Th2 = Th(2,i-1);
Th3 = Th(3,i-1);
Th4 = Th(4,i-1);

PWM1 = PWM(1,i-1);
PWM2 = PWM(2,i-1);
PWM3 = PWM(3,i-1);
PWM4 = PWM(4,i-1);

if norm(F(:,i))> 0.1 % Verifica se existe alguma força para ser alocada
    
    while(j <= iteracao_Maxim)
        j = j + 1;
        
        %% ============= PWM calculado a partir da forca e dos angulos anteriores =============
        M2 =[k1*cos(Th1)                        k1*cos(Th2)                       k1*cos(Th3)                       k1*cos(Th4);
            k1*sin(Th1)                         k1*sin(Th2)                       k1*sin(Th3)                       k1*sin(Th4);
            k1*(-Ly*cos(Th1)+Lx*sin(Th1))       k1*(Ly*cos(Th2)-Lx*sin(Th2))      k1*(Ly*cos(Th3)+Lx*sin(Th3))      k1*(-Ly*cos(Th4)-Lx*sin(Th4))];
        
        M2_Inv = pinv(M2); %inv(W)*transpose(M2)/((M2*inv(W)*transpose(M2))+ep); % Eq. 12.276
        
        Pwm  = M2_Inv * F(:,i);
        
        for a=1:length(Pwm)
            if Pwm(a)<0
                Pwm(a) = -Pwm(a);
                switch a
                    case 1
                        Th1= Th1+pi;  
                    case 2
                        Th2= Th2+pi;
                    case 3
                        Th3= Th3+pi;
                    case 4
                        Th4= Th4+pi;
                end
            end
        end
        
        PWM1 = Pwm(1);
        PWM2 = Pwm(2);
        PWM3 = Pwm(3);
        PWM4 = Pwm(4);
        % Satura
        PWM1 = Satura(PWM1,Pwmmax,Pwmmin);
        PWM2 = Satura(PWM2,Pwmmax,Pwmmin);
        PWM3 = Satura(PWM3,Pwmmax,Pwmmin);
        PWM4 = Satura(PWM4,Pwmmax,Pwmmin);
        
        %% Erro parcial 1
        F_out_1 = Aloc_Direta([Th1;Th2;Th3;Th4],[PWM1;PWM2;PWM3;PWM4]);
        
        Erro_part1 =  (F_out_1 - F(:,i))'* (F_out_1 - F(:,i)) ;
        
        if (Erro_part1<0.001)
            disp('1 - processo convergido na iteracao '); j
            break;
        end
        %% ============= Calculo dos Angulos a partir das forças e PWMs anteriores =============
        M1 =  [k1*PWM1      0            k1*PWM2      0            k1*PWM3     0            k1*PWM4       0   ;
            0         k1*PWM1      0            k1*PWM2      0           k1*PWM3      0             k1*PWM4;
            -Ly*k1*PWM1     Lx*k1*PWM1   Ly*k1*PWM2  -Lx*k1*PWM2   Ly*k1*PWM3  Lx*k1*PWM3  -Ly*k1*PWM4   -Lx*k1*PWM4];
        
        M1_Inv = pinv(M1);          %transpose(M1)/(M1*transpose(M1));%+1e-5*eye(size(M1*transpose(M1))));
        F1     = M1_Inv * F(:,i);
        
        Th1 = atan2(F1(2),F1(1));
        Th2 = atan2(F1(4),F1(3));
        Th3 = atan2(F1(6),F1(5));
        Th4 = atan2(F1(8),F1(7));
        
        %% Erro parcial 2
        F_out_2 = Aloc_Direta([Th1;Th2;Th3;Th4],[PWM1;PWM2;PWM3;PWM4]);
        
        Erro_part2 =  (F_out_2 - F(:,i))'* (F_out_2 - F(:,i)) ;
        
        if (Erro_part2<0.001)
            disp('2 - processo convergido na iteracao '); j
            break;
        end
        
    end
else
    F_out = zeros(3,1);
    PWM   = ones(4,1);
    Theta = zeros(4,1);
    Erro  = zeros(3,1);
end

j
% %% Figura
%         figure
%         subplot(311);
%         plot(Erro(1,:),'b'); hold on
%         legend('Fx FCA') ; title('Erro Final');    grid on
%
%         subplot(312);
%         plot(Erro(2,:),'b'); hold on
%         legend('Fy FCA') ; title('Erro Final');    grid on
%
%         subplot(313);
%         plot(Erro(3,:),'b'); hold on
%         legend('Tn FCA') ; title('Erro Final');    grid on
%         drawnow

%%
F_out = Aloc_Direta([Th1;Th2;Th3;Th4],[PWM1;PWM2;PWM3;PWM4]);

Erro_final = (F_out - F(:,i));

PWM = [PWM1;PWM2;PWM3;PWM4];
Th  = [Th1;Th2;Th3;Th4];

end


%         [T,P] = DynamicsOfServosAndMotors(i,[Th,[Th1;Th2;Th3;Th4]],[PWM,[PWM1;PWM2;PWM3;PWM4]]);
%         Th1 = T(1);
%         Th2 = T(2);
%         Th3 = T(3);
%         Th4 = T(4);
%         [T,PM] =  DynamicsOfServosAndMotors(i,[Th,[Th1;Th2;Th3;Th4]],[PWM,Pwm]);  % Teste foi feito
%         PWM1 = PM(1);
%         PWM2 = PM(2);
%         PWM3 = PM(3);
%         PWM4 = PM(4);

%         %% ===============================================================================================
%             [T,PM] = DynamicsOfServosAndMotors(i,[Th,[Th1;Th2;Th3;Th4]],[PWM,[PWM1;PWM2;PWM3;PWM4]]);
%             Th1 = T(1);
%             Th2 = T(2);
%             Th3 = T(3);
%             Th4 = T(4);
%             PWM1 = PM(1);
%             PWM2 = PM(2);
%             PWM3 = PM(3);
%             PWM4 = PM(4);






