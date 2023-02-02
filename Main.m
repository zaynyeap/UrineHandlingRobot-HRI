% This is the main program of the operations
% Urine tubes will be picked up with either condition: 
% 1. When all 3 slots have been taken up by urine tubes.
% 2. When time has passed 5 seconds. 
% If no tubes present, then the cycle restarts

% Create port and add terminator (\r)
s = serial('COM3', 'BaudRate', 115200);
s.Terminator = 'CR';
fopen(s);

%% Configuration
% Configure Max speed of base to 120 deg/sec
fprintf(s, sprintf('#%d%s%d', 1, 'CSD', 120));
% Configure Max speed of shoulder and elbow to 60 deg/sec
fprintf(s, sprintf('#%d%s%d', 2, 'CSD', 60));
fprintf(s, sprintf('#%d%s%d', 3, 'CSD', 60));
% Configure Max speed of wrist to gripper to 50 deg/sec
fprintf(s, sprintf('#%d%s%d', 4, 'CSD', 50));
fprintf(s, sprintf('#%d%s%d', 5, 'CSD', 50));

%% Create Robot model with DH Table
%Set 0 for xyz
x = 0;
y = 0;
z = 0;
% Dimension taken from official lynxmotion website (inches)
d1 = 4.13;   % Base length to shoulder length
d2 = 5.61;   % Shoulder length to elbow length
d3 = 6.39;   % Elbow length to wrist length
d4 = 4.52;   % Wrist length to end effector
            
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

%% Go to robot Idle position
IdlePosition(s,Robot1);
fprintf(s, sprintf('#%d%s%d', 254, 'LED', 2)); % Turn Green

%% Load Pre-trained urine tube model
detector = load("TrainedModel.mat");
detector = detector.detector;
%% Load Pre-trained Gesture model
detector2 = load("GestureTrained.mat");
detector2 = detector2.detector;
%% Set webcam
% Since both webcam has the same model and name, it requires identification
cam1= webcam(2);  %Cam1 is always the tubes camera
cam2= webcam(1);  %Cam2 is always the gesture camera
%% Main Code 
% Go to robot Idle position
IdlePosition(s,Robot1);
fprintf(s, sprintf('#%d%s%d', 254, 'LED', 2)); % Turn LED Green = Indicates Available 
    flag1 = 0; % Initialisation of Flag variable
    flag2 = 0; 
    flag3 = 0;
    flag11 = 0; % Flag 11 onwards is for second operation
    flag22 = 0;
    flag33 = 0;
    flag111 = 0; %% Flag 111 onwards is for third operation
    flag222 = 0;
    flag333 = 0;

% Start of cycle 1
while 1
    I = snapshot(cam1);
    [bboxes,scores,labels] = detect(detector,I); % Detection for tubes
    I2 = snapshot(cam2);
    [bboxes2,scores2,labels2] = detect(detector2,I2); % Detection for gesture

    TF1 = isempty(labels); %TF1 and TF2 is checking if labels are empty
    TF2 = isempty(labels2);
        if (TF1 == 1 || TF2 == 1) %Condition if tubes and gesture are either absent, code will not execute
            disp('Do Nothing');
        else                      % Condition when both gesture and tubes present, code executes
        I = insertObjectAnnotation(I,"rectangle",bboxes,scores); % Place annotation boxes (bboxes)
        I2 = insertObjectAnnotation(I2,"rectangle",bboxes2,scores2); % Place annotation boxes (bboxes)
            %IF condition for position 1
            if (bboxes(1) < 100) 
                flag1 = 1;
            elseif (bboxes(1) < 300) && (bboxes(1) > 200) 
                flag2 = 1;
            elseif (bboxes(1) < 500) && (bboxes(1)>400)
                flag3 = 1;
            end

            % IF condition for position 2
            if (bboxes(2) < 300) && (bboxes(2) > 200) 
                flag2 = 1;
            elseif (bboxes(2) < 500) && (bboxes(2)>400)
                flag3 = 1;
            end

            %IF condition for position 3
            if (bboxes(3) < 500) && (bboxes(3)>400)
                flag3 = 1;
            end
            break;
            
        end
end
               
% Show camera image
figure('Name','Gesture Command')
imshow(I2)
axis on %Shows axis value to determine position
hold on
figure('Name', 'Urine Tubes ')
imshow(I)
axis on %Shows axis value to determine position
hold on

% Execution for Cycle 1

fprintf(s, sprintf('#%d%s%d', 254, 'LED', 1)); % Turn LED Red indicates Robot is busy

