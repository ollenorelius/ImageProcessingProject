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

global im1 im2 im3 im4 im5 im6 im compMethodStr blockSize compRatio ...
    waveletStr noLevels quality;

% Display Input Image
handles.output = hObject;
im1 = imread('sampleImages\Chalmers.jpg');
im2 = imread('sampleImages\Penny.jpg');
im3 = imread('sampleImages\Dank.jpg');
im4 = imread('sampleImages\Glow.tif');
im5 = imread('sampleImages\Rock.tif');
im6 = imread('sampleImages\Line.bmp');
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
waveletStr = 'bior4.4';
noLevels = 3;
quality = 1;

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
global im1 im2 im3 im4 im5 im6 im;
contents = cellstr(get(hObject,'String'));
selPicName = contents{get(hObject,'Value')};
axes(handles.inputPane)
if selPicName(1) == 'C'
    im = im1;
elseif selPicName(1) == 'P'
    im = im2;
elseif selPicName(1) == 'D'
    im = im3;
elseif selPicName(1) == 'G'
    im = im4;
elseif selPicName(1) == 'R'
    im = im5;
else
    im = im6;
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
if compMethodStr(1) == 'W' % Wavelet transform
    set(handles.blockSize,'Enable','inactive')
    set(handles.noLevels,'Enable','on')
    set(handles.wavelet,'Enable','on')
else % DCT
    set(handles.blockSize,'Enable','on')
    set(handles.wavelet,'Enable','inactive')
    set(handles.noLevels,'Enable','inactive')
end
 


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

global im compMethodStr blockSize compRatio waveletStr noLevels quality;

% Call compression method
if compMethodStr(1) == 'W' 
    [rms,reconIm, coeffIm] = WPT_main(im, compRatio, waveletStr, noLevels);
else 
    parallel = 0;
    [rms,reconIm, coeffIm] = DCT_main(im, quality, blockSize, 0, parallel);
end

% Display output image (outputPane), coefficients & RMS error
set(handles.rmsTxt,'String',num2str(rms))
axes(handles.outputPane)
image(reconIm)
axis off
axis image
axes(handles.coeffPane)
image(coeffIm)
axis off
axis image



function noLevels_Callback(hObject, eventdata, handles)

global noLevels;
content = cellstr(get(hObject,'String'));
noLevels = round(abs(str2double(content)));



function noLevels_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function qualityTxt_Callback(hObject, eventdata, handles)

global quality;
content = cellstr(get(hObject,'String'));
quality = abs(str2double(content));



function qualityTxt_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
