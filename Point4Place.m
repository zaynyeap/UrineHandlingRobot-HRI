function [] = Point4Place(s,Robot1)
%% Plotting the interface
% Convert angles from degree to radians to plot q
Plot_Base = 72;
Plot_Shoulder = 9;
Plot_Elbow = 41;
Plot_Wrist = -74;

q(1) = (Plot_Base* pi/180); 
q(2) = (Plot_Shoulder * pi/180);
q(3) = (Plot_Elbow * pi/180);
q(4) = (Plot_Wrist * pi/180);

% Plot results
Robot1.plot(q);
%% Phase 1
pause(1);
fprintf(s, sprintf('#%d%s%d', 4, 'D', -740)); %Wrist lowers to prevent collision
pause(1);
fprintf(s, sprintf('#%d%s%d', 1, 'D', 720));
fprintf(s, sprintf('#%d%s%d', 2, 'D', 90));
fprintf(s, sprintf('#%d%s%d', 3, 'D', 410));
fprintf(s, sprintf('#%d%s%d', 4, 'D', -740));
pause(1);
%% Query session value for current
fprintf(s, sprintf('#%d%s', 4, 'QC')); % Query session value for current
speedString = fscanf(s , '%s'); % to check current
pat = digitsPattern + textBoundary;
newStr = extract(speedString,pat);
disp(newStr);
%% Plotting the interface
% Convert angles from degree to radians to plot q
Plot_Base = 72;
Plot_Shoulder = 9;
Plot_Elbow = 34;
Plot_Wrist = -58;

q(1) = (Plot_Base* pi/180); 
q(2) = (Plot_Shoulder * pi/180);
q(3) = (Plot_Elbow * pi/180);
q(4) = (Plot_Wrist * pi/180);

% Plot results
Robot1.plot(q);
%% Phase 2
fprintf(s, sprintf('#%d%s%d', 1, 'D', 720));
fprintf(s, sprintf('#%d%s%d', 2, 'D', 90));
fprintf(s, sprintf('#%d%s%d', 3, 'D', 340));
fprintf(s, sprintf('#%d%s%d', 4, 'D', -480));
pause(2);
%% Query session value for current
fprintf(s, sprintf('#%d%s', 4, 'QC')); % Query session value for current
speedString = fscanf(s , '%s'); % to check current
pat = digitsPattern + textBoundary;
newStr = extract(speedString,pat);
disp(newStr);
%% Phase 2.1
Plot_Base = 76;
q(1) = (Plot_Base * pi/180);
% Plot results
Robot1.plot(q);
fprintf(s, sprintf('#%d%s%d', 1, 'D', 760));
pause(1);
%% Query session value for current
fprintf(s, sprintf('#%d%s', 4, 'QC')); % Query session value for current
speedString = fscanf(s , '%s'); % to check current
pat = digitsPattern + textBoundary;
newStr = extract(speedString,pat);
disp(newStr);
%% Open Gripper
fprintf(s, sprintf('#%d%s%d', 5, 'D', -150)); %Gripper Open
pause(1)
end