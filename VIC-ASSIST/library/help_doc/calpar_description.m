function varargout = calpar_description(varargin)
% CALPAR_DESCRIPTION MATLAB code for calpar_description.fig
%      CALPAR_DESCRIPTION, by itself, creates a new CALPAR_DESCRIPTION or raises the existing
%      singleton*.
%
%      H = CALPAR_DESCRIPTION returns the handle to a new CALPAR_DESCRIPTION or the handle to
%      the existing singleton*.
%
%      CALPAR_DESCRIPTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CALPAR_DESCRIPTION.M with the given input arguments.
%
%      CALPAR_DESCRIPTION('Property','Value',...) creates a new CALPAR_DESCRIPTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before calpar_description_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to calpar_description_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help calpar_description

% Last Modified by GUIDE v2.5 18-May-2016 10:11:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @calpar_description_OpeningFcn, ...
                   'gui_OutputFcn',  @calpar_description_OutputFcn, ...
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


% --- Executes just before calpar_description is made visible.
function calpar_description_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to calpar_description (see VARARGIN)

% Choose default command line output for calpar_description
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes calpar_description wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = calpar_description_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
