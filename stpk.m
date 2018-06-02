function varargout = stpk(varargin)
% STPK MATLAB code for stpk.fig
%      STPK, by itself, creates a new STPK or raises the existing
%      singleton*.
%
%      H = STPK returns the handle to a new STPK or the handle to
%      the existing singleton*.
%
%      STPK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STPK.M with the given input arguments.
%
%      STPK('Property','Value',...) creates a new STPK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before stpk_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to stpk_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help stpk

% Last Modified by GUIDE v2.5 25-May-2018 06:21:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @stpk_OpeningFcn, ...
                   'gui_OutputFcn',  @stpk_OutputFcn, ...
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


% --- Executes just before stpk is made visible.
function stpk_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to stpk (see VARARGIN)

% Choose default command line output for stpk
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
global phase
global n_kriteria
global s_kriteria
global kk
global W
global n_alternatif
global matrix
global k_name
global a_name
global kecamatan
global daerah
phase = 0
n_kriteria = 0
s_kriteria = 0
kk = 0
W = 0
n_alternatif = 0
matrix = 0
k_name = 0
a_name = 0
kecamatan = {'Padang Utara';'Padang Selatan';'Padang Barat';
    'Padang Timur';'Nanggalo';'Kuranji';'Pauh';'Lubuk Begalung';
    'Lubuk Kilangan';'Bungus';'Koto Tangah'}
daerah = {'S. Parman','Gajah Mada';'Sutan Syahrir','Rasuna Said';
    'Veteran','Juanda';'Sutomo','Andalas';'Jhoni Anwar','Raya Siteba';
    'Kp. Kalawi','Raya Kuranji';'Dr. Moh Hatta','Universitas Andalas';
    'Parak Laweh','Kp. Jua';'Padang Basi','Padang Basi No.2';'Kayu Aro','Pantai Carolina';
    'Adinegoro','Prof. Dr. Hamka'}
set(handles.q_kec,'string',kecamatan)

% UIWAIT makes stpk wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = stpk_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btn_inputkriteria.
function btn_inputkriteria_Callback(hObject, eventdata, handles)
global phase
global n_kriteria
global s_kriteria
global kk
global W
global n_alternatif
global matrix
if phase==0
    n_kriteria = 0
    s_kriteria = 0
    kk = 0
    W = 0
    n_alternatif = 0
    matrix = 0
    set(handles.pnl_input,'visible','on')
    set(handles.pnl_result,'visible','off')
    set(handles.pnl_show,'visible','off')

    set(handles.pnl_input,'title','Input Kriteria')
    phase = 1
    set(handles.ask,'string',sprintf('Phase-%d: Input Jumlah Kriteria',phase))    
end

% --- Executes on button press in btn_proses.
function btn_proses_Callback(hObject, eventdata, handles)
global phase
if phase==0
    set(handles.pnl_input,'visible','off')
    set(handles.pnl_result,'visible','on')    
    set(handles.pnl_show,'visible','off')
end



% --- Executes on button press in btn_input.
function btn_input_Callback(hObject, eventdata, handles)
%a = str2num(get(handles.input,'string'))
%set(handles.ask,'string',num2str(a))
global phase
global n_kriteria
global s_kriteria
global kk
global W
global n_alternatif
global i
global matrix
global k_name
global a_name
global kecamatan
global daerah
clear menu
menu = get(handles.pnl_input,'title')
if(strcmp(menu,'Input Kriteria'))
    if(phase==1)        
        n_kriteria = str2num(get(handles.input,'string'))
        
        phase = phase + 1
        set(handles.ask,'string',sprintf('Phase-%d: Input Jenis Kriteria[0=Cost, 1=Benefit]',phase))
        set(handles.input,'string','')
    elseif(phase==2)
        s_kriteria = str2num(get(handles.input,'string'))        
        sz = size(s_kriteria)
        check = false
        for i=1:sz(2)
            if s_kriteria(1,i) == 1 || s_kriteria(1,i) == 0
                check = true
            else
                check = false
            end
        end
        if check==false || sz(2)~=n_kriteria
           if check==false
               set(handles.help,'string','E:Input Cost Benefit Tidak Benar')
           elseif sz(2)~=n_kriteria
               set(handles.help,'string','E:Status tidak sesuai jumlah kriteria') 
           end           
        else
           phase = phase + 1 
           set(handles.help,'string','')           
           set(handles.input,'string','')
           i = 1
           set(handles.ask,'string',sprintf('Phase-%d: Input Nama Kriteria ke-%d',phase,i))                      
        end
    elseif(phase==3)
        if(i<=n_kriteria)
            if(i==1)
                k_name = {get(handles.input,'string')}
                i = i+1
                set(handles.ask,'string',sprintf('Phase-%d: Input Nama Kriteria ke-%d',phase,i))           
                set(handles.input,'string','')                
            else
                x = get(handles.input,'string')
                sz = size(k_name)
                find = 0
                for j=1:sz(2)
                    if(strcmp(k_name(j),x))
                        find = 1
                    end
                end
                if find==0
                    k_name(i) = {x}
                    i = i+1
                    set(handles.ask,'string',sprintf('Phase-%d: Input Nama Kriteria ke-%d',phase,i))           
                    set(handles.input,'string','')                                        
                    set(handles.help,'string','')                    
                else
                    set(handles.help,'string','E: Nama sudah digunakan')
                end
            end           
        end
        if(i==n_kriteria+1)
            reset_input(handles)
            phase = 0
        end        
    end
