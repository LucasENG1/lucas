%==========================================================================
% This function plots several graphics on the screen in order to show the
% simulation results
%==========================================================================
function PlotGraphics
% Global variable(s)
global numFig SimOutput_Plot Time TimeJ SP Sim;

Screen = get(0,'ScreenSize');
Screen = [25 0 0.95*Screen(3) 0.85*Screen(4)];

NetForcesAndMomentsPG = SimOutput_Plot.NetForcesAndMoments(:,1:length(TimeJ));
NetForcesAndMomentsPG(abs(NetForcesAndMomentsPG) < 1e-3) = 0;

PositionAndAttitudePG = SimOutput_Plot.X_Y_psi(:,1:length(TimeJ));

u_v_wPG = SimOutput_Plot.u_v_r(:,1:length(TimeJ));
u_v_wPG(abs(u_v_wPG) < 1e-3) = 0;

MotorsOutputsAnglePG = SimOutput_Plot.Theta(:,1:length(TimeJ)).*(180/pi);
PWMOutputs    = SimOutput_Plot.PWM(:,1:length(TimeJ));

%% ************************
% NET FORCES AND MOMENTS
% ************************
if exist('NetForcesAndMomentsPG', 'var') == 1
    numFig = numFig + 1;
    figure(numFig);
    set(gcf, 'Position', Screen);
    axesVectors = [0.07 0.70 0.90 0.25; 0.07 0.42 0.90 0.25; 0.07 0.14 0.90 0.25];
    %......................................................................
    ax1 = axes('Units', 'Normalized', 'Position', axesVectors(1, :), ...
        'FontName', 'Times New Roman', 'FontSize', 16, 'GridLineStyle', ...
        ':', 'MinorGridLineStyle', ':', 'XMinorTick', 'on', ...
        'YMinorTick', 'on', 'Box', 'on');
    grid on;
    hold on all;
    title({strcat('${\rm\bf NET\,\,FORCES\,\,IN\,\,THE\,\,BODY\!-\!FI', ...
        'XED\,\,(BF)\,\,FRAME}$')}, 'Interpreter', 'latex');
    ylabel({'${\tau_{\rm net}^{\rm FX}(t)\,{\rm[N]}}$'}, 'Interpreter', ...
        'latex');
    plot(TimeJ, NetForcesAndMomentsPG(1, :), 'b-', 'LineWidth', 2);
    
    DummyVar = NetForcesAndMomentsPG(1, :);
    if min(DummyVar) == max(DummyVar) && abs(min(DummyVar)) >= 1e-12
        axis([0 TimeJ(end) sort([0.8 1.2]*min(DummyVar), 'ascend')]);
    elseif min(DummyVar) == max(DummyVar) && abs(min(DummyVar)) < 1e-12
        axis([0 TimeJ(end) -1 1]);
    else
        axis([0 TimeJ(end) min(DummyVar) max(DummyVar)]);
    end
    %......................................................................
    ax2 = axes('Units', 'Normalized', 'Position', axesVectors(2, :), ...
        'FontName', 'Times New Roman', 'FontSize', 16, 'GridLineStyle', ...
        ':', 'MinorGridLineStyle', ':', 'XMinorTick', 'on', ...
        'YMinorTick', 'on', 'Box', 'on');
    grid on;
    hold on all;
    ylabel({'${\tau_{\rm net}^{\rm FY}(t)\,{\rm[N]}}$'}, 'Interpreter', ...
        'latex');
    plot(TimeJ, NetForcesAndMomentsPG(2, :), 'b-', 'LineWidth', 2);
    
    DummyVar = NetForcesAndMomentsPG(2, :);
    if min(DummyVar) == max(DummyVar) && abs(min(DummyVar)) >= 1e-12
        axis([0 TimeJ(end) sort([0.8 1.2]*min(DummyVar), 'ascend')]);
    elseif min(DummyVar) == max(DummyVar) && abs(min(DummyVar)) < 1e-12
        axis([0 TimeJ(end) -1 1]);
    else
        axis([0 TimeJ(end) min(DummyVar) max(DummyVar)]);
    end
    %......................................................................
    ax3 = axes('Units', 'Normalized', 'Position', axesVectors(3, :), ...
        'FontName', 'Times New Roman', 'FontSize', 16, 'GridLineStyle', ...
        ':', 'MinorGridLineStyle', ':', 'XMinorTick', 'on', ...
        'YMinorTick', 'on', 'Box', 'on');
    grid on;
    hold on all;
    xlabel({'${\rm TimeJ\,[s]}$'}, 'Interpreter', 'latex');
    ylabel({'${\tau_{\rm net}^{\rm Z}(t)\,{\rm[N]}}$'}, 'Interpreter', ...
        'latex');
    plot(TimeJ, NetForcesAndMomentsPG(3, :), 'b-', 'LineWidth', 2);
    
    DummyVar = NetForcesAndMomentsPG(3, :);
    if min(DummyVar) == max(DummyVar) && abs(min(DummyVar)) >= 1e-12
        axis([0 TimeJ(end) sort([0.8 1.2]*min(DummyVar), 'ascend')]);
    elseif min(DummyVar) == max(DummyVar) && abs(min(DummyVar)) < 1e-12
        axis([0 TimeJ(end) -1 1]);
    else
        axis([0 TimeJ(end) min(DummyVar) max(DummyVar)]);
    end
    %......................................................................
    linkaxes([ax1 ax2 ax3], 'x');
