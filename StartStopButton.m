function [] = StartStopButton(s,Robot1)
%% Plotting the interface
% Convert angles from degree to radians to plot q
Plot_Base = 86;
Plot_Shoulder = -81;
Plot_Elbow = 65;
Plot_Wrist = 40;

q(1) = (Plot_Base* pi/180); 
q(2) = (Plot_Shoulder * pi/180);
q(3) = (Plot_Elbow * pi/180);
q(4) = (Plot_Wrist * pi/180);

% Plot results
Robot1.plot(q);
%% Phase 1
pause(1);
fprintf(s, sprintf('#%d%s%d', 4, 'D', 400)); %Gripper opens to prevent collision
pause(1);
fprintf(s, sprintf('#%d%s%d', 1, 'D', 860));
fprintf(s, sprintf('#%d%s%d', 2, 'D', -810));
fprintf(s, sprintf('#%d%s%d', 3, 'D', 650));
fprintf(s, sprintf('#%d%s%d', 4, 'D', 400));
pause(2);
%% Plotting the interface
% Convert angles from degree to radians to plot q
Plot_Base = 86;
Plot_Shoulder = -2;
Plot_Elbow = 45;
Plot_Wrist = 38;

q(1) = (Plot_Base* pi/180); 
q(2) = (Plot_Shoulder * pi/180);
q(3) = (Plot_Elbow * pi/180);
q(4) = (Plot_Wrist * pi/180);

% Plot results
Robot1.plot(q);
%% Phase 2
pause(1);
fprintf(s, sprintf('#%d%s%d', 4, 'D', 380)); %Gripper opens to prevent collision
fprintf(s, sprintf('#%d%s%d', 3, 'D', 450));
pause(1);
fprintf(s, sprintf('#%d%s%d', 1, 'D', 860));
fprintf(s, sprintf('#%d%s%d', 2, 'D', -20));
fprintf(s, sprintf('#%d%s%d', 3, 'D', 450));
fprintf(s, sprintf('#%d%s%d', 4, 'D', 380));
pause(2);
% Shoulder servo motor
fprintf(s, sprintf('#%d%s%d', 2, 'D', -520));
% Elbow servo motor
fprintf(s, sprintf('#%d%s%d', 3, 'D', 630));
% Wrist servo motor
fprintf(s, sprintf('#%d%s%d', 4, 'D', -220));
pause(2);
IdlePosition(s,Robot1)
end