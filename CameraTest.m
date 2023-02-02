%% This program has no functionality. It checks which port is cam1 or cam2 since both
% webcam shares the same name
%% Set webcam
% Since both webcam has the same model and name, it requires identification
cam1= webcam(2);  %Cam1 is always the tubes camera
cam2= webcam(1);  %Cam2 is always the gesture camera

%%
% Cam 1 = tubes, Cam 2 = Gesture
I = snapshot(cam1);
    figure
    imshow(I)
    axis on %Shows axis value to determine position
    hold on

%%    

I = snapshot(cam2);
    figure
    imshow(I)
    axis on %Shows axis value to determine position
    hold on