end

%% ***********************************************************
% VELOCITIES IN THE BODY-FIXED (BF) FRAME
% ***********************************************************
if exist('u_v_wPG', 'var') == 1
    numFig = numFig + 1;
    figure(numFig);
    set(gcf, 'Position', Screen);
    axesVectors = [0.07 0.70 0.90 0.25; 0.07 0.42 0.90 0.25; 0.07 0.14 ...
        0.90 0.25];
    %......................................................................
    ax1 = axes('Units', 'Normalized', 'Position', axesVectors(1, :), ...
        'FontName', 'TimeJs New Roman', 'FontSize', 16, 'GridLineStyle', ...
        ':', 'MinorGridLineStyle', ':', 'XMinorTick', 'on', ...
        'YMinorTick', 'on', 'Box', 'on');
    grid on;
    hold on all;
    title({strcat('${\rm\bf \,\,VELOCITIES\,\,IN\,\,THE\,\,BODY', ...
        '\!-\!FIXED\,\,(BF)\,\,FRAME}$')}, 'Interpreter', 'latex');
    ylabel({'$u(t)\,{\rm[m/s]}$'}, 'Interpreter', 'latex');
    plot(TimeJ, u_v_wPG(1, :), 'b-', 'LineWidth', 2);
    
    DummyVar = u_v_wPG(1, :);
    if min(DummyVar) == max(DummyVar) && abs(min(DummyVar)) >= 1e-12
        axis([0 TimeJ(end) sort([0.8 1.2]*min(DummyVar), 'ascend')]);
    elseif min(DummyVar) == max(DummyVar) && abs(min(DummyVar)) < 1e-12
        axis([0 TimeJ(end) -1 1]);
    else
        axis([0 TimeJ(end) min(DummyVar) max(DummyVar)]);
    end
    %......................................................................
    ax2 = axes('Units', 'Normalized', 'Position', axesVectors(2, :), ...
        'FontName', 'TimeJs New Roman', 'FontSize', 16, 'GridLineStyle', ...
        ':', 'MinorGridLineStyle', ':', 'XMinorTick', 'on', ...
        'YMinorTick', 'on', 'Box', 'on');
    grid on;
    hold on all;
    ylabel({'$v(t)\,{\rm[m/s]}$'}, 'Interpreter', 'latex');
    plot(TimeJ, u_v_wPG(2, :), 'b-', 'LineWidth', 2);
    
    DummyVar = u_v_wPG(2, :);
    if min(DummyVar) == max(DummyVar) && abs(min(DummyVar)) >= 1e-12
        axis([0 TimeJ(end) sort([0.8 1.2]*min(DummyVar), 'ascend')]);
    elseif min(DummyVar) == max(DummyVar) && abs(min(DummyVar)) < 1e-12
        axis([0 TimeJ(end) -1 1]);
    else
        axis([0 TimeJ(end) min(DummyVar) max(DummyVar)]);
    end
    %......................................................................
    ax3 = axes('Units', 'Normalized', 'Position', axesVectors(3, :), ...
        'FontName', 'TimeJs New Roman', 'FontSize', 16, 'GridLineStyle', ...
        ':', 'MinorGridLineStyle', ':', 'XMinorTick', 'on', ...
        'YMinorTick', 'on', 'Box', 'on');
    grid on;
    hold on all;
    xlabel({'${\rm TimeJ\,[s]}$'}, 'Interpreter', 'latex');
    ylabel({'$r(t)\,{\rm[^{\circ}\!/s]}$'}, 'Interpreter', 'latex');
    plot(TimeJ, (180/pi)*u_v_wPG(3, :), 'b-', 'LineWidth', 2);
    
    DummyVar = (180/pi)*u_v_wPG(3, :);
    if min(DummyVar) == max(DummyVar) && abs(min(DummyVar)) >= 1e-12
        axis([0 TimeJ(end) sort([0.8 1.2]*min(DummyVar), 'ascend')]);
    elseif min(DummyVar) == max(DummyVar) && abs(min(DummyVar)) < 1e-12
        axis([0 TimeJ(end) -1 1]);
    else
        axis([0 TimeJ(end) min(DummyVar) max(DummyVar)]);
    end
    %......................................................................
    linkaxes([ax1 ax2 ax3], 'x');
