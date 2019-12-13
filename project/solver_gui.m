function varargout = solver_gui(varargin)
% SOLVER_GUI MATLAB code for solver_gui.fig
%      SOLVER_GUI, by itself, creates a new SOLVER_GUI or raises the existing
%      singleton*.
%
%      H = SOLVER_GUI returns the handle to a new SOLVER_GUI or the handle to
%      the existing singleton*.
%
%      SOLVER_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SOLVER_GUI.M with the given input arguments.
%
%      SOLVER_GUI('Property','Value',...) creates a new SOLVER_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before solver_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to solver_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help solver_gui

% Last Modified by GUIDE v2.5 09-Dec-2019 23:21:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @solver_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @solver_gui_OutputFcn, ...
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


% --- Executes just before solver_gui is made visible.
function solver_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% get the folder
folder_name = uigetdir;
% get what is inside the folder
Infolder = dir(folder_name);
% Initialize the cell of string that will be update in the list box
MyListOfFiles = [];
% Loop on every element in the folder and update the list
for i = 1:length(Infolder)
   if Infolder(i).isdir==0
       MyListOfFiles{end+1,1} = Infolder(i).name;
   end
end
% update the listbox with the result
set(handles.scroll1,'String',MyListOfFiles)

% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to solver_gui (see VARARGIN)

% Choose default command line output for solver_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes solver_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = solver_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in usrPsh.
function usrPsh_Callback(hObject, eventdata, handles)
% hObject    handle to usrPsh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
allItems = handles.scroll1.String;     % A cell array of all strings in the popup.
selectedIndex = handles.scroll1.Value; % An integer saying which item has been selected.
x = allItems{selectedIndex};  % The one, single string which was selected.
answerR =  math_solver(x);
%disp(answerR);
 set(handles.dispAns,'String',answerR); %edit1 being Tag of ur edit box
 set(handles.axes1, 'visible', 'on')
 imshow(x, 'Parent', handles.axes1)



function usrInput_Callback(hObject, eventdata, handles)
% hObject    handle to usrInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of usrInput as text
%        str2double(get(hObject,'String')) returns contents of usrInput as a double


% --- Executes during object creation, after setting all properties.
function usrInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to usrInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in scroll1.
function scroll1_Callback(hObject, eventdata, handles)
% hObject    handle to scroll1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns scroll1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from scroll1


% --- Executes during object creation, after setting all properties.
function scroll1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scroll1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
