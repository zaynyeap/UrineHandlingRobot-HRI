% RobotSequential.m is a test code for all movement of robot, before
% implementing into Main.m

%% All trained points sequence are saved here
%% Create port and add terminator (\r)
s = serial('COM3', 'BaudRate', 115200);
s.Terminator = 'CR';
fopen(s);
%%
IdlePosition(s,Robot1);
pause(2);
CloseCover(s,Robot1);
pause(4);
%%
fprintf(s, sprintf('#%d%s%d', 2, 'D', -100));
fprintf(s, sprintf('#%d%s%d', 3, 'D', 550));
%%
OpenCover(s,Robot1);
%%
fprintf(s, sprintf('#%d%s%d', 1, 'D', - ...
    800));

%% Configuration
% Configure Max Speed to 30 deg/s
fprintf(s, sprintf('#%d%s%d', 254, 'CSD', 200));

%% Query

fprintf(s, sprintf('#%d%s', 3, 'QSD')); % Query session value for maximum speed

speedString = fscanf(s , '%s'); % to check speed
%% Extract last two digits from string
pat = digitsPattern + textBoundary;

newStr = extract(speedString,pat);
disp(newStr);
%% Convert string to double
% Speed is now the variable for the config speed

Speed = str2double(newStr);
%% Open gripper
fprintf(s, sprintf('#%d%s%d', 5, 'D', -155)); % 0 is closed , range to -500 to open
fprintf(s, sprintf('#%d%s%d', 1, 'D', -180));
%%
fprintf(s, sprintf('#%d%s%d', 254, 'LED', 1)); % Turn Red
%%
fprintf(s, sprintf('#%d%s%d', 254, 'LED', 1)); % Turn Red

%%
Qmove = sprintf('#%d%s', 3 , 'QD');
fprintf(s, Qmove);
getposition = fscanf(s , '*3QD%u');
%%
Point1Pull(s,Robot1);
pause(1);
IdlePosition(s,Robot1);
pause(1);
Point4Place(s,Robot1);
%%
IncubatorIdle(s,Robot1);
%% Robot arm Idle Position Final
pause(1)
IdlePosition(s,Robot1);
pause(3);
Point1Pull(s,Robot1);
pause(5);
IncubatorIdle(s,Robot1);
pause(4);
Point4Place(s,Robot1);
pause(2);
IdlePosition(s,Robot1);
pause(3);


Point2Pull(s,Robot1);
pause(5);
IncubatorIdle(s,Robot1);
pause(4);
Point5Place(s,Robot1);
pause(2);
IdlePosition(s,Robot1);
pause(3);


Point3Pull(s,Robot1);
pause(5);
IncubatorIdle(s,Robot1);
pause(4);
Point6Place(s,Robot1);
pause(3);
IncubatorIdle(s,Robot1);
pause(3);
IdlePosition(s,Robot1);
pause(5);
CloseCover(s,Robot1);
pause(5);

%%
IdlePosition(s,Robot1);
pause(2);
StartStopButton(s,Robot1);
%%
fprintf(s, sprintf('#%d%s%d', 254, 'LED', 5)); % Turn teal for 5 sec
%%
IdlePosition(s,Robot1);
pause(4);
Point1Pull(s,Robot1);

%%
IncubatorIdle(s,Robot1);
pause(3);
Point4Pick(s,Robot1);
%%
IncubatorIdle(s,Robot1);
%%
fprintf(s, sprintf('#%d%s%d', 4, 'D', -780));
%%
Point6Pick(s,Robot1);
%%
fprintf(s, sprintf('#%d%s%d', 4, 'D', -750));
%%
pause(1)
IdlePosition(s,Robot1);
pause(3);
Point3Pull(s,Robot1);
pause(5);
IncubatorIdle(s,Robot1);
pause(3);
Point6Place(s,Robot1);

%% Points
fprintf(s, sprintf('#%d%s%d', 1, 'D', 845));
% Shoulder servo motor
fprintf(s, sprintf('#%d%s%d', 2, 'D', 0));
% Elbow servo motor
fprintf(s, sprintf('#%d%s%d', 3, 'D', 280)); %150  %280 good
% Wrist servo motor
fprintf(s, sprintf('#%d%s%d', 4, 'D', -300));
% Gripper servo motor
fprintf(s, sprintf('#%d%s%d', 5, 'D', -55)); % 0 is closed , range to -500 to open

%%
fprintf(s, sprintf('#%d%s', 4, 'QC')); % Query session value for current
speedString = fscanf(s , '%s'); % to check current
pat = digitsPattern + textBoundary;
newStr = extract(speedString,pat);
disp(newStr);
pause(3);
fprintf(s, sprintf('#%d%s%d', 4, 'D', -630)); %Wrist lowers to prevent collision
pause(2);
fprintf(s, sprintf('#%d%s%d', 1, 'D', 740));
fprintf(s, sprintf('#%d%s%d', 2, 'D', 130));
fprintf(s, sprintf('#%d%s%d', 3, 'D', 320));
fprintf(s, sprintf('#%d%s%d', 4, 'D', -630));
%%
fprintf(s, sprintf('#%d%s', 4, 'QC')); % Query session value for current
speedString = fscanf(s , '%s'); % to check current
pat = digitsPattern + textBoundary;
newStr = extract(speedString,pat);
disp(newStr);
%%
IncubatorIdle(s,Robot1);
%%
IdlePosition(s,Robot1);
%%

fprintf(s, sprintf('#%d%s%d', 4, 'D', -600)); %Wrist lowers to prevent collision
pause(2);
fprintf(s, sprintf('#%d%s%d', 1, 'D', 770));
fprintf(s, sprintf('#%d%s%d', 2, 'D', 130));
fprintf(s, sprintf('#%d%s%d', 3, 'D', 320));
fprintf(s, sprintf('#%d%s%d', 4, 'D', -600));
fprintf(s, sprintf('#%d%s', 4, 'QC')); % Query session value for current
speedString = fscanf(s , '%s'); % to check current
pat = digitsPattern + textBoundary;
newStr = extract(speedString,pat);
disp(newStr);
pause(4);

%% Final Test
IdlePosition(s,Robot1);
pause(1);
Point1Pull(s,Robot1);
pause(1);
IncubatorIdle(s,Robot1);
pause(1);
Point4Place(s,Robot1);
pause(1);


%%

IncubatorIdle(s,Robot1);
pause(1);
Point4Pick(s,Robot1);
pause(1);
Point8Place(s,Robot1);
pause(3);