end

% %% ************************************************************
% % POSITION AND ATTITUDE IN THE (INERTIAL) NED FRAME
% % ************************************************************
% if exist('PositionAndAttitudePG', 'var') == 1
%     numFig = numFig + 1;
%     figure(numFig);
%     set(gcf, 'Position', Screen);
%     axesVectors = [0.07 0.70 0.90 0.25; 0.07 0.42 0.90 0.25; 0.07 0.14 ...
%         0.90 0.25];
%     %......................................................................
%     ax1 = axes('Units', 'Normalized', 'Position', axesVectors(1, :), ...
%         'FontName', 'TimeJs New Roman', 'FontSize', 16, 'GridLineStyle', ...
%         ':', 'MinorGridLineStyle', ':', 'XMinorTick', 'on', ...
%         'YMinorTick', 'on', 'Box', 'on');
%     grid on;
%     hold on all;
%     title({strcat('${\rm\bf POSITION\,\,AND\, ATTITUDE\,IN\,\,THE\,\,(INERTIAL)\,\,(NED)\,\,FRAME}$')}, 'Interpreter', ...
%         'latex');
%     ylabel({'${x(t)\,\rm[m]}$'}, 'Interpreter', 'latex');
%     
%     plot(Time, SP.X,'r','LineWidth',2);
%     plot(TimeJ, PositionAndAttitudePG(1,:),'b-', 'LineWidth',2);
%     hold off;
%     %     legend('SP','Position');
%     
%     DummyVar =[PositionAndAttitudePG(1,:),SP.X];
%     if min(DummyVar)== max(DummyVar) && abs(min(DummyVar))>= 1e-12
%         axis([0 Time(end) sort([0.8 1.2]*min(DummyVar), 'ascend')]);
%     elseif min(DummyVar) == max(DummyVar) && abs(min(DummyVar)) < 1e-12
%         axis([0 Time(end) -1 1]);
%     else
%         axis([0 Time(end) min(DummyVar) max(DummyVar)]);
%     end
%     %......................................................................
%     ax2 = axes('Units', 'Normalized', 'Position', axesVectors(2, :), ...
%         'FontName', 'TimeJs New Roman', 'FontSize', 16, 'GridLineStyle', ...
%         ':', 'MinorGridLineStyle', ':', 'XMinorTick', 'on', ...
%         'YMinorTick', 'on', 'Box', 'on');
%     grid on;
%     hold on all;
%     ylabel({'${y(t)\,\rm[m]}$'}, 'Interpreter', 'latex');
%     
%     plot(Time, SP.Y,'r','LineWidth', 2);hold on;
%     plot(TimeJ, PositionAndAttitudePG(2, :),'b-','LineWidth',2);
%     hold off;
%     
%     DummyVar = ([PositionAndAttitudePG(2, :),SP.Y]);
%     if min(DummyVar) == max(DummyVar) && abs(min(DummyVar)) >= 1e-12
%         axis([0 Time(end) sort([0.8 1.2]*min(DummyVar), 'ascend')]);
%     elseif min(DummyVar) == max(DummyVar) && abs(min(DummyVar)) < 1e-12
%         axis([0 Time(end) -1 1]);
%     else
%         axis([0 Time(end) min(DummyVar) max(DummyVar)]);
%     end
%     %......................................................................
%     ax3 = axes('Units', 'Normalized', 'Position', axesVectors(3, :), ...
%         'FontName', 'TimeJs New Roman', 'FontSize', 16, 'GridLineStyle', ...
%         ':', 'MinorGridLineStyle', ':', 'XMinorTick', 'on', ...
%         'YMinorTick', 'on', 'Box', 'on');
%     grid on;
%     hold on all;
%     xlabel({'${\rm TimeJ\,[s]}$'}, 'Interpreter', 'latex');
%     ylabel({'${\psi(t)\,\rm[^{\circ}]}$'}, 'Interpreter', ...
%         'latex');
%     
%     plot(Time, SP.Yaw*(180/pi),'r','LineWidth', 2);hold on;
%     plot(TimeJ, (180/pi)*PositionAndAttitudePG(3, :),'b-','LineWidth', 2);
%     hold off;
%     
%     DummyVar = (180/pi)*[PositionAndAttitudePG(3, :),SP.Yaw];
%     if min(DummyVar) == max(DummyVar) && abs(min(DummyVar)) >= 1e-12
%         axis([0 Time(end) sort([0.8 1.2]*min(DummyVar), 'ascend')]);
%     elseif min(DummyVar) == max(DummyVar) && abs(min(DummyVar)) < 1e-12
%         axis([0 Time(end) -1 1]);
%     else
%         axis([0 Time(end) min(DummyVar) max(DummyVar)]);
%     end
%     %......................................................................
%     linkaxes([ax1 ax2 ax3], 'x');
% end
%% ************************************************************
% MOTOR OUTPUT PERFORMED
% ************************************************************
if exist('MotorsOutputsAnglePG', 'var') == 1
    numFig = numFig + 1;
    figure(numFig);
    set(gcf, 'Position', Screen);
    axesVectors = [0.07 0.77 0.90 0.15; 0.07 0.57 0.90 0.15; 0.07 0.37 0.90 0.15; 0.07 0.17 0.90 0.15];
    %......................................................................
    ax1 = axes('Units', 'Normalized', 'Position', axesVectors(1, :), ...
        'FontName', 'TimeJs New Roman', 'FontSize', 16, 'GridLineStyle', ...
        ':', 'MinorGridLineStyle', ':', 'XMinorTick', 'on', ...
        'YMinorTick', 'on', 'Box', 'on');
    grid on;
    hold on all;
    title({strcat('${\rm\bf MOTORS\,\,ANGLES\,\,OUTPUTS}$')},'Interpreter','latex');
    ylabel({'${M_1(t)\,\rm[grau]}$'}, 'Interpreter', 'latex');
    
    plot(TimeJ, MotorsOutputsAnglePG(1, :), 'b-', 'LineWidth', 2); legend('Real Angle')
    
    DummyVar = MotorsOutputsAnglePG(1, :);
    if min(DummyVar) == max(DummyVar) && abs(min(DummyVar)) >= 1e-12
        axis([0 TimeJ(end) sort([0.8 1.2]*min(DummyVar), 'ascend')]);
    elseif min(DummyVar) == max(DummyVar) && abs(min(DummyVar)) < 1e-12
        axis([0 TimeJ(end) -1 1]);
    else
        axis([0 TimeJ(end) min(DummyVar) max(DummyVar)]);
    end
    %......................................................................
    ax2 = axes('Units', 'Normalized', 'Position', axesVectors(2, :), ...
        'FontName', 'TimeJs New Roman', 'FontSize', 16, 'GridLineStyle', ...
        ':', 'MinorGridLineStyle', ':', 'XMinorTick', 'on', ...
        'YMinorTick', 'on', 'Box', 'on');
    grid on;
    hold on all;
    ylabel({'${M_2(t)\,\rm[grau]}$'},'Interpreter','latex');
    
    plot(TimeJ, MotorsOutputsAnglePG(2, :),'b-','LineWidth',2);
    
    DummyVar = MotorsOutputsAnglePG(2, :);
    if min(DummyVar) == max(DummyVar) && abs(min(DummyVar)) >= 1e-12
        axis([0 TimeJ(end) sort([0.8 1.2]*min(DummyVar), 'ascend')]);
    elseif min(DummyVar) == max(DummyVar) && abs(min(DummyVar)) < 1e-12
        axis([0 TimeJ(end) -1 1]);
    else
        axis([0 TimeJ(end) min(DummyVar) max(DummyVar)]);
    end
    %......................................................................
    ax3 = axes('Units', 'Normalized', 'Position', axesVectors(3,:), ...
        'FontName', 'TimeJs New Roman', 'FontSize', 16, 'GridLineStyle', ...
        ':', 'MinorGridLineStyle', ':', 'XMinorTick', 'on', ...
        'YMinorTick', 'on', 'Box', 'on');
    grid on;
    hold on all;
    ylabel({'${M_3(t)\,\rm[grau]}$'}, 'Interpreter', 'latex');
    
    plot(TimeJ, MotorsOutputsAnglePG(3, :), 'b-', 'LineWidth', 2);
    
    DummyVar = MotorsOutputsAnglePG(3,:);
    if min(DummyVar) == max(DummyVar) && abs(min(DummyVar)) >= 1e-12
        axis([0 TimeJ(end) sort([0.8 1.2]*min(DummyVar), 'ascend')]);
    elseif min(DummyVar) == max(DummyVar) && abs(min(DummyVar)) < 1e-12
        axis([0 TimeJ(end) -1 1]);
    else
        axis([0 TimeJ(end) min(DummyVar) max(DummyVar)]);
    end
    %......................................................................
    ax4 = axes('Units', 'Normalized', 'Position', axesVectors(4, :), ...
        'FontName', 'TimeJs New Roman', 'FontSize', 16, 'GridLineStyle', ...
        ':', 'MinorGridLineStyle', ':', 'XMinorTick', 'on', ...
        'YMinorTick', 'on', 'Box', 'on');
    grid on;
    hold on all;
    ylabel({'${M_4(t)\,\rm[grau]}$'}, 'Interpreter', 'latex');
    
    plot(TimeJ, MotorsOutputsAnglePG(4,:), 'b-', 'LineWidth', 2);
    
    DummyVar = MotorsOutputsAnglePG(4,:);
    if min(DummyVar) == max(DummyVar) && abs(min(DummyVar)) >= 1e-12
        axis([0 TimeJ(end) sort([0.8 1.2]*min(DummyVar), 'ascend')]);
    elseif min(DummyVar) == max(DummyVar) && abs(min(DummyVar)) < 1e-12
        axis([0 TimeJ(end) -1 1]);
    else
        axis([0 TimeJ(end) min(DummyVar) max(DummyVar)]);
    end
    %......................................................................
    linkaxes([ax1 ax2 ax3 ax4], 'x');