elseif(strcmp(menu,'Input AHP'))
    if phase == 1
        kk = str2num(get(handles.input,'string'))
        sz = size(kk)
        if sz(1)~=sz(2) || sz(1)~=n_kriteria
            if sz(1)~=sz(2)
                set(handles.help,'string','E:Matriks harus persegi') 
            end
            if sz(1)~=n_kriteria
                set(handles.help,'string','E:Ukuran matriks tidak sesuai dengan kriteria') 
            end
        else
        W = translate(kk)
        phase = phase + 1
        set(handles.ask,'string',sprintf('Phase-%d: Input Jumlah Alternatif',phase))
        set(handles.input,'string','')        
        end
    elseif phase==2
        n_alternatif = str2num(get(handles.input,'string'))
        
        phase = phase + 1
        i = 1
        set(handles.ask,'string',sprintf('Phase-%d: Input Matrix Alternatif-Kriteria[%d]',phase,i))
        set(handles.input,'string','')
    elseif phase==3
        data = str2num(get(handles.input,'string'))
        sz = size(data)
        
        if sz(1)~=sz(2) || sz(1)~=n_alternatif
            if sz(1)~=sz(2)
                set(handles.help,'string','E:Matriks harus persegi') 
            end
            if sz(1)~=n_kriteria
                set(handles.help,'string','E:Ukuran matriks tidak sesuai dengan jumlah alternatif') 
            end
        else  
            if i==1
                matrix=translate(data)
            else
                matrix(:,i)=translate(data)
            end
            
            i = i + 1
            set(handles.ask,'string',sprintf('Phase-%d: Input Matrix Alternatif-Kriteria[%d]',phase,i))
            set(handles.input,'string','')        
            
            if i==n_kriteria+1
                phase = 0
                reset_input(handles)
            end
        end
    end
elseif(strcmp(menu,'Input Non-AHP'))
    if phase==1
        W = str2num(get(handles.input,'string'))
        sz = size(W)
        if sz(2)~=n_kriteria
            set(handles.help,'string','E: Jumlah weight tidak sesuai dengan jumlah kriteria')
        else
            phase = phase + 1
            W = transpose(W)
            set(handles.ask,'string',sprintf('Phase-%d: Input Matriks Alternatif',phase))
            set(handles.help,'string','')
            set(handles.input,'string','')
        end
    elseif phase==2
        matrix = str2num(get(handles.input,'string'))
        sz = size(matrix)
        if sz(2)~=n_kriteria
            set(handles.help,'string','E: Banyak kolom tidak sesuai dengan jumlah kriteria')
        else
            n_alternatif = sz(1)
            phase = phase + 1
            i = 1
            set(handles.ask,'string',sprintf('Phase-%d: Input Nama Alternatif-%d',phase,i))
            set(handles.input,'string','')
            set(handles.input,'visible','off')
            set(handles.kec,'visible','on')
            set(handles.dar,'visible','on')
            set(handles.kec,'string',kecamatan)
            set(handles.dar,'string',daerah(1,:))
        end
    elseif phase==3
        if(i<=n_alternatif)
            if(i==1)
                x = get(handles.dar,'string')
                v = get(handles.dar,'value')
                a_name = x(v)
                i = i+1
                set(handles.ask,'string',sprintf('Phase-%d: Input Nama Alternatif-%d',phase,i))
                set(handles.input,'string','')                
            else
                x = get(handles.dar,'string')
                v = get(handles.dar,'value')
                new = x(v)
                sz = size(a_name)
                find = 0
                for j=1:sz(2)
                    if(strcmp(a_name(j),new))
                        find = 1
                    end
                end
                if find==0
                    a_name(i) = new
                    i = i+1
                    set(handles.ask,'string',sprintf('Phase-%d: Input Nama Alternatif ke-%d',phase,i))           
                    set(handles.input,'string','')                                        
                    set(handles.help,'string','')                    
                else
                    set(handles.help,'string','E: Nama sudah digunakan')
                end                
            end

        end
        if(i==n_alternatif+1)
            phase = 0
            reset_input(handles)
        end        
    end
