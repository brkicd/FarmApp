%% Memory game
clear all;
close all;
clc;restoredefaultpath

addpath 'Z:\BINGO - PID\Data\App data\Participants json files\Not yet processed\Diandra\scripts\FarmApp'
addpath 'Z:\BINGO - PID\Data\App data\Participants json files\Not yet processed\CALM group\excel_data\*'

cd 'Z:\BINGO - PID\Data\App data\Participants json files\Not yet processed\CALM group\memory'

%% Subject details
SubName= 'BICA6'; %'BICA59','BICA6'};
opts=detectImportOptions(['Z:\BINGO - PID\Data\App data\Participants json files\Not yet processed\CALM group\excel_data\',SubName, '-data.csv'],'NumHeaderLines',0); % this is for the headers names
data=readtable(['Z:\BINGO - PID\Data\App data\Participants json files\Not yet processed\CALM group\excel_data\',SubName, '-data.csv'],opts);


%% --------------------------- select the game - MEMORY ------------------------- %

task=find(contains(data.task_id,'memory'));  %index of the complete state

% whole memmory game 
memory_game=(data(task,:));

% memory game RA
mode=find(contains(memory_game.mode,'ra'));

memory_game_RA= (memory_game(mode,:))

clear mode

% memory game child
mode= find(contains(memory_game.mode,'child'));

memory_game_child= (memory_game(mode,:))
    