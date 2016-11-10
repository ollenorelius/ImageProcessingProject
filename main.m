% Run GUI
addpath('GUI')
addpath('sampleImages')
addpath('DCT')
addpath('WPT')
sampleGUI;
 
% get the handle to the GUI and wait for it to be closed
hGui = findobj('Tag','figure1');
waitfor(hGui);