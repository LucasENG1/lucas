function [Th,PWM,Erro_final,F_out] = Allocation_FCA(F,Th,PWM,i)

global k1 Lx Ly Pwmmax Pwmmin;

tolerancia = 0.01*norm(F(:,i-1)); % 5% de erro total tolerado

% Inicializa��o
iteracao_Maxim = 10; %Numero m�ximo itera��es do FCA

Err = 100*norm(F(:,i-1));
j   = 0;

% Vari�veis da Aloca��o Anterior
Th1 = Th(1,i-1);
Th2 = Th(2,i-1);
Th3 = Th(3,i-1);
Th4 = Th(4,i-1);

PWM1 = PWM(1,i-1);
PWM2 = PWM(2,i-1);
PWM3 = PWM(3,i-1);
PWM4 = PWM(4,i-1);

if norm(F(:,i-1))> 0.1 % Verifica se existe alguma for�a para ser alocada
    
    while((j <= iteracao_Maxim) && (Err > tolerancia))
       
        j = j + 1;  
        %% ============= Calculo dos Angulos a partir das for�as e PWMs anteriores =============
        M1 =  [k1*PWM1      0            k1*PWM2      0            k1*PWM3     0            k1*PWM4       0   ;
            0         k1*PWM1      0            k1*PWM2      0           k1*PWM3      0             k1*PWM4;
            -Ly*k1*PWM1     Lx*k1*PWM1   Ly*k1*PWM2  -Lx*k1*PWM2   Ly*k1*PWM3  Lx*k1*PWM3  -Ly*k1*PWM4   -Lx*k1*PWM4];

%         M1 =  [1    0     1     0    1    0    1    0;
%                0    1     0     1    0    1    0    1;
%               -Ly   Lx    Ly   -Lx   Ly   Lx  -Ly  -Lx];
        
        M1_Inv = pinv(M1);  %transpose(M1)/(M1*transpose(M1));%+1e-5*eye(size(M1*transpose(M1))));
        
        F1 = M1_Inv * F(:,i);
        
        Th1 = atan2(F1(2),F1(1));
        Th2 = atan2(F1(4),F1(3));
        Th3 = atan2(F1(6),F1(5));
        Th4 = atan2(F1(8),F1(7));
        
%         [T,P] = DynamicsOfServosAndMotors(i,[Th,[Th1;Th2;Th3;Th4]],[PWM,[PWM1;PWM2;PWM3;PWM4]]);
%         Th1 = T(1);
%         Th2 = T(2);
%         Th3 = T(3);
%         Th4 = T(4);
        
        %% ============= PWM calculado a partir da forca e dos angulos anteriores =============
        M2 =[k1*cos(Th1)                        k1*cos(Th2)                       k1*cos(Th3)                       k1*cos(Th4);
            k1*sin(Th1)                         k1*sin(Th2)                       k1*sin(Th3)                       k1*sin(Th4);
            k1*(-Ly*cos(Th1)+Lx*sin(Th1))  k1*(Ly*cos(Th2)-Lx*sin(Th2)) k1*(Ly*cos(Th3)+Lx*sin(Th3)) k1*(-Ly*cos(Th4)-Lx*sin(Th4))];
        
        M2_Inv = pinv(M2); %inv(W)*transpose(M2)/((M2*inv(W)*transpose(M2))+ep); % Eq. 12.276
        
        Pwm  = M2_Inv * F(:,i);
        
        PWM1 = Pwm(1);
        PWM2 = Pwm(2);
        PWM3 = Pwm(3);
        PWM4 = Pwm(4);
        
%         [T,PM] =  DynamicsOfServosAndMotors(i,[Th,[Th1;Th2;Th3;Th4]],[PWM,Pwm]);  % Teste foi feito
%         PWM1 = PM(1);
%         PWM2 = PM(2);
%         PWM3 = PM(3);
%         PWM4 = PM(4);
        
%         %% ===============================================================================================        
%                 [T,PM] = DynamicsOfServosAndMotors(i,[Th,[Th1;Th2;Th3;Th4]],[PWM,[PWM1;PWM2;PWM3;PWM4]]);
%                 Th1 = T(1);
%                 Th2 = T(2);
%                 Th3 = T(3);
%                 Th4 = T(4);
%                 PWM1 = PM(1);
%                 PWM2 = PM(2);
%                 PWM3 = PM(3);
%                 PWM4 = PM(4);
        
        %% Satura
%         Th1 = Satura(Th1,pi,-pi);
%         Th2 = Satura(Th2,pi,-pi);
%         Th3 = Satura(Th3,pi,-pi);
%         Th4 = Satura(Th4,pi,-pi);
%         
        PWM1 = Satura(PWM1,Pwmmax,Pwmmin);
        PWM2 = Satura(PWM2,Pwmmax,Pwmmin);
        PWM3 = Satura(PWM3,Pwmmax,Pwmmin);
        PWM4 = Satura(PWM4,Pwmmax,Pwmmin);
        
        %%
        F_out = Aloc_Direta([Th1;Th2;Th3;Th4],[PWM1;PWM2;PWM3;PWM4]);
        
        Erro(:,j) = abs(F(:,i) - F_out);
        Err  = norm(Erro(:,j));
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
%         
%         drawnow


%%
Erro_final = Erro(end,j);

PWM = [PWM1;PWM2;PWM3;PWM4];
Th  = [Th1;Th2;Th3;Th4];

end








