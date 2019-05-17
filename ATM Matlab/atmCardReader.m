function varargout = atmCardReader(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @atmCardRead_OpeningFcn, ...
                   'gui_OutputFcn',  @atmCardRead_OutputFcn, ...
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

function atmCardRead_OpeningFcn(hObject, eventdata, handles, varargin)
    global isGettingPin
    isGettingPin = 0;
handles.output = hObject;
guidata(hObject, handles);

function varargout = atmCardRead_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function continueButton_Callback(hObject, eventdata, handles)
    global isGettingPin
    global cardNumber
    global cardPIN
    global curlReply
    handles.errorLabel.String = "Loading...";
    pause(0.1);
    if isGettingPin == 0
        cardNumber = get(handles.cardNumberEdit,'String');
        encodingString = strcat('{"cardNumber":"', cardNumber, '"}' );
        %-----------------------
        curlWhere = convertCharsToStrings(strcat('where=', urlencode(encodingString)));
        curlWhere = regexprep(curlWhere,"+", "");
        % ----------------------
        curlLink = strcat("http://206.81.31.74", "?", curlWhere);
        curlRequest = '!curl -X GET ' + curlLink ;
        
        curlReply = evalc(curlRequest);
        curlReply        
        if isempty(strfind(curlReply, '{'))
            handles.errorLabel.String = "Unexpected error occured, Please check your internet connection and try again.";
            return
        else
            curlReply = regexprep(curlReply,'%(.+){"results":','{"results":');
            curlReply = jsondecode(curlReply);
        end
        
    else
        cardPIN = get(handles.cardNumberEdit,'String');
    end
    rSize = size(curlReply.results);
    if rSize == 0
        handles.errorLabel.String = "Wrong card number, please try again!";
    else
        if isGettingPin == 1
            if strcmp(curlReply.results(1).cardPin, cardPIN)
                close;
                atmFigure('atmFigure.fig');
            else
                handles.errorLabel.String = strcat("Wrong pin code for ", cardNumber, " card");
            end
        else
            isGettingPin = 1;
            handles.cardNumberEdit.String = "";
            handles.guideLabel.String = "Pin Number:";
            handles.errorLabel.String = "";
            handles.infoLabel.String = strcat("Please enter ", cardNumber, "'s Pin:");
        end
    end
    
function cardNumberEdit_Callback(hObject, eventdata, handles)
        
function cardNumberEdit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