elseif(strcmp(menu,'Add Kriteria'))
    if phase==1                
        x = get(handles.input,'string')
        sz = size(k_name)
        find = 0
        for j=1:sz(2)
            if(strcmp(k_name(j),x))
                find = 1
            end
        end
        if find==0
            k_name(n_kriteria) = {x}
            phase = phase + 1
            set(handles.help,'string','')
            set(handles.input,'string','')
            set(handles.ask,'string',sprintf('Phase-%d: Input Jenis Kriteria(0=Cost,1=Benefit)',phase))            
        else
            set(handles.help,'string','E: Nama kriteria sudah digunakan')
        end
    elseif phase==2
        s_kriteria(n_kriteria) = str2num(get(handles.input,'string'))
        sz = size(W)
        if(sz(1)~= 1)
            phase = phase + 1
            set(handles.help,'string','')
            set(handles.input,'string','')
            set(handles.ask,'string',sprintf('Phase-%d: Input Nilai Bobot Kriteria',phase))
        else
            phase = 0
            reset_input(handles)
        end
    elseif phase==3
        W(n_kriteria) = str2num(get(handles.input,'string'))
        phase = phase + 1
        sz = size(matrix)
        set(handles.help,'string','')
        set(handles.input,'string','')        
        set(handles.ask,'string',sprintf('Phase-%d: Input Nilai Alternatif Untuk Kriteria Baru[%d 1]',phase,sz(1)))
    elseif phase==4
        x = str2num(get(handles.input,'string'))
        sz = size(x)
        sz2 = size(matrix)
        if(sz(1)==sz2(1))
            matrix(:,n_kriteria) = x
            phase = 0
            reset_input(handles)
        else
            set(handles.help,'string','E: Ukuran Matriks Yang Diinputkan Tidak Sesuai')
        end
    end
elseif(strcmp(menu,'Add Alternatif'))
    if phase==1                
        a = get(handles.dar,'string')
        v = get(handles.dar,'value')
        x = a(v)
        sz = size(a_name)
        find = 0
        for j=1:sz(2)
            if (strcmp(a_name(j),x))
                find = 1
            end
        end
        if find==0
            a_name(n_alternatif) = {get(handles.input,'string')}
            phase = phase + 1        
            set(handles.help,'string','')
            set(handles.input,'string','')        
            set(handles.input,'visible','on')
            set(handles.dar,'visible','off')
            set(handles.kec,'visible','off')
            set(handles.ask,'string',sprintf('Phase-%d: Input Matriks Nilai[1 %d]',phase,n_kriteria))
        else
            set(handles.help,'string','E: Nama alternatif sudah digunakan')
        end
    elseif phase==2
        x = str2num(get(handles.input,'string'))
        sz = size(x)
        if(sz(2)==n_kriteria)
            matrix(n_alternatif,:) = x
            phase = 0
            reset_input(handles)
        else
            set(handles.help,'string','E: Ukuran Matriks Yang Diinputkan Tidak Sesuai')
        end
    end
end


function input_Callback(hObject, eventdata, handles)
% hObject    handle to input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input as text
%        str2double(get(hObject,'String')) returns contents of input as a double


% --- Executes during object creation, after setting all properties.
function input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function reset_input(handles)
    set(handles.ask,'string','')
    set(handles.help,'string','')
    set(handles.pnl_input,'title','')
    set(handles.input,'string','')
    set(handles.pnl_input,'visible','off')
    set(handles.kec,'visible','off')
    set(handles.dar,'visible','off')
    set(handles.input,'string','on')
    
