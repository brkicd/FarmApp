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
clear mode

%% ---------------------------------- Memory - RA -------------------------%
% divide training from baseline
rows0=find(contains(memory_game_RA.phase_type,'training'));
vars={'state','run_nr','trial_nr','phase_type','block_nr','target', 'distractor','targetKind','response_0','responseTime_0'};
memory_RA_training= memory_game_RA(rows0, vars)
clear rows0 
% baseline 
rows1=find(contains(memory_game_RA.phase_type,'baseline'));
memory_RA_baseline= memory_game_RA(rows1,vars)
tot_nr_trls_bsln=size(rows1,1)
clear rows1

%overall accuracy in BASELINE
rows2=find(contains(memory_RA_baseline.response_0,'t'));
tot_nr_correct_trls_bsln= size(rows2,1);
memory_RA_baseline_correct=memory_RA_baseline(rows2, vars);

% overall RT
RT_overall_baseline= mean(memory_RA_baseline_correct.responseTime_0,1)
clear rows 2
%------------------------- BASELINE CHICKEN --------------------- %
% targetKind 0= chicken; 1=sheep; 2 = other

rows3=find(contains(memory_game_RA.targetKind,'0'));
memory_RA_chicken= memory_game_RA (rows3,vars)



    