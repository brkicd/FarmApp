%% Memory game
clear all;
close all;
clc;restoredefaultpath

addpath 'Z:\BINGO - PID\Data\App data\Participants json files\Not yet processed\Diandra\scripts\FarmApp'
addpath 'Z:\BINGO - PID\Data\App data\Participants json files\Not yet processed\BINGO group\excel\*'

cd 'Z:\BINGO - PID\Data\App data\Participants json files\Not yet processed\BINGO group\memory'

%% Subject details
SubName= 'BISTX462'; %'BICA59','BICA6'};
opts=detectImportOptions(['Z:\BINGO - PID\Data\App data\Participants json files\Not yet processed\BINGO group\excel\',SubName, '-data.csv'],'NumHeaderLines',0); % this is for the headers names
data=readtable(['Z:\BINGO - PID\Data\App data\Participants json files\Not yet processed\BINGO group\excel\',SubName, '-data.csv'],opts);


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

% memory game adult 
mode= find(contains(memory_game.mode,'adult'));
memory_game_adult= (memory_game(mode,:))
clear mode


%% ---------------------------------- Memory - RA -------------------------%
% divide training from baseline
rows0=find(contains(memory_game_RA.phase_type,'training'));
vars={'state','run_nr','trial_nr','phase_type','block_nr','target', 'distractor','targetKind','response_0','responseTime_0'};
memory_RA_training= memory_game_RA(rows0, vars)
RA_training_trls=size(rows0,1)
clear rows0 
% child training
rows00=find(contains(memory_game_child.phase_type,'training'));
vars={'state','run_nr','trial_nr','phase_type','block_nr','target', 'distractor','targetKind','response_0','responseTime_0'};
memory_child_training= memory_game_child(rows00, vars)
child_training_trls=size(rows00,1)
clear rows00
% adult training 
rows000=find(contains(memory_game_adult.phase_type,'training'));
vars={'state','run_nr','trial_nr','phase_type','block_nr','target', 'distractor','targetKind','response_0','responseTime_0'};
memory_adult_training=memory_game_adult(rows000, vars)
adult_training_trls=size(rows000,1)
clear rows000

% baseline 
rows1=find(contains(memory_game_RA.phase_type,'baseline'));
memory_RA_baseline= memory_game_RA(rows1,vars)
tot_nr_trls_bsln=size(rows1,1)
nr_runs_RA= tot_nr_trls_bsln/30
clear rows1

%overall accuracy in BASELINE
rows2=find(contains(memory_RA_baseline.response_0,'t'));
tot_nr_correct_trls_bsln= size(rows2,1);
memory_RA_baseline_correct=memory_RA_baseline(rows2, vars);

accuracy_bsl= tot_nr_correct_trls_bsln/tot_nr_trls_bsln

% overall RT
RT_overall_baseline= mean(memory_RA_baseline_correct.responseTime_0,1)
clear rows 2
%------------------------- BASELINE CHICKEN --------------------- %
% targetKind 0= chicken; 1=sheep; 2 = other

rows3=find(contains(memory_game_RA.targetKind,'0'));
memory_RA_chicken= memory_game_RA (rows3,vars)
tot_trls_chicken = size(rows3,1)
clear rows3

% accuracy
rows4 = find(contains(memory_RA_chicken.response_0,'t'));
tot_nr_correct_trls_chicken= size(rows4,1)

accuracy_chicken_RA= tot_nr_correct_trls_chicken/tot_trls_chicken

% RT chicken 
memory_chicken_RA_correct= memory_RA_chicken(rows4,vars)

RT_chicken_RA=mean(memory_chicken_RA_correct.responseTime_0,1)
clear rows4

%--------------------------------- BASELINE SHEEP ------------------- %
rows5=find(contains(memory_game_RA.targetKind,'1'));
memory_RA_sheep= memory_game_RA (rows5,vars);
tot_trls_sheep = size(rows5,1); % should be 30
clear rows5

% accuracy
rows6 = find(contains(memory_RA_sheep.response_0,'t'));
tot_nr_correct_trls_sheep= size(rows6,1)
accuracy_sheep_RA= tot_nr_correct_trls_sheep/tot_trls_sheep

% RT sheep 
memory_sheep_RA_correct= memory_RA_sheep(rows6,vars)
RT_sheep_RA=mean(memory_sheep_RA_correct.responseTime_0,1)
clear rows6

% save everything in the 1st sheet of excel results

filename=[SubName '_memory.xlsx'];


vars1=table(nr_runs_RA,...
            RA_training_trls,...
            child_training_trls,...
            adult_training_trls,...
            tot_nr_trls_bsln,...
            tot_nr_correct_trls_bsln,...
            accuracy_bsl,...
            RT_overall_baseline,...
            tot_trls_chicken,...
            tot_nr_correct_trls_chicken,...
            accuracy_chicken_RA,...
            RT_chicken_RA,...
            tot_trls_sheep,...
            tot_nr_correct_trls_sheep,...
            accuracy_sheep_RA,...
            RT_sheep_RA)

writetable(vars1,filename,'Sheet',1)

clear vars

%% ----- Child mode memory game ----- %%
vars={'state','mode','run_nr','trial_nr','phase_type','block_nr','target', 'distractor','targetKind','response_0','responseTime_0'};

% baseline 
rows1=find(contains(memory_game_child.phase_type,'baseline'));
memory_child_baseline= memory_game_child(rows1,vars)
tot_nr_trls_child=size(rows1,1)
nr_runs_child=tot_nr_trls_child/30
clear rows1

%overall accuracy in BASELINE
rows2=find(contains(memory_child_baseline.response_0,'t'));
tot_nr_correct_trls_child= size(rows2,1);
memory_child_correct=memory_child_baseline(rows2, vars);

accuracy_child= tot_nr_correct_trls_child/tot_nr_trls_child

% overall RT
RT_overall_child= mean(memory_child_correct.responseTime_0,1)
clear rows 2

%-------------------------CHICKEN CHILD --------------------- %
% targetKind 0= chicken; 1=sheep; 2 = other

rows3=find(contains(memory_child_baseline.targetKind,'0'));
memory_child_chicken= memory_child_baseline(rows3,vars)
tot_trls_child_chicken = size(rows3,1)
clear rows3

% accuracy
rows4 = find(contains(memory_child_chicken.response_0,'t'));
tot_correct_trls_child_chicken= size(rows4,1)

accuracy_chicken_child= tot_correct_trls_child_chicken/tot_trls_child_chicken

% RT chicken 
memory_chicken_child_correct= memory_child_chicken(rows4,vars)
RT_chicken_child=mean(memory_chicken_child_correct.responseTime_0,1)
clear rows4

    

%---------------------------------SHEEP CHILD ------------------- %
rows5=find(contains(memory_child_baseline.targetKind,'1'));
memory_child_sheep= memory_child_baseline(rows5,vars);
tot_trls_sheep_child = size(rows5,1); % should be 30
clear rows5

% accuracy
rows6 = find(contains(memory_child_sheep.response_0,'t'));
tot_nr_correct_trls_child_sheep= size(rows6,1)
accuracy_sheep_child= tot_nr_correct_trls_child_sheep/tot_trls_sheep_child

% RT sheep 
memory_sheep_child_correct= memory_child_sheep(rows6,vars)
RT_sheep_child=mean(memory_sheep_child_correct.responseTime_0,1)
clear rows6

% save everything in the 1st sheet of excel results

vars1=table(nr_runs_child,...
            tot_nr_trls_child,...
            tot_nr_correct_trls_child,...
            accuracy_child,...
            RT_overall_child,...
            tot_trls_child_chicken,...
            tot_correct_trls_child_chicken,...
            accuracy_chicken_child,...
            RT_chicken_child,...
            tot_trls_sheep_child,...
            tot_nr_correct_trls_child_sheep,...
            accuracy_sheep_child,...
            RT_sheep_child)


% xlswrite([SubName '_childresults.xlsx'],vars1, sheet)

writetable(vars1,filename,'Sheet',2)


winopen([SubName '_memory.xlsx']);
clear rows1 vars vars1