end

%% ************************************************************
% PWM OUTPUT PERFORMED
% ************************************************************
if exist('PWMOutputs', 'var') == 1
    numFig = numFig + 1;
    figure(numFig);
    set(gcf, 'Position', Screen);
    axesVectors = [0.07 0.77 0.90 0.15; 0.07 0.57 0.90 0.15; 0.07 0.37 0.90 0.15; 0.07 0.17 0.90 0.15];
    %......................................................................
    ax1 = axes('Units', 'Normalized', 'Position', axesVectors(1, :), ...
        'FontName', 'TimeJs New Roman', 'FontSize', 16, 'GridLineStyle', ...
        ':', 'MinorGridLineStyle', ':', 'XMinorTick', 'on', ...
        'YMinorTick', 'on', 'Box', 'on');
    grid on;
    hold on all;
    title({strcat('${\rm\bf MOTORS\,\,PWM\,\,OUTPUTS}$')},'Interpreter','latex');
    ylabel({'${M_1(t)\,\rm[PWM]}$'}, 'Interpreter', 'latex');
    
    plot(TimeJ, PWMOutputs(1, :), 'b-', 'LineWidth', 2); legend('PWM')
    
    DummyVar = PWMOutputs(1, :);
    if min(DummyVar) == max(DummyVar) && abs(min(DummyVar)) >= 1e-12
        axis([0 TimeJ(end) sort([0.8 1.2]*min(DummyVar), 'ascend')]);
    elseif min(DummyVar) == max(DummyVar) && abs(min(DummyVar)) < 1e-12
        axis([0 TimeJ(end) -1 1]);
    else
        axis([0 TimeJ(end) min(DummyVar) max(DummyVar)]);
    end
    %......................................................................
    ax2 = axes('Units', 'Normalized', 'Position', axesVectors(2, :), ...
        'FontName', 'TimeJs New Roman', 'FontSize', 16, 'GridLineStyle', ...
        ':', 'MinorGridLineStyle', ':', 'XMinorTick', 'on', ...
        'YMinorTick', 'on', 'Box', 'on');
    grid on;
    hold on all;
    ylabel({'${M_2(t)\,\rm[PWM]}$'},'Interpreter','latex');
    
    plot(TimeJ, PWMOutputs(2, :),'b-','LineWidth',2);
    
    DummyVar = PWMOutputs(2, :);
    if min(DummyVar) == max(DummyVar) && abs(min(DummyVar)) >= 1e-12
        axis([0 TimeJ(end) sort([0.8 1.2]*min(DummyVar), 'ascend')]);
    elseif min(DummyVar) == max(DummyVar) && abs(min(DummyVar)) < 1e-12
        axis([0 TimeJ(end) -1 1]);
    else
        axis([0 TimeJ(end) min(DummyVar) max(DummyVar)]);
    end
    %......................................................................
    ax3 = axes('Units', 'Normalized', 'Position', axesVectors(3,:), ...
        'FontName', 'TimeJs New Roman', 'FontSize', 16, 'GridLineStyle', ...
        ':', 'MinorGridLineStyle', ':', 'XMinorTick', 'on', ...
        'YMinorTick', 'on', 'Box', 'on');
    grid on;
    hold on all;
    ylabel({'${M_3(t)\,\rm[PWM]}$'}, 'Interpreter', 'latex');
    
    plot(TimeJ, PWMOutputs(3, :), 'b-', 'LineWidth', 2);
    
    DummyVar = PWMOutputs(3,:);
    if min(DummyVar) == max(DummyVar) && abs(min(DummyVar)) >= 1e-12
        axis([0 TimeJ(end) sort([0.8 1.2]*min(DummyVar), 'ascend')]);
    elseif min(DummyVar) == max(DummyVar) && abs(min(DummyVar)) < 1e-12
        axis([0 TimeJ(end) -1 1]);
    else
        axis([0 TimeJ(end) min(DummyVar) max(DummyVar)]);
    end
    %......................................................................
    ax4 = axes('Units', 'Normalized', 'Position', axesVectors(4, :), ...
        'FontName', 'TimeJs New Roman', 'FontSize', 16, 'GridLineStyle', ...
        ':', 'MinorGridLineStyle', ':', 'XMinorTick', 'on', ...
        'YMinorTick', 'on', 'Box', 'on');
    grid on;
    hold on all;
    ylabel({'${M_4(t)\,\rm[PWM]}$'}, 'Interpreter', 'latex');
    
    plot(TimeJ, PWMOutputs(4,:), 'b-', 'LineWidth', 2);
    
    DummyVar = PWMOutputs(4,:);
    if min(DummyVar) == max(DummyVar) && abs(min(DummyVar)) >= 1e-12
        axis([0 TimeJ(end) sort([0.8 1.2]*min(DummyVar), 'ascend')]);
    elseif min(DummyVar) == max(DummyVar) && abs(min(DummyVar)) < 1e-12
        axis([0 TimeJ(end) -1 1]);
    else
        axis([0 TimeJ(end) min(DummyVar) max(DummyVar)]);
    end
    %......................................................................
    linkaxes([ax1 ax2 ax3 ax4], 'x');
    
   end 
    
    %% plot Mathaus
    % Forças calculadas e forças alocadas.
    numFig = numFig + 1;
    
    figure(numFig)
    subplot(3,1,1)
    plot(TimeJ,Sim.F(1,1:length(TimeJ)),'b','linewidth',2);hold on
    plot(TimeJ,Sim.F_out(1,1:length(TimeJ)),'r','linewidth',2);grid on
    legend('Controlador','Alocado Matriz');title('Força X');
    
    subplot(3,1,2)
    plot(TimeJ,Sim.F(2,1:length(TimeJ)),'b','linewidth',2);hold on
    plot(TimeJ,Sim.F_out(2,1:length(TimeJ)),'r','linewidth',2);grid on
    legend('Controlador','Alocado Matriz'); title('Força Y');
    
    subplot(3,1,3)
    plot(TimeJ,Sim.F(3,1:length(TimeJ)),'b','linewidth',2);hold on
    plot(TimeJ,Sim.F_out(3,1:length(TimeJ)),'r','linewidth',2);grid on
    legend('Controlador','Alocado Matriz');title('Força YAW');
    
