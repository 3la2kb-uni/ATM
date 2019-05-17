function varargout = depositWithdrawFigure(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @depositWithdrawFigure_OpeningFcn, ...
                   'gui_OutputFcn',  @depositWithdrawFigure_OutputFcn, ...
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


function depositWithdrawFigure_OpeningFcn(hObject, eventdata, handles, varargin)
    global depositWithdraw
    if strcmp(depositWithdraw, "Withdraw")
        handles.actionTitle.String = "Withdraw";
    end
handles.output = hObject;

guidata(hObject, handles);

function varargout = depositWithdrawFigure_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function amountEdit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function threeButton_Callback(hObject, eventdata, handles)
    handles.amountEdit.String = handles.amountEdit.String + "3";

function twoButton_Callback(hObject, eventdata, handles)
    handles.amountEdit.String = handles.amountEdit.String + "2";

function oneButton_Callback(hObject, eventdata, handles)
    handles.amountEdit.String = handles.amountEdit.String + "1";
    
function sixButton_Callback(hObject, eventdata, handles)
    handles.amountEdit.String = handles.amountEdit.String + "6";

function fiveButton_Callback(hObject, eventdata, handles)
    handles.amountEdit.String = handles.amountEdit.String + "5";

function fourButton_Callback(hObject, eventdata, handles)
    handles.amountEdit.String = handles.amountEdit.String + "4";

function nineButton_Callback(hObject, eventdata, handles)
    handles.amountEdit.String = handles.amountEdit.String + "9";

function eightButton_Callback(hObject, eventdata, handles)
    handles.amountEdit.String = handles.amountEdit.String + "8";

function sevenButton_Callback(hObject, eventdata, handles)
    handles.amountEdit.String = handles.amountEdit.String + "7";

function procceedButton_Callback(hObject, eventdata, handles)
    global curlReply
    global depositWithdraw
    dwAmount = str2num(handles.amountEdit.String);
    if strcmp(depositWithdraw, "Withdraw")
        dwAmount = -dwAmount;
    end
    dwAmount = dwAmount + str2num(curlReply.results(1).cardBalance);
    curlReply.results(1).cardBalance = num2str(dwAmount);
    dataString = strcat('{\"Action\":\"Deposit\",\"cardBalance\":\"', num2str(dwAmount), '\"', ',\"objectId\":\"', curlReply.results(1).objectId, '\"}');
    dataString
    curlLink = 'http://206.81.31.74';
    curlLink
    curlRequest = strcat('!curl -X PUT -d ', " ", dataString, " ", curlLink) ;
curlRequest
    cReply = evalc(curlRequest);
    cReply


function zeroButton_Callback(hObject, eventdata, handles)
    handles.amountEdit.String = handles.amountEdit.String + "0";
    
function deleteButton_Callback(hObject, eventdata, handles)
        handles.amountEdit.String = handles.amountEdit.String(1:end-1);
        
function backButton_Callback(hObject, eventdata, handles)
    close;
    atmFigure("atmFigure.fig");
