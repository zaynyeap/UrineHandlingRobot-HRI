function [] = CloseCover(s,Robot1)
%% Configuration
% Configure Max Speed to 40 deg/s
fprintf(s, sprintf('#%d%s%d', 254, 'CSD', 40));
pause(2);
%% Plotting the interface
% Convert angles from degree to radians to plot q
Plot_Base = 32;
Plot_Shoulder = -7;
Plot_Elbow = 86;
Plot_Wrist = -72;

q(1) = (Plot_Base* pi/180); 
q(2) = (Plot_Shoulder * pi/180);
q(3) = (Plot_Elbow * pi/180);
q(4) = (Plot_Wrist * pi/180);

% Plot results
Robot1.plot(q);
%% Phase 1
pause(1);
fprintf(s, sprintf('#%d%s%d', 4, 'D', -720)); %Gripper opens to prevent collision
pause(2);
fprintf(s, sprintf('#%d%s%d', 1, 'D', 320));
fprintf(s, sprintf('#%d%s%d', 2, 'D', -70));
fprintf(s, sprintf('#%d%s%d', 3, 'D', 860));
fprintf(s, sprintf('#%d%s%d', 4, 'D', -720));
pause(2);
%% Plotting the interface (1.1)
% Convert angles from degree to radians to plot q
Plot_Base = 76;
q(1) = (Plot_Base* pi/180); 
% Plot results
Robot1.plot(q);
%% Phase 1.1
fprintf(s, sprintf('#%d%s%d', 1, 'D', 760)); %Move base to the right
pause(2);
%% Plotting the interface (1.2)
% Convert angles from degree to radians to plot q
Plot_Shoulder = -41;
Plot_Wrist = -63;

q(2) = (Plot_Shoulder * pi/180);
q(4) = (Plot_Wrist * pi/180);
% Plot results
Robot1.plot(q);

%% Phase 1.2
fprintf(s, sprintf('#%d%s%d', 2, 'D', -410)); %move upwards
fprintf(s, sprintf('#%d%s%d', 4, 'D', -630));
pause(2);

%% Plotting the interface
% Convert angles from degree to radians to plot q
Plot_Base = 76;
Plot_Shoulder = 0;
Plot_Elbow = 49;
Plot_Wrist = -58;

q(1) = (Plot_Base* pi/180); 
q(2) = (Plot_Shoulder * pi/180);
q(3) = (Plot_Elbow * pi/180);
q(4) = (Plot_Wrist * pi/180);
% Plot results
Robot1.plot(q);
%% Phase 2
fprintf(s, sprintf('#%d%s%d', 1, 'D', 760));
fprintf(s, sprintf('#%d%s%d', 2, 'D', 0));
fprintf(s, sprintf('#%d%s%d', 3, 'D', 490));
fprintf(s, sprintf('#%d%s%d', 4, 'D', -580));
pause(3);
%% Plotting the interface (2.1)
% Convert angles from degree to radians to plot q
Plot_Elbow = 61;
Plot_Wrist = -83;
q(3) = (Plot_Elbow * pi/180);
q(4) = (Plot_Wrist * pi/180);

% Plot results
Robot1.plot(q);

%% Phase 2.1
fprintf(s, sprintf('#%d%s%d', 4, 'D', -830)); %Gripper up

%% Plotting the interface
% Convert angles from degree to radians to plot q
Plot_Base = 76;
Plot_Shoulder = 0;
Plot_Elbow = 50;
Plot_Wrist = -52;

q(1) = (Plot_Base* pi/180); 
q(2) = (Plot_Shoulder * pi/180);
q(3) = (Plot_Elbow * pi/180);
q(4) = (Plot_Wrist * pi/180);
% Plot results
Robot1.plot(q);
%% Phase 3
fprintf(s, sprintf('#%d%s%d', 1, 'D', 760));
fprintf(s, sprintf('#%d%s%d', 2, 'D', 0));
fprintf(s, sprintf('#%d%s%d', 3, 'D', 500));
fprintf(s, sprintf('#%d%s%d', 4, 'D', -520));
pause(3);
%% Plotting the interface (3.1)
% Convert angles from degree to radians to plot q
Plot_Wrist = -82;
q(4) = (Plot_Wrist * pi/180);

% Plot results
Robot1.plot(q);

%% Phase 3.1
fprintf(s, sprintf('#%d%s%d', 4, 'D', -820));
pause(13);
fprintf(s, sprintf('#%d%s%d', 4, 'D', -520));
pause(4);
% Shoulder servo motor
fprintf(s, sprintf('#%d%s%d', 2, 'D', -100));
fprintf(s, sprintf('#%d%s%d', 3, 'D', 500));
pause(2);
% Base servo motor
fprintf(s, sprintf('#%d%s%d', 1, 'D', 760));
% Shoulder servo motor
fprintf(s, sprintf('#%d%s%d', 2, 'D', -520));
% Elbow servo motor
fprintf(s, sprintf('#%d%s%d', 3, 'D', 630));
% Wrist servo motor
fprintf(s, sprintf('#%d%s%d', 4, 'D', -220));
pause(5);
IdlePosition(s,Robot1);

%% Configuration
% Configure Max speed of base to 120 deg/sec
fprintf(s, sprintf('#%d%s%d', 1, 'CSD', 120));
% Configure Max speed of shoulder and elbow to 60 deg/sec
fprintf(s, sprintf('#%d%s%d', 2, 'CSD', 60));
fprintf(s, sprintf('#%d%s%d', 3, 'CSD', 60));
% Configure Max speed of wrist to gripper to 50 deg/sec
fprintf(s, sprintf('#%d%s%d', 4, 'CSD', 50));
fprintf(s, sprintf('#%d%s%d', 5, 'CSD', 50));
pause(2);
end