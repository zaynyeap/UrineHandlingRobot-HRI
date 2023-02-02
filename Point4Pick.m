function [] = Point4Pick(s,Robot1)
%% Plotting the interface
% Convert angles from degree to radians to plot q
Plot_Base = 72;
Plot_Shoulder = 13;
Plot_Elbow = 34;
Plot_Wrist = -49;

q(1) = (Plot_Base* pi/180); 
q(2) = (Plot_Shoulder * pi/180);
q(3) = (Plot_Elbow * pi/180);
q(4) = (Plot_Wrist * pi/180);

% Plot results
Robot1.plot(q);
%% Phase 1
pause(1);
fprintf(s, sprintf('#%d%s%d', 4, 'D', -490));
fprintf(s, sprintf('#%d%s%d', 5, 'D', -180)); %Open gripper
pause(2);
fprintf(s, sprintf('#%d%s%d', 1, 'D', 720));
fprintf(s, sprintf('#%d%s%d', 2, 'D', 130));
fprintf(s, sprintf('#%d%s%d', 3, 'D', 340));
fprintf(s, sprintf('#%d%s%d', 4, 'D', -490));
pause(2);
fprintf(s, sprintf('#%d%s%d', 5, 'D', -60)); %Close gripper
pause(1);
% Shoulder servo motor
fprintf(s, sprintf('#%d%s%d', 2, 'D', -100));
% Elbow servo motor
fprintf(s, sprintf('#%d%s%d', 3, 'D', 300));
% Wrist servo motor
fprintf(s, sprintf('#%d%s%d', 4, 'D', -220));
pause(1)
IncubatorIdle(s,Robot1);
pause(1)

end