if(flag1 == 1)
    Point1Pull(s,Robot1);
    pause(1);
    IncubatorIdle(s,Robot1);
    pause(1);
    Point4Place(s,Robot1);
    pause(1);
    IncubatorIdle(s,Robot1);
    IdlePosition(s,Robot1);
    pause(1);
end

if (flag2 == 1)
    Point2Pull(s,Robot1);
    pause(1);
    IncubatorIdle(s,Robot1);
    pause(1);
    Point5Place(s,Robot1);
    pause(1);
    IncubatorIdle(s,Robot1);
    IdlePosition(s,Robot1);
    pause(1);
end

if (flag3 == 1)
    Point3Pull(s,Robot1);
    pause(1);
    IncubatorIdle(s,Robot1);
    pause(1);
    Point6Place(s,Robot1);
    pause(1);
    IncubatorIdle(s,Robot1);
    IdlePosition(s,Robot1);
    pause(1);
end

fprintf(s, sprintf('#%d%s%d', 254, 'LED', 2)); % Turn LED Green = Indicates Robot is Available
% Start of cycle 2
while 1
    if(flag1==1 && flag2==1 && flag3==1 ) % If all tubes has been picked before, break loop
        break;
    end

    I = snapshot(cam1);
    [bboxes,scores,labels] = detect(detector,I); % Detection for tubes
    I2 = snapshot(cam2);
    [bboxes2,scores2,labels2] = detect(detector2,I2); % Detection for gesture

    TF1 = isempty(labels); %TF1 and TF2 is checking if labels are empty
    TF2 = isempty(labels2);
        if (TF1 == 1 || TF2 == 1) %Condition if tubes and gesture are either absent, code will not execute
            disp('Do Nothing');
        else                      % Condition when both gesture and tubes present, code executes
        I = insertObjectAnnotation(I,"rectangle",bboxes,scores); % Place annotation boxes (bboxes)
        I2 = insertObjectAnnotation(I2,"rectangle",bboxes2,scores2); % Place annotation boxes (bboxes)
            %IF condition for position 1
            if (bboxes(1) < 100) 
                flag11 = 1;
            elseif (bboxes(1) < 300) && (bboxes(1) > 200) 
                flag22 = 1;
            elseif (bboxes(1) < 500) && (bboxes(1)>400)
                flag33 = 1;
            end

            % IF condition for position 2
            if (bboxes(2) < 300) && (bboxes(2) > 200) 
                flag22 = 1;
            elseif (bboxes(2) < 500) && (bboxes(2)>400)
                flag33 = 1;
            end

            %IF condition for position 3
            if (bboxes(3) < 500) && (bboxes(3)>400)
                flag33 = 1;
            end
            break;
            
        end
end

% Show camera image
figure('Name','Gesture Command')
imshow(I2)
axis on %Shows axis value to determine position
hold on
figure('Name', 'Urine Tubes ')
imshow(I)
axis on %Shows axis value to determine position
hold on

% Execution for cycle 2

fprintf(s, sprintf('#%d%s%d', 254, 'LED', 1)); % Turn LED Red indicates Robot is busy

if(flag1 == 1) && (flag2 == 1) && (flag3 == 1)
    disp('Skip');
end

if(flag11 == 1)
    if (flag1== 1)
        disp('Do Nothing');
    else
    flag1 = 1;
        pause(1)
        IdlePosition(s,Robot1);
        pause(1);
        Point1Pull(s,Robot1);
        pause(1);
        IncubatorIdle(s,Robot1);
        pause(1);
        Point4Place(s,Robot1);
        pause(1);
        IncubatorIdle(s,Robot1);
        IdlePosition(s,Robot1);
        pause(1);
    end
end

if (flag22 == 1)
    if (flag2 ==1)
        disp('Do Nothing');
    else
        flag2= 1;
        Point2Pull(s,Robot1);
        pause(1);
        IncubatorIdle(s,Robot1);
        pause(1);
        Point5Place(s,Robot1);
        pause(1);
        IncubatorIdle(s,Robot1);
        IdlePosition(s,Robot1);
        pause(1);
    end
end

if (flag33 == 1)
    if (flag3 == 1)
        disp('Do Nothing');
    else
        flag3= 1;
        Point3Pull(s,Robot1);
        pause(1);
        IncubatorIdle(s,Robot1);
        pause(1);
        Point6Place(s,Robot1);
        pause(1);
        IncubatorIdle(s,Robot1);
        IdlePosition(s,Robot1);
        pause(1);
    end
