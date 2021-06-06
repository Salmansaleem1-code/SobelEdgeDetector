function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 06-Mar-2021 14:46:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @gui_OpeningFcn, ...
    'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


function edit1_CreateFcn(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function[no]= edit1__KeyPressFcn2(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

str=get(handles.edit1,'String') ;
no=str2double(str);


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


sigma=edit1__KeyPressFcn2(hObject, eventdata, handles);

if sigma>=0
    x=[-1 0 1; -1 0 1; -1 0 1];
    y=[-1 -1 -1;0 0 0; -1 -1 -1];
    img=gaussian(sigma,x,y);
    gblur_img=img;
    real_img=imread('chaplin.jpg');
    figure();
    subplot(1,2,1), imshow(uint8(real_img))
    title('real image');
    subplot(1,2,2),imshow(uint8(gblur_img));
    title('3X3 gaussian blur image');
    
    x=[-1 0 1 -1 1; -1 0 1 -1 1; -1 0 1 -1 1;-1 0 1 -1 1;-1 0 1 -1 1];
    y=[-1 -1 -1 -1 -1;0 0 0 0 0; -1 -1 -1 -1 -1;-1 -1 -1 -1 -1;-1 -1 -1 -1 -1];
   
    img=gaussian(sigma,x,y);
    gblur_img=img;
    real_img=imread('chaplin.jpg');
    figure();
    subplot(1,2,1), imshow(uint8(real_img))
    title('real image');
    subplot(1,2,2),imshow(uint8(gblur_img));
    title('5x5 gaussian blur image');
    
else
    sigma=0.9;
    
    x=[-1 0 1; -1 0 1; -1 0 1];
    y=[-1 -1 -1;0 0 0; -1 -1 -1];
    img=gaussian(sigma,x,y);
    gblur_img=img;
    real_img=imread('chaplin.jpg');
    figure();
    subplot(1,2,1), imshow(uint8(real_img))
    title('real image');
    subplot(1,2,2),imshow(uint8(gblur_img));
    title('3x3gaussian blur image');
    %%%%%%%%%%%%%%%%
     x=[-1 0 1 -1 1; -1 0 1 -1 1; -1 0 1 -1 1;-1 0 1 -1 1;-1 0 1 -1 1];
    y=[-1 -1 -1 -1 -1;0 0 0 0 0; -1 -1 -1 -1 -1;-1 -1 -1 -1 -1;-1 -1 -1 -1 -1];
   
    img=gaussian(sigma,x,y);
    gblur_img=img;
    real_img=imread('chaplin.jpg');
    figure();
    subplot(1,2,1), imshow(uint8(real_img))
    title('real image');
    subplot(1,2,2),imshow(uint8(gblur_img));
    title('5x5 gaussian blur image');
    
    
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sigma=edit1__KeyPressFcn2(hObject, eventdata, handles);

if sigma>=0
    x=[-1 0 1; -1 0 1; -1 0 1];
    y=[-1 -1 -1;0 0 0; -1 -1 -1];
    Gx=[-1 0 1; -2 0 2; -1 0 1];
    Gy=[-1 -2 -1; 0 0 0; 1 2 1];
    img_smooth=gaussian(sigma,x,y);
    img2=sobel(img_smooth,Gx,Gy);
    sobel_img=img2;
    real_img=imread('chaplin.jpg');
    figure();
    
    subplot(1,2,1), imshow(uint8(real_img))
    title('real image');
    subplot(1,2,2),imshow(uint8(sobel_img));
    title('3x3 sobel operator image ');
    gx=[-1 -2 0 2 1; -4 -8 0 8 4;-6 -12 0 12 6; -4 -8 0 8 4; -1 -2 0 2 1];
    gy=[1 4 6 4 1; 0 8 12 8 2; 2 0 0 0 0 ;-2 -8 -12 -8 -2; -1 -4 -6 -4 -1];
    img_smooth=gaussian(sigma,x,y);
    img2=sobel(img_smooth,gx,gy);
    sobel_img=img2;
    real_img=imread('chaplin.jpg');
    figure();
    
    subplot(1,2,1), imshow(uint8(real_img))
    title('real image');
    subplot(1,2,2),imshow(uint8(sobel_img));
     title('5x5 sobel operator image ');
else
    sigma=0.9;
    
     x=[-1 0 1; -1 0 1; -1 0 1];
    y=[-1 -1 -1;0 0 0; -1 -1 -1];
    Gx=[-1 0 1; -2 0 2; -1 0 1];
    Gy=[-1 -2 -1; 0 0 0; 1 2 1];
    img_smooth=gaussian(sigma,x,y);
    img2=sobel(img_smooth,Gx,Gy);
    sobel_img=img2;
    real_img=imread('chaplin.jpg');
    figure();
    
    subplot(1,2,1), imshow(uint8(real_img))
    title('real image');
    subplot(1,2,2),imshow(uint8(sobel_img));
    title('3x3 sobel operator image ');
    gx=[-1 -2 0 2 1; -4 -8 0 8 4;-6 -12 0 12 6; -4 -8 0 8 4; -1 -2 0 2 1];
    gy=[1 4 6 4 1; 0 8 12 8 2; 2 0 0 0 0 ;-2 -8 -12 -8 -2; -1 -4 -6 -4 -1];
    img_smooth=gaussian(sigma,x,y);
    img2=sobel(img_smooth,gx,gy);
    sobel_img=img2;
    real_img=imread('chaplin.jpg');
    figure();
    
    subplot(1,2,1), imshow(uint8(real_img))
    title('real image');
    subplot(1,2,2),imshow(uint8(sobel_img));
     title('5x5 sobel operator image ');
    
end