function out = translate(in)
    sz = size(in)
    if sz(1)==sz(2)
        col = sum(in)
        for i=1:sz(2)
            in(:,i)=in(:, i)/col(i)
        end
        out = sum(in,2)/sz(1)
    else
        disp('Error: Harus Matriks Persegi')
    end
    


% --- Executes on button press in btn_inputAHP.
function btn_inputAHP_Callback(hObject, eventdata, handles)
% hObject    handle to btn_inputAHP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global phase
global n_kriteria
global kk
global W
global n_alternatif
global matrix
if phase==0 && n_kriteria~=0
    kk = 0
    W = 0
    n_alternatif = 0
    matrix = 0
    set(handles.pnl_input,'visible','on')
    set(handles.pnl_result,'visible','off')
    set(handles.pnl_show,'visible','off')

    set(handles.pnl_input,'title','Input AHP')
    phase = 1
    set(handles.ask,'string',sprintf('Phase-%d: Input Matriks Kriteria-Kriteria[%d %d]',phase,n_kriteria,n_kriteria))    
end


% --- Executes on button press in btn_inputnon.
function btn_inputnon_Callback(hObject, eventdata, handles)
% hObject    handle to btn_inputnon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global phase
global n_kriteria
global kk
global W
global n_alternatif
global matrix
if phase==0 && n_kriteria~=0
    kk = 0
    W = 0
    n_alternatif = 0
    matrix = 0
    set(handles.pnl_input,'visible','on')
    set(handles.pnl_result,'visible','off')
    set(handles.pnl_show,'visible','off')

    set(handles.pnl_input,'title','Input Non-AHP')
    phase = 1
    set(handles.ask,'string',sprintf('Phase-%d: Input W[1 %d]',phase,n_kriteria))    
end

function out = AHP(matrix, W)
    out = matrix*W

function out = consist(kk, W)
    data = kk*W
    sz = size(data)
    for i=1:sz(1)
        data(i) = data(i)/W(i)
    end
    CI = (mean(data)-sz(1))/(sz(1)-1)
    switch sz(1)
        case 2
            out = CI/0
        case 3
            out = CI/0.58
        case 4
            out = CI/0.90
        case 5
            out = CI/1.12
        case 6
            out = CI/1.24
        case 7
            out = CI/1.32
        case 8
            out = CI/1.41            
        case 9
            out = CI/1.45            
        otherwise
            out = CI/1.51
    end

function out = SAW(matrix, W, s_kriteria)
sz = size(matrix)
for i=1:sz(2)
    if(s_kriteria(i)==1)
        temp(:,i) = matrix(:,i)/max(matrix(:,i))
    else
        for j=1:sz(1)
           temp(j,i) = min(matrix(:,i))/matrix(j,i)
        end        
    end
end
out = temp*W

function out = WP(matrix, W, s_kriteria)
    W2 = W/sum(W)
    sz = size(matrix)
    for i=1:sz(1)
       temp = 1
       for j=1:sz(2)
           if s_kriteria(j)==1
               pow = W2(j)
           else
               pow = -W2(j)
           end
           temp = temp * matrix(i,j)^pow
       end
       S(i) = temp
    end
    out = transpose(S/sum(S))

function out = TOPSIS(matrix, W, s_kriteria)
    sz = size(matrix)
    for i=1:sz(2)
        R(:,i) = matrix(:,i)/norm(matrix(:,i))
        Y(:,i) = R(:,i)*W(i)
        if s_kriteria(i)==1
            Ymax(i) = max(Y(:,i))
            Ymin(i) = min(Y(:,i))
        else
            Ymax(i) = min(Y(:,i))
            Ymin(i) = max(Y(:,i))
        end
    end
    Amax = Ymax
    Amin = Ymin
    for i=1:sz(1)    
        Dmax(i) = norm(Y(i,:) - Amax)
        Dmin(i) = norm(Y(i,:) - Amin)
        V(i) = Dmin(i)/(Dmin(i)+Dmax(i))
    end
    out = transpose(V)