end

fprintf(s, sprintf('#%d%s%d', 254, 'LED', 2)); % Turn LED Green = Indicates Robot is Available
% Start of cycle 3
while 1
    if(flag1==1 && flag2==1 && flag3==1 ) % If all tubes has been picked before, break loop
        break;
    end

    I = snapshot(cam1);
    [bboxes,scores,labels] = detect(detector,I); % Detection for tubes
    I2 = snapshot(cam2);
    [bboxes2,scores2,labels2] = detect(detector2,I2); % Detection for gesture

    TF1 = isempty(labels); %TF1 and TF2 is checking if labels are empty
    TF2 = isempty(labels2);
        if (TF1 == 1 || TF2 == 1) %Condition if tubes and gesture are either absent, code will not execute
            disp('Do Nothing');
        else                      % Condition when both gesture and tubes present, code executes
        I = insertObjectAnnotation(I,"rectangle",bboxes,scores); % Place annotation boxes (bboxes)
        I2 = insertObjectAnnotation(I2,"rectangle",bboxes2,scores2); % Place annotation boxes (bboxes)
            %IF condition for position 1
            if (bboxes(1) < 100) 
                flag111 = 1;
            elseif (bboxes(1) < 300) && (bboxes(1) > 200) 
                flag222 = 1;
            elseif (bboxes(1) < 500) && (bboxes(1)>400)
                flag333 = 1;
            end

            % IF condition for position 2
            if (bboxes(2) < 300) && (bboxes(2) > 200) 
                flag222 = 1;
            elseif (bboxes(2) < 500) && (bboxes(2)>400)
                flag333 = 1;
            end

            %IF condition for position 3
            if (bboxes(3) < 500) && (bboxes(3)>400)
                flag333 = 1;
            end
            break;
            
        end
end

% Show camera image
figure('Name','Gesture Command')
imshow(I2)
axis on %Shows axis value to determine position
hold on
figure('Name', 'Urine Tubes ')
imshow(I)
axis on %Shows axis value to determine position
hold on

% Execution for cycle 3
fprintf(s, sprintf('#%d%s%d', 254, 'LED', 1)); % Turn LED Red indicates Robot is busy

if(flag1 == 1) && (flag2 == 1) && (flag3 == 1)
    disp('Skip');
end

if(flag111 == 1)
    if (flag1 == 1)
        disp('Do Nothing');
    else
        flag1 = 1;
        pause(1)
        IdlePosition(s,Robot1);
        pause(1);
        Point1Pull(s,Robot1);
        pause(1);
        IncubatorIdle(s,Robot1);
        pause(1);
        Point4Place(s,Robot1);
        pause(1);
        IncubatorIdle(s,Robot1);
        IdlePosition(s,Robot1);
        pause(1);
    end
end

if (flag222 == 1)
    if (flag2 == 1)
        disp('Do Nothing');
    else
        flag2= 1;
        Point2Pull(s,Robot1);
        pause(1);
        IncubatorIdle(s,Robot1);
        pause(1);
        Point5Place(s,Robot1);
        pause(1);
        IncubatorIdle(s,Robot1);
        IdlePosition(s,Robot1);
        pause(1);
    end
end

if (flag333 == 1)
    if (flag3 == 1)
        disp('Do Nothing');
    else
        flag3= 1;
        Point3Pull(s,Robot1);
        pause(1);
        IncubatorIdle(s,Robot1);
        pause(1);
        Point6Place(s,Robot1);
        pause(1);
        IncubatorIdle(s,Robot1);
        IdlePosition(s,Robot1);
        pause(1);
    end
end



IdlePosition(s,Robot1);
pause(6);
CloseCover(s,Robot1);
pause(4);
StartStopButton(s,Robot1);
pause(15);
StartStopButton(s,Robot1);
pause(2);
OpenCover(s,Robot1);
pause(2);
IncubatorIdle(s,Robot1);

if (flag1 == 1)
    Point4Pick(s,Robot1);
    pause(1);
    Point10Place(s,Robot1);
    pause(3);
end
if (flag2 == 1)
    Point5Pick(s,Robot1);
    pause(1);
    Point9Place(s,Robot1);
    pause(3);
end
if(flag3 == 1)
    Point6Pick(s,Robot1);
    pause(1);
    Point8Place(s,Robot1);
    pause(3);
end

IdlePosition(s,Robot1);
pause(3)
