function [] = Point6Place(s,Robot1)
%% Plotting the interface
% Convert angles from degree to radians to plot q
Plot_Base = 94;
Plot_Shoulder = 13;
Plot_Elbow = 36;
Plot_Wrist = -79;

q(1) = (Plot_Base* pi/180); 
q(2) = (Plot_Shoulder * pi/180);
q(3) = (Plot_Elbow * pi/180);
q(4) = (Plot_Wrist * pi/180);

% Plot results
Robot1.plot(q);
%% Phase 1
pause(1);
fprintf(s, sprintf('#%d%s%d', 4, 'D', -790)); %Gripper opens to prevent collision
pause(3)
fprintf(s, sprintf('#%d%s%d', 1, 'D', 940));
fprintf(s, sprintf('#%d%s%d', 2, 'D', 130));
fprintf(s, sprintf('#%d%s%d', 3, 'D', 360));
fprintf(s, sprintf('#%d%s%d', 4, 'D', -720));
pause(3);
fprintf(s, sprintf('#%d%s%d', 5, 'D', -130)); %Gripper Open
pause(2);
fprintf(s, sprintf('#%d%s%d', 2, 'D', -100)); %Shoulder up
pause(1);
IncubatorIdle(s,Robot1);
end