% --- Executes on button press in btn_ahp.
function btn_ahp_Callback(hObject, eventdata, handles)
% hObject    handle to btn_ahp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global kk
global matrix
global W
sz1 = size(matrix)
sz2 = size(kk)
if sz1(1)~=1 && sz2(1)~=1
    bar(AHP(matrix,W))
    con = consist(kk,W)
    set(handles.cons,'string',sprintf('Konsistensi: %f',con))
end


% --- Executes on button press in btn_saw.
function btn_saw_Callback(hObject, eventdata, handles)
% hObject    handle to btn_saw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global s_kriteria
global matrix
global W
global a_name
sz = size(matrix)
if sz(1)~=1
    x = SAW(matrix, W, s_kriteria)
    sz = size(x)
    bar(x)
    set(handles.cons,'string','')
    show = transpose(a_name)
    for i=1:sz(1)
        show(i,2) = {x(i)}
    end
    set(handles.uitable4,'data',show)
    set(handles.uitable4,'columnname',{'Nama','Nilai'})
end


% --- Executes on button press in btn_wp.
function btn_wp_Callback(hObject, eventdata, handles)
% hObject    handle to btn_wp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global s_kriteria
global matrix
global W
sz = size(matrix)
if sz(1)~=1
    bar(WP(matrix,W,s_kriteria))
    set(handles.cons,'string','')
end


% --- Executes on button press in btn_topsis.
function btn_topsis_Callback(hObject, eventdata, handles)
% hObject    handle to btn_topsis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global s_kriteria
global matrix
global W
sz = size(matrix)
if sz(1)~=1
    bar(TOPSIS(matrix,W,s_kriteria))
    set(handles.cons,'string','')
end


