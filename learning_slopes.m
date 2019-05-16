%% Learning slopes - SHEEP game 
clear all;
close all;
clc;restoredefaultpath

addpath 'Z:\BINGO - PID\Data\App data\Participants json files\Not yet processed\Diandra\scripts'
addpath 'Z:\BINGO - PID\Data\App data\Participants json files\Not yet processed\CALM group\excel_data\*'

%% Subject details
SubName= 'BICA6'; %'BICA59','BICA6'};
opts=detectImportOptions(['Z:\BINGO - PID\Data\App data\Participants json files\Not yet processed\CALM group\excel_data\',SubName, '-data.csv'],'NumHeaderLines',0); % this is for the headers names
data=readtable(['Z:\BINGO - PID\Data\App data\Participants json files\Not yet processed\CALM group\excel_data\',SubName, '-data.csv'],opts);


%% --------------------------- Sheep game first-child mode ------------------------- %
% I GAME - sheep
task=find(contains(data.task_id,'sheep'));  %index of the complete state
data_sheep=(data(task,:));

% II mode - RA or child
mode= find(contains(data_sheep.mode,'child'))
data_sheep_child=(data_sheep(mode,:))

% III complete trials only 
state= find(contains(data_sheep_child.state,'complete'))
data_sheep_child_complete=(data_sheep_child(state,:));

% IV adaptive and complete phase only 
phase=find(contains(data_sheep_child_complete.phase_type,'adaptive'))
sheep_child_adaptive=(data_sheep_child_complete(phase,:))

%% code the blocks in succession of presentation
for i=size(sheep_child_adaptive,1)
    for j=size(sheep_child_adaptive.trial_nr(1:20,1))
    sheep_child_adaptive.block_nr_2(j)=1
    
    end
end




