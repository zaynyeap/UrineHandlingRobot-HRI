function [] = Point3Pull(s,Robot1)
%% Plotting the interface
% Convert angles from degree to radians to plot q
Plot_Base = -18;
Plot_Shoulder = 2;
Plot_Elbow = 67;
Plot_Wrist = -79;

q(1) = (Plot_Base* pi/180); 
q(2) = (Plot_Shoulder * pi/180);
q(3) = (Plot_Elbow * pi/180);
q(4) = (Plot_Wrist * pi/180);

% Plot results
Robot1.plot(q);
%% Phase 1
fprintf(s, sprintf('#%d%s%d', 5, 'D', -155)); %Gripper Open
pause(3);
fprintf(s, sprintf('#%d%s%d', 1, 'D', -180));
fprintf(s, sprintf('#%d%s%d', 2, 'D', 20));
fprintf(s, sprintf('#%d%s%d', 3, 'D', 670));
fprintf(s, sprintf('#%d%s%d', 4, 'D', -720));
pause(1);
%% Plotting the interface
% Convert angles from degree to radians to plot q
Plot_Base = 14;
Plot_Shoulder = -52;
Plot_Elbow = 63;
Plot_Wrist = -22;

q(1) = (Plot_Base* pi/180); 
q(2) = (Plot_Shoulder * pi/180);
q(3) = (Plot_Elbow * pi/180);
q(4) = (Plot_Wrist * pi/180);

% Plot results
Robot1.plot(q);

%% Phase 2
fprintf(s, sprintf('#%d%s%d', 5, 'D', -165)); %Gripper Open
pause(1);
fprintf(s, sprintf('#%d%s%d', 5, 'D', -60)); %Gripper close
pause(1);
fprintf(s, sprintf('#%d%s%d', 2, 'D', -520));
pause(1);
fprintf(s, sprintf('#%d%s%d', 1, 'D', 140));
% Shoulder servo motor
fprintf(s, sprintf('#%d%s%d', 2, 'D', -520));
% Elbow servo motor
fprintf(s, sprintf('#%d%s%d', 3, 'D', 630));
% Wrist servo motor
fprintf(s, sprintf('#%d%s%d', 4, 'D', -220));
% Gripper servo motor
fprintf(s, sprintf('#%d%s%d', 5, 'D', -60)); % 0 is closed , range to -500 to open

end