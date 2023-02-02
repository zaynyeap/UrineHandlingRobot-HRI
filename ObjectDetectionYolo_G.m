% ObjectDetectionYolo.m trains taken picture into CNN
% To create detection model for hand start gesture.
%% Save as .mat format from Image Labeller
save("StartGesture.mat", "StartGesture") 
%% Unload Table
data = load("StartGesture.mat");

%% set data
StartGesture = data.StartGesture;

%% Display first few rows of the data set.
StartGesture(1:4,:);

%% 60% for data training, 10% for validation
rng("default");
shuffledIndices = randperm(height(StartGesture));
idx = floor(0.6 * length(shuffledIndices) );

trainingIdx = 1:idx;
trainingDataTbl = StartGesture(shuffledIndices(trainingIdx),:);

validationIdx = idx+1 : idx + 1 + floor(0.1 * length(shuffledIndices) );
validationDataTbl = StartGesture(shuffledIndices(validationIdx),:);

testIdx = validationIdx(end)+1 : length(shuffledIndices);
testDataTbl = StartGesture(shuffledIndices(testIdx),:);

%% Image data store
imdsTrain = imageDatastore(trainingDataTbl{:,"imageFilename"});
bldsTrain = boxLabelDatastore(trainingDataTbl(:,"StartGesture"));

imdsValidation = imageDatastore(validationDataTbl{:,"imageFilename"});
bldsValidation = boxLabelDatastore(validationDataTbl(:,"StartGesture"));

imdsTest = imageDatastore(testDataTbl{:,"imageFilename"});
bldsTest = boxLabelDatastore(testDataTbl(:,"StartGesture"));

%% Combine image and box label
trainingData = combine(imdsTrain,bldsTrain);
validationData = combine(imdsValidation,bldsValidation);
testData = combine(imdsTest,bldsTest);

%% Validation
validateInputData(trainingData);
validateInputData(validationData);
validateInputData(testData);

%% Display one training images and box labels
data = read(trainingData);
I = data{1};
bbox = data{2};
annotatedImage = insertShape(I,"Rectangle",bbox);
annotatedImage = imresize(annotatedImage,2);
figure
imshow(annotatedImage)
reset(trainingData);

%% Create YOLOv4 Object Detector Network

inputSize = [320 320 3]; %good speed training 320x320 %balance mode 416x 416 %608 * 608 * 3 best quality
className = "StartGesture";
%% estimate Anchor Boxes function to estimate anchor boxes
rng("default")
trainingDataForEstimation = transform(trainingData,@(data)preprocessData(data,inputSize));
numAnchors = 9;
[anchors,meanIoU] = estimateAnchorBoxes(trainingDataForEstimation,numAnchors);

area = anchors(:, 1).*anchors(:,2);
[~,idx] = sort(area,"descend");

anchors = anchors(idx,:);
anchorBoxes = {anchors(1:3,:)
    anchors(4:6,:)
    anchors(7:9,:)
    };

%% Detector
detector = yolov4ObjectDetector("csp-darknet53-coco",className,anchorBoxes,InputSize=inputSize);

%% Perform Data Augmentation
augmentedTrainingData = transform(trainingData,@augmentData);
augmentedData = cell(4,1);
for k = 1:4
    data = read(augmentedTrainingData);
    augmentedData{k} = insertShape(data{1},"rectangle",data{2});
    reset(augmentedTrainingData);
end
figure
montage(augmentedData,BorderSize=10)

%% Specify Training Options
options = trainingOptions("adam",...
    GradientDecayFactor=0.9,...
    SquaredGradientDecayFactor=0.999,...
    InitialLearnRate=0.001,...
    LearnRateSchedule="none",...
    MiniBatchSize=2,...
    L2Regularization=0.0005,...
    MaxEpochs=70,...
    BatchNormalizationStatistics="moving",...
    DispatchInBackground=true,...
    ResetInputNormalization=false,...
    Shuffle="every-epoch",...
    VerboseFrequency=20,...
    CheckpointPath=tempdir,...
    ValidationData=validationData);

%% Train YOLO v4 Object Detector
doTraining = true;
if doTraining       
    % Train the YOLO v4 detector.
    [detector,info] = trainYOLOv4ObjectDetector(augmentedTrainingData,detector,options);
end

%% Test out model on webcam
% Since it does not support real-time capture, an image will be captured
% every one second to detect test tubes

cam=webcam;
I = snapshot(cam);
[bboxes1,scores,labels] = detect(detector,I);
TF1 = isempty(labels); %Check if any object detected.
if (TF1 == 1)
    figure
    imshow(I); %If no object detected, just display figure
    axis on
    hold on
else
    I = insertObjectAnnotation(I,"rectangle",bboxes1,scores);
    figure
    imshow(I)
    axis on %Shows axis value to determine position
    hold on
end 

%% Load trained model (When MATLAB rebooted)
% Trained Model was saved as TrainedModel.mat
detector = load("GestureTrained.mat");
detector = detector.detector;

%% Position of test tubes

% Position bboxes[1] determines first detected object from the left
% Position bboxes[2] determines second detected object from the left
% Position bboxes[3] determines third detected object from the left
% Based on the scale on the diagram, I have concluded that: 
% position 1 < 100, position 2 >200, <300, position 3 >400, <500

%IF condition for position 1
if (bboxes(1) < 100) 
    disp('First Test Tube present');
elseif (bboxes(1) < 300) && (bboxes(1) > 200) 
    disp('Second Test Tube present');
elseif (bboxes(1) < 500) && (bboxes(1)>400)
    disp('Third Test Tube present');
end

% IF condition for position 2
if (bboxes(2) < 300) && (bboxes(2) > 200) 
    disp('Second Test Tube present');
elseif (bboxes(2) < 500) && (bboxes(2)>400)
    disp('Third Test Tube present');
end

%IF condition for position 3
if (bboxes(3) < 500) && (bboxes(3)>400)
    disp('Third Test Tube present');
end

%% Evaluate Dataset

detectionResults = detect(detector,testData);
[ap,recall,precision] = evaluateDetectionPrecision(detectionResults,testData);

figure
plot(recall,precision)
xlabel("Recall")
ylabel("Precision")
grid on
ap = ap* 100;
ap = round(ap,2); % Round up to two decimal place
title(sprintf("Average Precision = %2f",ap))
title("Average Precision = "+ num2str(ap) + "%");