% --- Executes on button press in pushbutton24.
function pushbutton24_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton25.
function pushbutton25_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton26.
function pushbutton26_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton27.
function pushbutton27_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton28.
function pushbutton28_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton29.
function pushbutton29_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton30.
function pushbutton30_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton31.
function pushbutton31_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btn_show.
function btn_show_Callback(hObject, eventdata, handles)
% hObject    handle to btn_show (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global phase
if phase==0
    set(handles.pnl_input,'visible','off')
    set(handles.pnl_result,'visible','off')    
    set(handles.pnl_show,'visible','on')
end


% --- Executes on button press in btn_weight.
function btn_weight_Callback(hObject, ~, handles)
% hObject    handle to btn_weight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global s_kriteria
global k_name
global W
x=transpose(k_name)
b=W
c=transpose(s_kriteria)
sz = size(s_kriteria)
for n=1:sz(2)
    if(s_kriteria(n)==1)
        x(n,2) = {'Benefit'}
    else
        x(n,2) = {'Cost'}
    end
    x(n,3) = {W(n)}
end
set(handles.uitable4,'data',x)
set(handles.uitable4,'columnname',{'Nama','Status','Bobot'})
set(handles.data,'string',k_name)
set(handles.del,'string','Delete Kriteria')


% --- Executes on button press in btn_alt.
function btn_alt_Callback(hObject, eventdata, handles)
% hObject    handle to btn_alt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global matrix
global a_name
global k_name
a = matrix
b = transpose(a_name)
sz = size(matrix)
x = b;
for i=1:sz(1)
    for j=1:sz(2)
      x(i,j+1) = {matrix(i,j)}
    end
end
sz = size(k_name)
col = {'nama'}
for i=1:sz(2)
    col(i+1) = k_name(i)
end
set(handles.uitable4,'data',x)
set(handles.uitable4,'columnname',col)
set(handles.data,'string',a_name)
set(handles.del,'string','Delete Alternatif')



% --- Executes on button press in btn_result.
function btn_result_Callback(hObject, eventdata, handles)
% hObject    handle to btn_result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btn_addkriteria.
function btn_addkriteria_Callback(hObject, eventdata, handles)
% hObject    handle to btn_addkriteria (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global n_kriteria
global phase
if phase==0 && n_kriteria~=0
    phase = 1
    n_kriteria = n_kriteria + 1
    set(handles.pnl_input,'visible','on')
    set(handles.pnl_result,'visible','off')
    set(handles.pnl_show,'visible','off')
    set(handles.pnl_input,'title','Add Kriteria')
    set(handles.input,'visible','on')
    set(handles.ask,'string',sprintf('Phase-%d: Input Nama Kriteria Baru',phase))
end


% --- Executes on button press in btn_addalt.
function btn_addalt_Callback(hObject, eventdata, handles)
% hObject    handle to btn_addalt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global n_alternatif
global phase
if phase==0 && n_alternatif~=0
    phase = 1
    n_alternatif = n_alternatif + 1
    set(handles.pnl_input,'visible','on')
    set(handles.kec,'visible','on')
    set(handles.dar,'visible','on')
    set(handles.input,'visible','off')
    set(handles.pnl_result,'visible','off')
    set(handles.pnl_show,'visible','off')
    set(handles.pnl_input,'title','Add Alternatif')
    set(handles.ask,'string',sprintf('Phase-%d: Input Nama Alternatif Baru',phase))
end


% --- Executes on selection change in data.
function data_Callback(hObject, eventdata, handles)
% hObject    handle to data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns data contents as cell array
%        contents{get(hObject,'Value')} returns selected item from data


% --- Executes during object creation, after setting all properties.
function data_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in del.
function del_Callback(hObject, eventdata, handles)
% hObject    handle to del (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global matrix
global a_name
global n_alternatif
global k_name
global s_kriteria
global W
global n_kriteria
title = get(handles.del,'string')
if strcmp(title,'Delete Kriteria')
    x = get(handles.data,'value')
    k_name(x) = []
    s_kriteria(x) = []
    W(x) = []
    matrix(:,x) = []
    n_kriteria = n_kriteria - 1
    set(handles.data,'string',k_name)
elseif strcmp(title,'Delete Alternatif')
    x = get(handles.data,'value')
    a_name(x) = []
    matrix(x,:) = []
    n_alternatif = n_alternatif-1
    set(handles.data,'string',a_name)
end


% --- Executes on selection change in kec.
function kec_Callback(hObject, eventdata, handles)
% hObject    handle to kec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns kec contents as cell array
%        contents{get(hObject,'Value')} returns selected item from kec
global daerah
A = get(handles.kec,'value')
sz = size(daerah(A,:))
data = daerah(A,1)
for i=1:sz(2)
    if strcmp(daerah(A,i),'')==0 && i~=1
        data(i) = daerah(A,i)
    end
end
set(handles.dar,'string',data)


% --- Executes during object creation, after setting all properties.
function kec_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in dar.
function dar_Callback(hObject, eventdata, handles)
% hObject    handle to dar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns dar contents as cell array
%        contents{get(hObject,'Value')} returns selected item from dar


% --- Executes during object creation, after setting all properties.
function dar_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on kec and none of its controls.
function kec_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to kec (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over kec.
function kec_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to kec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in refresh.
function refresh_Callback(hObject, eventdata, handles)
% hObject    handle to refresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in q_kec.
function q_kec_Callback(hObject, eventdata, handles)
% hObject    handle to q_kec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns q_kec contents as cell array
%        contents{get(hObject,'Value')} returns selected item from q_kec


% --- Executes during object creation, after setting all properties.
function q_kec_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q_kec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function q_dar_Callback(hObject, eventdata, handles)
% hObject    handle to q_dar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of q_dar as text
%        str2double(get(hObject,'String')) returns contents of q_dar as a double


% --- Executes during object creation, after setting all properties.
function q_dar_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q_dar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in q_add.
function q_add_Callback(hObject, eventdata, handles)
% hObject    handle to q_add (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global kecamatan
global daerah
new = get(handles.q_dar,'string')
kec = get(handles.q_kec,'value')
sz = size(daerah(kec,:))
daerah(kec,:)
find = 0
for i=1:sz(2)
    if strcmp(daerah(kec,i),new)
        find = 1
    end
end
if find==0 && strcmp(new,'')==false
    if(strcmp(daerah(kec,sz(2)),''))
        daerah(kec,sz(2)) = {new}
    else
        daerah(kec,sz(2)+1) = {new}
        sz2 = size(kecamatan)
        for i=1:sz2(1)
            if(i~=kec)
                daerah(i,sz(2)+1) = {''}
            end            
        end
    end    
    set(handles.q_dar,'string','')
    
    a = get(handles.kec,'value')
    n = size(daerah(a,:))
    data = daerah(a,1)
    for i=1:n(2)
        if strcmp(daerah(a,i),'')==0 && i~=1
            data(i) = daerah(a,i)
        end
    end
    set(handles.dar,'string',data)
end

