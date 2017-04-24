function varargout = energybalpar_description(varargin)
% ENERGYBALPAR_DESCRIPTION MATLAB code for energybalpar_description.fig
%      ENERGYBALPAR_DESCRIPTION, by itself, creates a new ENERGYBALPAR_DESCRIPTION or raises the existing
%      singleton*.
%
%      H = ENERGYBALPAR_DESCRIPTION returns the handle to a new ENERGYBALPAR_DESCRIPTION or the handle to
%      the existing singleton*.
%
%      ENERGYBALPAR_DESCRIPTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ENERGYBALPAR_DESCRIPTION.M with the given input arguments.
%
%      ENERGYBALPAR_DESCRIPTION('Property','Value',...) creates a new ENERGYBALPAR_DESCRIPTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before energybalpar_description_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to energybalpar_description_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help energybalpar_description

% Last Modified by GUIDE v2.5 22-Oct-2015 13:57:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @energybalpar_description_OpeningFcn, ...
                   'gui_OutputFcn',  @energybalpar_description_OutputFcn, ...
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


% --- Executes just before energybalpar_description is made visible.
function energybalpar_description_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to energybalpar_description (see VARARGIN)

% Choose default command line output for energybalpar_description
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes energybalpar_description wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = energybalpar_description_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
