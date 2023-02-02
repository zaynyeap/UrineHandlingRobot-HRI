function [] = Point2Pull(s,Robot1)
%% Plotting the interface
% Convert angles from degree to radians to plot q
Plot_Base = -4;
Plot_Shoulder = 2;
Plot_Elbow = 72;
Plot_Wrist = -86;

q(1) = (Plot_Base* pi/180); 
q(2) = (Plot_Shoulder * pi/180);
q(3) = (Plot_Elbow * pi/180);
q(4) = (Plot_Wrist * pi/180);

% Plot results
Robot1.plot(q);
%% Phase 1
fprintf(s, sprintf('#%d%s%d', 5, 'D', -145)); %Gripper Open
pause(3);
fprintf(s, sprintf('#%d%s%d', 1, 'D', -40));
fprintf(s, sprintf('#%d%s%d', 2, 'D', 20));
fprintf(s, sprintf('#%d%s%d', 3, 'D', 720));
fprintf(s, sprintf('#%d%s%d', 4, 'D', -840));
pause(1)
%% Gripper Open Close
fprintf(s, sprintf('#%d%s%d', 5, 'D', -165)); %Gripper Open
pause(2);
fprintf(s, sprintf('#%d%s%d', 5, 'D', -60)); %Gripper close
pause(1);
IdlePosition(s,Robot1);
end