

%% Create port and add terminator (\r)
s = serial('COM5', 'BaudRate', 115200);
s.Terminator = 'CR';
fopen(s);

%% (Warming up & Test robot arm) Send command to test 
% Configure Max Speed to 30 deg/s
fprintf(s, sprintf('#%d%s%d', 254, 'CSD', 30));
% Robot arm home position 
% Base servo motor
fprintf(s, sprintf('#%d%s%d', 1, 'D', 0));
% Shoulder servo motor
fprintf(s, sprintf('#%d%s%d', 2, 'D', 0));
% Elbow servo motor
fprintf(s, sprintf('#%d%s%d', 3, 'D', 0));
% Wrist servo motor
fprintf(s, sprintf('#%d%s%d', 4, 'D', 0));
% Gripper servo motor
%fprintf(s, sprintf('#%d%s%d', 5, 'D', -140)); % 0 is closed , range to -500 to open
%% Creating DH Table  
d1 = 4.13;   % Base to shoulder
d2 = 5.61;   % Shoulder to elbow
d3 = 6.39;   % Elbow to wrist
d4 = 4.52;   % Wrist to end effector
            
% Create Links based on DH table
L(1) = Link([0 d1 0 pi/2]);
L(2) = Link([0 0 d2 0]);
L(3) = Link([0 0 d3 0]);
L(4) = Link([0 0 d4 0]);
            
% Joint limit angles
L(1).qlim = [-pi pi];
L(2).qlim = [-pi/2 pi/2];
L(3).qlim = [-pi/2 pi/2];
L(4).qlim = [-pi/2 pi/2];
            
% Joint offsets
L(1).offset = pi;
L(2).offset = pi/2;
L(3).offset = pi/2;
            
% Create Links & Plot robot
Robot1 = SerialLink(L);
Robot1.plotopt = {'workspace', [-20,20,-20,20,0,20], 'tile1color', [232 232 232], 'jointcolor', 'c','noarrow', 'nowrist'};
            
% Display Robot in teach mode
q = [0 0 0 0];
Robot1.teach(q);

%% Set x, y ,z coordinates

x= 4.6;
y= 10;
z =4;

%% Solve inverse kinematics problem

 Ti = [1 0 0 x;
       0 1 0 y;
       0 0 1 z;
       0 0 0 1];
  
% Calculate inverse kinematics
J = Robot1.ikcon(Ti, q)*180/pi;
base_ang = round(J(1));
shoulder_ang = round(J(2));
elbow_ang = round(J(3));
wrist_ang = round(J(4));

% Plot results
q = J*pi/180;
Robot1.plot(q);            
%clear J;
%% Alter the values in teach mode, then use forward kinematics to save values

q = Robot1.getpos();
T = Robot1.fkine(q);
[x,y,z] = transl(T);

% Convert q values from Radians to Degrees
base_ang = round(q(1)*180/pi);
shoulder_ang = round(q(2)*180/pi);
elbow_ang = round(q(3)*180/pi);
wrist_ang = round(q(4)*180/pi);


% Limit angle values to [-90,90-0=]
base = min(max(base_ang,-120),120);
shoulder = min(max(shoulder_ang,-90),90);
elbow = min(max(elbow_ang,-90),90);
wrist = min(max(wrist_ang,-90),90);
                
% Send serial commands
fprintf(s, sprintf('#%d%s%d', 1, 'D', round((base)*10)));
fprintf(s, sprintf('#%d%s%d', 2, 'D', round((shoulder)*10)));
fprintf(s, sprintf('#%d%s%d', 3, 'D', round((elbow)*10)));
fprintf(s, sprintf('#%d%s%d', 4, 'D', round((wrist)*10)));
% Gripper servo motor
fprintf(s, sprintf('#%d%s%d', 5, 'D', -60)); % 0 is closed , range to -500 to open

%% When satisfied, save trained points

BasePoint1 = round((base)*10);
ShoulderPoint2 = round ((shoulder)*10);
ElbowPoint3 = round ((elbow)*10);
WristPoint4 = round ((wrist)*10);
%% Close port
fclose(s);
disp('serial port closed')