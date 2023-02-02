function [] = OpenCover(s,Robot1)
%%
%% Configuration
% Configure Max Speed to 40 deg/s
fprintf(s, sprintf('#%d%s%d', 254, 'CSD', 40));
pause(2);
%% Plotting the interface
% Convert angles from degree to radians to plot q
Plot_Base = 83;
Plot_Shoulder = 0;
Plot_Elbow = 0;
Plot_Wrist = 0;

q(1) = (Plot_Base* pi/180); 
q(2) = (Plot_Shoulder * pi/180);
q(3) = (Plot_Elbow * pi/180);
q(4) = (Plot_Wrist * pi/180);

% Plot results
Robot1.plot(q);
%% Phase 1
pause(1);
fprintf(s, sprintf('#%d%s%d', 4, 'D', 0)); %Gripper opens to prevent collision
pause(1);
fprintf(s, sprintf('#%d%s%d', 1, 'D', 830));
fprintf(s, sprintf('#%d%s%d', 2, 'D', 0));
fprintf(s, sprintf('#%d%s%d', 3, 'D', 0));
fprintf(s, sprintf('#%d%s%d', 4, 'D', 0));
pause(2);
%% Plotting the interface (1.1)
Plot_Wrist = 52;
q(4) = (Plot_Wrist * pi/180);

% Plot results
Robot1.plot(q);
%% Phase 1.1
fprintf(s, sprintf('#%d%s%d', 4, 'D', 520));
pause(1);
%% Plotting the interface
% Convert angles from degree to radians to plot q
Plot_Base = 83;
Plot_Shoulder = 11;
Plot_Elbow = -4;
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
pause(2);
fprintf(s, sprintf('#%d%s%d', 1, 'D', 830));
fprintf(s, sprintf('#%d%s%d', 2, 'D', 110));
fprintf(s, sprintf('#%d%s%d', 3, 'D', -40));
fprintf(s, sprintf('#%d%s%d', 4, 'D', 380));
pause(1);
%% Plotting the interface
% Convert angles from degree to radians to plot q
Plot_Base = 83;
Plot_Shoulder = -18;
Plot_Elbow = 27;
Plot_Wrist = 38;

q(1) = (Plot_Base* pi/180); 
q(2) = (Plot_Shoulder * pi/180);
q(3) = (Plot_Elbow * pi/180);
q(4) = (Plot_Wrist * pi/180);

% Plot results
Robot1.plot(q);
%% Phase 3
pause(1);
fprintf(s, sprintf('#%d%s%d', 4, 'D', 380)); %Gripper opens to prevent collision
pause(2);
fprintf(s, sprintf('#%d%s%d', 1, 'D', 830));
fprintf(s, sprintf('#%d%s%d', 2, 'D', -180));
fprintf(s, sprintf('#%d%s%d', 3, 'D', 270));
fprintf(s, sprintf('#%d%s%d', 4, 'D', 500));
pause(2);
%% Plotting the interface
% Convert angles from degree to radians to plot q
Plot_Base = 83;
Plot_Shoulder = -49;
Plot_Elbow = 50;
Plot_Wrist = 38;

q(1) = (Plot_Base* pi/180); 
q(2) = (Plot_Shoulder * pi/180);
q(3) = (Plot_Elbow * pi/180);
q(4) = (Plot_Wrist * pi/180);

% Plot results
Robot1.plot(q);
%% Phase 4
pause(1);
fprintf(s, sprintf('#%d%s%d', 4, 'D', 380)); %Gripper opens to prevent collision
pause(2);
fprintf(s, sprintf('#%d%s%d', 1, 'D', 830));
fprintf(s, sprintf('#%d%s%d', 2, 'D', -490));
fprintf(s, sprintf('#%d%s%d', 3, 'D', 500));
fprintf(s, sprintf('#%d%s%d', 4, 'D', 380));
pause(2);
%% Plotting the interface (4.1)
Plot_Elbow = 32;
Plot_Wrist = 72;
q(3) = (Plot_Elbow * pi/180);
q(4) = (Plot_Wrist * pi/180);

% Plot results
Robot1.plot(q);
%% Phase 1.1
fprintf(s, sprintf('#%d%s%d', 4, 'D', 720));
pause(2);
fprintf(s, sprintf('#%d%s%d', 3, 'D', 320));
pause(2);
fprintf(s, sprintf('#%d%s%d', 4, 'D', -220));
pause(2);
IncubatorIdle(s,Robot1);
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


