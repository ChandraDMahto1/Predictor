function varargout = PREDICTOR(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PREDICTOR_OpeningFcn, ...
                   'gui_OutputFcn',  @PREDICTOR_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
function PREDICTOR_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

guidata(hObject, handles);

function varargout = PREDICTOR_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;
global x
global y
global r
global s
global a
global t
function setGlobalx(val)
global x
x = val;

function r = getGlobalx
global x
r = x;

function edit1_Callback(hObject, eventdata, handles)        %address
        num1=get(handles.edit1,'String');
        assignin('base','num1',num1);
        setGlobalx(num1)
function edit1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function setGlobaly(lval)
global y
y = lval;

function s = getGlobaly
global y
s = y;

function edit2_Callback(hObject, eventdata, handles)        %name
        num2=get(handles.edit2,'String');
        assignin('base','num2',num2);
        setGlobaly(num2)
        
function edit2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function pushbutton3_Callback(hObject, eventdata, handles)      %call
str=''
set(handles.text7,'string',str);    
rootFolder = fullfile('E:\F\projects(mine)\matlabmachinelearning\101_ObjectCategories');
    imgSets = [ imageSet(fullfile(rootFolder, 'beaver')), ...
                imageSet(fullfile(rootFolder, 'ant')), ...
                imageSet(fullfile(rootFolder, 'butterfly')) ];
    { imgSets.Description }
    [imgSets.Count]   
    minSetCount = min([imgSets.Count]); 
    imgSets = partition(imgSets, minSetCount, 'randomize');
    [imgSets.Count]
    [trainingSets, validationSets] = partition(imgSets, 0.3, 'randomize');
    bag = bagOfFeatures(trainingSets);
    img = read(imgSets(1), 1);
    featureVector = encode(bag, img);
    figure
    bar(featureVector)
    title('Visual word occurrences')
    xlabel('Visual word index')
    ylabel('Frequency of occurrence')
    categoryClassifier = trainImageCategoryClassifier(trainingSets, bag);
    confMatrix = evaluate(categoryClassifier, trainingSets);
    confMatrix = evaluate(categoryClassifier, validationSets);
    mean(diag(confMatrix));
    
    

%function traindata_Callback(hObject, eventdata, handles)
function setGlobala(val)
global a
a = val;

function t = getGlobala
global a
t = a;
setGlobala(0)
function pushbutton1_Callback(hObject, eventdata, handles)      %validate
    r = getGlobalx
    s = getGlobaly
    t = getGlobala
    rootFolder = fullfile('E:\F\projects(mine)\matlabmachinelearning\101_ObjectCategories');
    imgSets = [ imageSet(fullfile(rootFolder, 'beaver')), ...
                imageSet(fullfile(rootFolder, 'ant')), ...
                imageSet(fullfile(rootFolder, 'butterfly')) ];
    { imgSets.Description }
    [imgSets.Count]   
    minSetCount = min([imgSets.Count]); 
    imgSets = partition(imgSets, minSetCount, 'randomize');
    [imgSets.Count]
    [trainingSets, validationSets] = partition(imgSets, 0.3, 'randomize');
    bag = bagOfFeatures(trainingSets);
    img = read(imgSets(1), 1);
    featureVector = encode(bag, img);
    figure
    bar(featureVector)
    title('Visual word occurrences')
    xlabel('Visual word index')
    ylabel('Frequency of occurrence')
    categoryClassifier = trainImageCategoryClassifier(trainingSets, bag);
    confMatrix = evaluate(categoryClassifier, trainingSets);
    confMatrix = evaluate(categoryClassifier, validationSets);
    mean(diag(confMatrix));
    img = imread(fullfile(r,s));
    [labelIdx, scores] = predict(categoryClassifier, img);
    categoryClassifier.Labels(labelIdx)
    disp(ans)
    set(handles.text7,'string',ans);
%function text1_CreateFcn(hObject, eventdata, handles)           %empty string

function text3_CreateFcn(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function text7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
