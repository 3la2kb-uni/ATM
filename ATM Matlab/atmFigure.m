function varargout = atmFigure(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @atmFigure_OpeningFcn, ...
                   'gui_OutputFcn',  @atmFigure_OutputFcn, ...
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

function atmFigure_OpeningFcn(hObject, eventdata, handles, varargin)
    global curlReply
    handles.cardInfoText.String = strcat("Balance: ", curlReply.results(1).cardBalance);
    handles.output = hObject;
    guidata(hObject, handles);

function varargout = atmFigure_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


function depositButton_Callback(hObject, eventdata, handles)
    global depositWithdraw
    depositWithdraw = "Deposit";
    close;
    depositWithdrawFigure('depositWithdrawFigure.fig');

function withdrawButton_Callback(hObject, eventdata, handles)
    global depositWithdraw
    depositWithdraw = "Withdraw";
    close;
    depositWithdrawFigure('depositWithdrawFigure.fig');


function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
