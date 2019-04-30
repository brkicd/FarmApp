%% CHICKEN GAME - child mode - INCOMPLETE runs

clear all;
close all;
clc;
restoredefaultpath
addpath 'Z:\BINGO - PID\Data\App data\Participants json files\Not yet processed\test_data\'
addpath 'Z:\BINGO - PID\Data\App data\Participants json files\Not yet processed\test_data\scripts'

cd 'Z:\BINGO - PID\Data\App data\Participants json files\Not yet processed\BINGO group\child_mode\chicken'

%% Subject details
SubName= 'BICA103'; %'BICA59','BICA6'};
opts=detectImportOptions(['Z:\BINGO - PID\Data\App data\Participants json files\Not yet processed\BINGO group\excel\',SubName, '-data.csv'],'NumHeaderLines',0); % this is for the headers names
data=readtable(['Z:\BINGO - PID\Data\App data\Participants json files\Not yet processed\BINGO group\excel',SubName, '-data.csv'],opts);
%% --------------------------- find the chicks ------------------------- %
 

task=find(contains(data.task_id,'chicken'));  %index of the complete state

% take only the complete runs in all modalities
data_chicken=(data(task,:));

mode=find(contains(data_chicken.mode,'child'));

data_chicken_child=(data_chicken(mode,:))



%% check how many trials in each mode
 % wchildpper_chicken (i,1) --> 1= 'ra', 2='child', 3='adult'
 for i=1:size(data_chicken,1)
     if strfind(data_chicken.mode{i}, 'ra')==1  % how many runs were completed, check this with the descriptive spreadhseets
             wrapper_chicken(i,1)=1;  
     end
      if strfind(data_chicken.mode{i}, 'child')==1  % how many runs were completed, check this with the descriptive spreadhseets
             wrapper_chicken(i,1)=2;  
      end
      if strfind(data_chicken.mode{i}, 'adult')==1  % how many runs were completed, check this with the descriptive spreadhseets
             wrapper_chicken(i,1)=3;  
     end
 end 
  % ----------------------- find baseline and adaptive trials ------------------ %
   % wrapper_chicken (i,2) --> 2=baseline; 3=adaptive; 1=warmup; 0=training
   
  for i=1:size(data_chicken,1)
     if strfind(data_chicken.phase_type{i}, 'baseline')==1  % how many runs were completed, check this with the descriptive spreadhseets
             wrapper_chicken(i,2)=2;  
     end
      if strfind(data_chicken.phase_type{i}, 'adaptive')==1  % how many runs were completed, check this with the descriptive spreadhseets
             wrapper_chicken(i,2)=3;  
      end
     if strfind(data_chicken.phase_type{i}, 'warmup')==1  % how many runs were completed, check this with the descriptive spreadhseets
             wrapper_chicken(i,2)=1;  
     end  
      
      if strfind(data_chicken.phase_type{i}, 'training')==1  % how many runs were completed, check this with the descriptive spreadhseets
             wrapper_chicken(i,2)=0;  
      end
      
  end
  
  % count the trials in child mode
  % ----------------------------- game mode done ---------------- %
 % you can check here, if the code is counting right- child mode
 % size of chicken, how many trials in total  
 
 chicken_baseline=find(wrapper_chicken(:,1)==2 & wrapper_chicken(:,2)==2)
 chicken_adaptive= find(wrapper_chicken(:,1)==2 & wrapper_chicken(:,2)==3)
 chicken_warmup  =find(wrapper_chicken(:,1)==2 & wrapper_chicken(:,2)==1)
 
   % tot baseline
counter= size(chicken_baseline);
fprintf('trials in baseline = %d ', counter(1,1));
bsln_tot_trials=counter(1,1)
clear counter;
% tot adaptive
counter=size(chicken_adaptive)
fprintf('trials in adaptive = %d ', counter(1,1));
adaptive_tot_trials=counter(1,1)
clear counter;
% tot warmup
counter=size(chicken_warmup)
warmup_tot_trials=counter(1,1)
fprintf('trials in chicken_warmup= %d ', counter(1,1));
clear counter;

%% check the number of complete trials and then blocks
% see if there are any complete runs and how many are there - you might not need this here...
complete_trials_child=size(find(contains(data_chicken_child.state,'complete')),1) %it should be 33
% if the answer is 0, look for specific things see below

%% if there are any 'complete' trials in Baseline - do the following
rows=find(contains(data_chicken_child.phase_type,'baseline'));
vars={'state','run_nr','trial_nr','block_nr',....
     'phase_type','difficulty','fixedSequence','correct',...
     'hutch_id_0','hutch_stimulusId_0','response_0','responseTime_0',...
     'hutch_id_1','hutch_stimulusId_1','response_1','responseTime_1',...
     'hutch_id_2','hutch_stimulusId_2','response_2','responseTime_2',...
     'hutch_id_3','hutch_stimulusId_3','response_3','responseTime_3',...
     'hutch_id_4','hutch_stimulusId_4','response_4','responseTime_4',...
     'hutch_id_5','hutch_stimulusId_5','response_5','responseTime_5',...
     'hutch_id_6','hutch_stimulusId_6','response_6','responseTime_6',...
     'hutch_id_7','hutch_stimulusId_7','response_7','responseTime_7'
     }
data_chicken_child_baseline=data_chicken_child(rows,vars);
clear rows 


% complete runs

complete_runs_baseline= (size(data_chicken_child_baseline(:,1),1)/6)

% calculate tot trials baseline
rows0=size(data_chicken_child_baseline.trial_nr(:,1))
tot_trials_baseline=size((rows0),1)

% ----- accuracy and RT time -------------- % 
rows1=find(contains(data_chicken_child_baseline.correct,'True'))
correct_nr_trls_baseline=size((rows1),1)

% count the incorrect ones
rows2=find(contains(data_chicken_child_baseline.correct,'False'))
incorrect_nr_trls_baseline=size((rows2),1)

% import only correct trials
chicken_bsln_correct=data_chicken_child_baseline(rows1,vars)
clear rows1 rows0

%% ------------------ ADAPTIVE Phase --------------------------------- %%
rows=find(contains(data_chicken_child.phase_type,'adaptive'));

vars={'state','run_nr','trial_nr','block_nr',....
     'phase_type','difficulty','fixedSequence','correct',...
     'hutch_id_0','hutch_stimulusId_0','response_0','responseTime_0',...
     'hutch_id_1','hutch_stimulusId_1','response_1','responseTime_1',...
     'hutch_id_2','hutch_stimulusId_2','response_2','responseTime_2',...
     'hutch_id_3','hutch_stimulusId_3','response_3','responseTime_3',...
     'hutch_id_4','hutch_stimulusId_4','response_4','responseTime_4',...
     'hutch_id_5','hutch_stimulusId_5','response_5','responseTime_5',...
     'hutch_id_6','hutch_stimulusId_6','response_6','responseTime_6',...
     'hutch_id_7','hutch_stimulusId_7','response_7','responseTime_7'
     }
data_chicken_child_adaptive=data_chicken_child(rows,vars);

%count the tot trials - completed and not
rows0=size(data_chicken_child_adaptive.trial_nr(:,1))
tot_trials_adaptive=rows0(1,1)

% count the correct ones 
rows1=find(contains(data_chicken_child_adaptive.correct,'True'))
correct_nr_trls_adaptive=size((rows1),1)

% count the incorrect ones
rows2=find(contains(data_chicken_child_adaptive.correct,'False'))
incorrect_nr_trls_adaptive=size((rows2),1)


% import only correct trials
chicken_adaptive_correct=data_chicken_child_adaptive(rows1,vars)
clear rows0 rows1 rows2

% ------------------------ Calculate the ADAPTIVE RUNS played ------------%

complete_trials_adaptive=size(find(contains(data_chicken_child_adaptive.state,'complete')),1) %it should be 33

complete_runs_adaptive= (size(data_chicken_child_adaptive(:,1),1)/18)

%% count the difficulty and the proportion of correct trials - do these even change???

 % proportion of correct responses BASELINE (difficulty=3)
 baseline_percent_correct=correct_nr_trls_baseline/bsln_tot_trials %this might be 0 in some incomplete ones
 
 % total percent ADAPTIVE
adaptive_percent_correct=correct_nr_trls_adaptive/complete_trials_adaptive


