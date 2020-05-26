function varargout = audio(varargin)
% AUDIO MATLAB code for audio.fig
%      AUDIO, by itself, creates a new AUDIO or raises the existing
%      singleton*.
%
%      H = AUDIO returns the handle to a new AUDIO or the handle to
%      the existing singleton*.
%
%      AUDIO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AUDIO.M with the given input arguments.
%
%      AUDIO('Property','Value',...) creates a new AUDIO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before audio_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to audio_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help audio

% Last Modified by GUIDE v2.5 26-May-2020 11:26:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @audio_OpeningFcn, ...
                   'gui_OutputFcn',  @audio_OutputFcn, ...
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


% --- Executes just before audio is made visible.
function audio_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to audio (see VARARGIN)

% Choose default command line output for audio
handles.output = hObject;
bg = imread("logo.png");
set(handles.sound,'CData',bg);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes audio wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = audio_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in sound.
function sound_Callback(hObject, eventdata, handles)
% hObject    handle to sound (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fc = 3000;
fs = 10000;
fdev = 50;
t = (0:1/fs:0.2); 
a = audiorecorder;
set(handles.text5,'String',"Start speaking");
recordblocking(a,10);
set(handles.text4,"String","End recording");
p = play(a);
pause(10);
b = getaudiodata(a);
filename = 'RecordedAudio.wav';
audiowrite(filename,b,fs);
clear b fs
[b,fs]=audioread(filename);
figure;
subplot(4,1,1),plot(b);
title('Message Signal');
xlabel('time(t)');
ylabel('Amplitude');


yc = sin(2*pi*fc*t);
subplot(4,1,2),plot(yc);
title('Carrier Signal');
xlabel('time(t)');
ylabel('Amplitude');

m = fmmod(b,fc,fs,fdev);

subplot(4,1,3),plot(m);
title('Modulated Signal');
xlabel('time(t)');
ylabel('Amplitude');

d = fmdemod(m,fc,fs,fdev);
subplot(4,1,4),plot(d);
title('Demodulated Signal');
xlabel('time(t)');
ylabel('Amplitude');
pause(5);
sound(d);
pause(20);
clear all;
close all;
clc;
