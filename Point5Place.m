function [] = Point5Place(s,Robot1)
%% Plotting the interface
% Convert angles from degree to radians to plot q
Plot_Base = 83;
Plot_Shoulder = 13;
Plot_Elbow = 32;
Plot_Wrist = -63;

q(1) = (Plot_Base* pi/180); 
q(2) = (Plot_Shoulder * pi/180);
q(3) = (Plot_Elbow * pi/180);
q(4) = (Plot_Wrist * pi/180);

% Plot results
Robot1.plot(q);
%% Phase 1
pause(1);
fprintf(s, sprintf('#%d%s%d', 4, 'D', -630)); %Wrist lowers to prevent collision
pause(1);
fprintf(s, sprintf('#%d%s%d', 1, 'D', 830));
fprintf(s, sprintf('#%d%s%d', 2, 'D', 130));
fprintf(s, sprintf('#%d%s%d', 3, 'D', 320));
fprintf(s, sprintf('#%d%s%d', 4, 'D', -630));
pause(1);
fprintf(s, sprintf('#%d%s%d', 5, 'D', -145)); %Gripper Open
pause(1)

end