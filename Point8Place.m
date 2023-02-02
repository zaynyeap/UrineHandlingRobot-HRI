function [] = Point8Place(s,Robot1)
%% Plotting the interface
% Convert angles from degree to radians to plot q
Plot_Base = -83;
Plot_Shoulder = 22;
Plot_Elbow = 23;
Plot_Wrist = -63;

q(1) = (Plot_Base* pi/180); 
q(2) = (Plot_Shoulder * pi/180);
q(3) = (Plot_Elbow * pi/180);
q(4) = (Plot_Wrist * pi/180);

% Plot results
Robot1.plot(q);
%% Phase 1
% Rotate base first
fprintf(s, sprintf('#%d%s%d', 1, 'D', -780));
fprintf(s, sprintf('#%d%s%d', 4, 'D', -530));
fprintf(s, sprintf('#%d%s%d', 5, 'D', -60)); %Gripper Close
pause(3);
%% 
fprintf(s, sprintf('#%d%s%d', 1, 'D', -780));
fprintf(s, sprintf('#%d%s%d', 2, 'D', 230));
fprintf(s, sprintf('#%d%s%d', 3, 'D', 230));
fprintf(s, sprintf('#%d%s%d', 4, 'D', -620));
pause(2);
fprintf(s, sprintf('#%d%s%d', 1, 'D', -850));
pause(2);
%%
fprintf(s, sprintf('#%d%s%d', 2, 'D', 250));
fprintf(s, sprintf('#%d%s%d', 3, 'D', 200));
pause(1);
%% 
fprintf(s, sprintf('#%d%s%d', 5, 'D', -150)); %Gripper release
pause(1);
% Shoulder servo motor
fprintf(s, sprintf('#%d%s%d', 2, 'D', -100));
% Elbow servo motor
fprintf(s, sprintf('#%d%s%d', 3, 'D', 300));
% Wrist servo motor
fprintf(s, sprintf('#%d%s%d', 4, 'D', -220));
pause(1);
IncubatorIdle(s,Robot1);
pause(1)

end