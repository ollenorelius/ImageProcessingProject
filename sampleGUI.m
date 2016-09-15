function varargout = sampleGUI(varargin)

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sampleGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @sampleGUI_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before sampleGUI is made visible.
function sampleGUI_OpeningFcn(hObject, eventdata, handles, varargin)

global im1 im2 im compMethodStr blockSize compRatio waveletStr;

% Display Input Image
handles.output = hObject;
im1 = imread('sampleImages\Chalmers.jpg');
im2 = imread('sampleImages\Penny.jpg');
im = im1;
axes(handles.inputPane)
image(im)
axis off
axis image
axes(handles.outputPane)
axis off
axis image

% Initialise variables
compMethodStr = 'D';
blockSize = 4;
compRatio = 8;
waveletStr = 'b';

% Choose default command line output for sampleGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sampleGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sampleGUI_OutputFcn(hObject, eventdata, handles) 
% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in inputImage.
function inputImage_Callback(hObject, eventdata, handles)

% Set current image (im) and display
global im1 im2 im;
contents = cellstr(get(hObject,'String'));
selPicName = contents{get(hObject,'Value')};
axes(handles.inputPane)
if selPicName(1) == 'C'
    im = im1;
else
    im = im2;
end
image(im)
axis off
axis image
    

% --- Executes during object creation, after setting all properties.
function inputImage_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in compMethod.
function compMethod_Callback(hObject, eventdata, handles)

global compMethodStr;
contents = cellstr(get(hObject,'String'));
compMethodStr = contents{get(hObject,'Value')};


% --- Executes during object creation, after setting all properties.
function compMethod_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function rmsTxt_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function rmsTxt_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function compRatTxt_Callback(hObject, eventdata, handles)

global compRatio;
content = cellstr(get(hObject,'String'));
compRatio = abs(str2double(content));


% --- Executes during object creation, after setting all properties.
function compRatTxt_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in blockSize.
function blockSize_Callback(hObject, eventdata, handles)

global blockSize;
contents = cellstr(get(hObject,'String'));
blockSize = str2double(contents{get(hObject,'Value')});


% --- Executes during object creation, after setting all properties.
function blockSize_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in wavelet.
function wavelet_Callback(hObject, eventdata, handles)

global waveletStr;
contents = cellstr(get(hObject,'String'));
waveletStr = contents{get(hObject,'Value')};


% --- Executes during object creation, after setting all properties.
function wavelet_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% !!!!!!!!!!!!!! EXECUTE COMPRESSION !!!!!!!!!!!!!!!!!!
function compressBtn_Callback(hObject, eventdata, handles)

global im compMethodStr blockSize compRatio waveletStr;

% Call compression method
if compMethodStr(1) == 'W' % Wavelet transform

else % DCT
     % rms = DCT_main(im, comp, showImages) !!! must edit image display in 
end

% Display output image (outputPane) & RMS error (rmsTxt)
