function varargout = routingpar_description(varargin)
% ROUTINGPAR_DESCRIPTION MATLAB code for routingpar_description.fig
%      ROUTINGPAR_DESCRIPTION, by itself, creates a new ROUTINGPAR_DESCRIPTION or raises the existing
%      singleton*.
%
%      H = ROUTINGPAR_DESCRIPTION returns the handle to a new ROUTINGPAR_DESCRIPTION or the handle to
%      the existing singleton*.
%
%      ROUTINGPAR_DESCRIPTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ROUTINGPAR_DESCRIPTION.M with the given input arguments.
%
%      ROUTINGPAR_DESCRIPTION('Property','Value',...) creates a new ROUTINGPAR_DESCRIPTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before routingpar_description_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to routingpar_description_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help routingpar_description

% Last Modified by GUIDE v2.5 13-Oct-2015 13:27:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @routingpar_description_OpeningFcn, ...
                   'gui_OutputFcn',  @routingpar_description_OutputFcn, ...
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


% --- Executes just before routingpar_description is made visible.
function routingpar_description_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to routingpar_description (see VARARGIN)

% Choose default command line output for routingpar_description
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes routingpar_description wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = routingpar_description_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu_selectpar.
function popupmenu_selectpar_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_selectpar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_selectpar contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_selectpar

parname = {'BASEFLOW','JULY_TAVG_SUPPLIED','ORGANIC_FRACT','ROOT_ZONES','VEGPARAM_ALBEDO',...
    'ALBEDO_SRC','VEGPARAM_LAI','LAI_SRC','VEGLIB_VEGCOVER','VEGPARAM_VEGCOVER','VEGCOVER_SRC'};

eval(['set(handles.uipanel_',parname{get(hObject,'Value')},',''visible'',''on'');']);
ind = (1:11);
ind(get(hObject,'Value'))=[];
for i = 1:10
    eval(['set(handles.uipanel_',parname{ind(i)},',''visible'',''off'');']);
end


% --- Executes during object creation, after setting all properties.
function popupmenu_selectpar_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_selectpar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
