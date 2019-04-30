%% chicken game analysis BINGO  - Accuracy and RT

clear all;
close all;
clc;
restoredefaultpath
addpath 'Z:\BINGO - PID\Data\App data\Participants json files\Not yet processed\test_data\'
addpath 'Z:\BINGO - PID\Data\App data\Participants json files\Not yet processed\Diandra\scripts'
addpath 'Z:\BINGO - PID\Data\App data\Participants json files\Not yet processed'\'BINGO group\'

cd 'Z:\BINGO - PID\Data\App data\Participants json files\Not yet processed\BINGO group\child_mode\chicken'

%% Subject details
SubName= 'BIZDH44'; %'BICA59','BICA6'};
opts=detectImportOptions(['Z:\BINGO - PID\Data\App data\Participants json files\Not yet processed\BINGO group\excel\',SubName, '-data.csv'],'NumHeaderLines',0); % this is for the headers names
data=readtable(['Z:\BINGO - PID\Data\App data\Participants json files\Not yet processed\BINGO group\excel\',SubName, '-data.csv'],opts);


%% --------------------------- find the chicks ------------------------- %
    
task=find(contains(data.task_id,'chicken'));  %index of the complete state

% take only the complete runs in all modalities
data_chicken=(data(task,:));

mode=find(contains(data_chicken.mode,'child'));

data_chicken_child=(data_chicken(mode,:))

%% check how many trials in each mode
 % wrapper_chicken (i,1) --> 1= 'ra', 2='child', 3='adult'
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

% count the trials in RA mode
  % ----------------------------- game mode done ---------------- %
 % you can check here, if the code is counting right- RA mode
 % size of chicken, how many trials in total  
 
 chicken_baseline=find(wrapper_chicken(:,1)==2 & wrapper_chicken(:,2)==2)
 chicken_adaptive= find(wrapper_chicken(:,1)==2 & wrapper_chicken(:,2)==3)
 chicken_warmup  =find(wrapper_chicken(:,1)==2 & wrapper_chicken(:,2)==1)
 chicken_training= find(wrapper_chicken(:,1)==2 & wrapper_chicken(:,2)==0)
 
 
 
counter= size(chicken_baseline);
fprintf('trials in baseline = %d ', counter(1,1));
bsln_tot_trials=counter(1,1)
clear counter;
counter=size(chicken_adaptive)
fprintf('trials in adaptive = %d ', counter(1,1));
adaptive_tot_trials=counter(1,1)
clear counter;
counter=size(chicken_warmup)
warmup_tot_trials=counter(1,1)
fprintf('trials in chicken_warmup= %d ', counter(1,1));
clear counter;
counter=size(chicken_training)
training_tot_trials=counter(1,1)
fprintf('trials in chicken training= %d ', counter(1,1));

%------ check the complete blocks ------- %
% see if there are any complete runs and how many are there - you might not need this here...
complete_trials_child=size(find(contains(data_chicken_child.state,'complete')),1) %it should be 33
% if the answer is 0, look for specific things see below
%% -------------------------------- Warm-up mode --------------------%
rows=find(contains(data_chicken_child.phase_type,'warmup'));
vars={'state','run_nr','trial_nr','block_nr',....
     'phase_type','difficulty','fixedSequence','correct',...
     'hutch_id_0','hutch_stimulusId_0','response_0','responseTime_0',...
     'hutch_id_1','hutch_stimulusId_1','response_1','responseTime_1',...
     'hutch_id_2','hutch_stimulusId_2','response_2','responseTime_2',...
     'hutch_id_3','hutch_stimulusId_3','response_3','responseTime_3',...
     }
 
data_chicken_child_warmup=data_chicken_child(rows,vars);
clear rows 
% ----- accuracy and RT time -------------- % 
rows1=find(contains(data_chicken_child_warmup.correct,'True'))
correct_nr_trls_warmup=size((rows1),1)

% count the incorrect ones
rows2=find(contains(data_chicken_child_warmup.correct,'False'))
incorrect_nr_trls_warmup=size((rows2),1)

% import only correct trials
chicken_warmup_correct=data_chicken_child_warmup(rows1,vars)
clear rows1 rows0

% proportion correct training (2 hutches)
warmup_percent_correct=correct_nr_trls_warmup/warmup_tot_trials

% export to excel
 
filename=[SubName '_childresults.xlsx'];

vars1=table(warmup_tot_trials, correct_nr_trls_warmup,incorrect_nr_trls_warmup,warmup_percent_correct)

writetable(vars1,filename,'Sheet',1)

clear vars1 sheet


%%
%%------------------------------------ Training mode------------------------ %%
rows=find(contains(data_chicken_child.phase_type,'training'));

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
data_chicken_child_training=data_chicken_child(rows,vars);
clear rows 
% ----- accuracy and RT time -------------- % 
rows1=find(contains(data_chicken_child_training.correct,'True'))
correct_nr_trls_training=size((rows1),1)

% count the incorrect ones
rows2=find(contains(data_chicken_child_training.correct,'False'))
incorrect_nr_trls_training=size((rows2),1)

% import only correct trials
chicken_training_correct=data_chicken_child_training(rows1,vars)
clear rows1 rows0

% proportion correct training (2 hutches)
training_percent_correct=correct_nr_trls_training/training_tot_trials


% export to excel
 
vars1=table(training_tot_trials, correct_nr_trls_training,incorrect_nr_trls_training,training_percent_correct)
writetable(vars1,filename,'Sheet',2)

clear vars1 sheet



%% -------- Extract BASELINE trials and calculate accuracy in RA mode --------- %%
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

% calculate tot trials baseline
rows0=find(contains(data_chicken_child_baseline.correct,''))
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

%count the tot trials
rows0=find(contains(data_chicken_child_adaptive.correct,''))
tot_trials_adaptive=size((rows0),1)

% count the correct ones 
rows1=find(contains(data_chicken_child_adaptive.correct,'True'))
correct_nr_trls_adaptive=size((rows1),1)

% count the incorrect ones
rows2=find(contains(data_chicken_child_adaptive.correct,'False'))
incorrect_nr_trls_adaptive=size((rows2),1)

% import only correct trials
chicken_adaptive_correct=data_chicken_child_adaptive(rows1,vars)
clear rows0 rows1 rows2
%% count the difficulty and the proportion of correct trials - do these even change???

 % proportion of correct responses BASELINE (difficulty=3)
 baseline_percent_correct=correct_nr_trls_baseline/tot_trials_baseline
 
 % total percent ADAPTIVE
 
adaptive_percent_correct=correct_nr_trls_adaptive/tot_trials_adaptive

% ------------- accuracy for specific blocks - this won't work for
% uncomplete runs
% block=0 --> 3 hutches
% block = 1 --> 4 hutches
% block = 2 --> 5 hutches

% % ---------------------- 1 hutches -------------------------
rows1=find(contains(data_chicken_child_adaptive.difficulty,'1'))
% 
data_child_adaptive_1hutches=data_chicken_child_adaptive(rows1,vars)
% 
acc_adaptive_1hutches=find(contains(data_child_adaptive_1hutches.correct,'True'))
% 
acc_adaptive_1hutches= size(acc_adaptive_1hutches,1)



% % ---------------------- 2 hutches -------------------------
rows2=find(contains(data_chicken_child_adaptive.difficulty,'2'))
% 
data_child_adaptive_2hutches=data_chicken_child_adaptive(rows2,vars)
% 
acc_adaptive_2hutches=find(contains(data_child_adaptive_2hutches.correct,'True'))
% 
acc_adaptive_2hutches= size(acc_adaptive_2hutches,1)

% ---------------------- 3 hutches -------------------------
rows3=find(contains(data_chicken_child_adaptive.difficulty,'3'))

% rows0= data_chicken_child_adaptive.difficulty(1:6,1)

data_child_adaptive_3hutches=data_chicken_child_adaptive(rows3,vars)

acc_adaptive_3hutches=find(contains(data_child_adaptive_3hutches.correct,'True'))

acc_adaptive_3hutches= size(acc_adaptive_3hutches,1)

% --------------------- 4 hutches -------------------
rows4=find(contains(data_chicken_child_adaptive.difficulty,'4'))

data_child_adaptive_4hutches=data_chicken_child_adaptive(rows4,vars)

acc_adaptive_4hutches=find(contains(data_child_adaptive_4hutches.correct,'True'))

acc_adaptive_4hutches= size(acc_adaptive_4hutches,1)



% ---------------------- 5 hutches ----------------------------- %

rows5 = find(contains(data_chicken_child_adaptive.difficulty,'5'))

data_child_adaptive_5hutches=data_chicken_child_adaptive(rows5,vars)

acc_adaptive_5hutches=find(contains(data_child_adaptive_5hutches.correct,'True'))

acc_adaptive_5hutches= size(acc_adaptive_5hutches,1)



% ------------------ 6 hutches ---------------------------------- %

rows6= find(contains(data_chicken_child_adaptive.difficulty,'6'))


data_child_adaptive_6hutches=data_chicken_child_adaptive(rows6,vars)

acc_adaptive_6hutches=find(contains(data_child_adaptive_6hutches.correct,'True'))

acc_adaptive_6hutches= size(acc_adaptive_6hutches,1)

% if needed it can continue....

% -------- 7 hutches ------------- %

rows7= find(contains(data_chicken_child_adaptive.difficulty,'7'))

data_child_adaptive_7hutches=data_chicken_child_adaptive(rows7,vars)

acc_adaptive_7hutches=find(contains(data_child_adaptive_7hutches.correct,'True'))

acc_adaptive_7hutches= size(acc_adaptive_7hutches,1)

% ---- 8 hutches -------------- %
rows8= find(contains(data_chicken_child_adaptive.difficulty,'8'))


data_child_adaptive_8hutches=data_chicken_child_adaptive(rows8,vars)

acc_adaptive_8hutches=find(contains(data_child_adaptive_8hutches.correct,'True'))

acc_adaptive_8hutches= size(acc_adaptive_8hutches,1)


% -------------- proportion correct/incorrect ------------------- %
 %  1 hutches 
 adaptive_1hutches=acc_adaptive_1hutches/size(rows1,1) %save this
 %  2 hutches 
 adaptive_2hutches=acc_adaptive_2hutches/size(rows2,1) %save this
 %  3 hutches
 adaptive_3hutches=acc_adaptive_3hutches/size(rows3,1) % save this
 %  4 hutches 
 adaptive_4hutches=acc_adaptive_4hutches/size(rows4,1) % save this
 %  5 hutches 
 adaptive_5hutches=acc_adaptive_5hutches/size(rows5,1) %save this
 % it can continue if needed
 %  6 hutches 
 adaptive_6hutches=acc_adaptive_6hutches/size(rows6,1) %save this
 % it can continue if needed
  %  7 hutches 
 adaptive_7hutches=acc_adaptive_7hutches/size(rows7,1) %save this
 % it can continue if needed
 
  adaptive_8hutches=acc_adaptive_8hutches/size(rows8,1) %save this
 % it can continue if needed
 
clear rows0 rows1 rows2 rows3 rows4 rows5 rows6 rows7 rows8 

%%  write results to excel file
 %1st sheet is baseline
 
vars1=table(complete_trials_child, bsln_tot_trials,correct_nr_trls_baseline,baseline_percent_correct)

writetable(vars1,filename,'Sheet',3)

clear vars1 sheet

% 2nd sheet is adaptive phase
vars2=table(adaptive_tot_trials,...
    correct_nr_trls_adaptive,...
    adaptive_percent_correct,...
    acc_adaptive_1hutches,...
    adaptive_1hutches,...
    acc_adaptive_2hutches,...
    adaptive_2hutches,...
    acc_adaptive_3hutches,...
    adaptive_3hutches,...
    acc_adaptive_4hutches,...
    adaptive_4hutches,...
    acc_adaptive_5hutches,...
    adaptive_5hutches,...
    acc_adaptive_6hutches,...
    adaptive_6hutches,...
    acc_adaptive_7hutches,...
    adaptive_7hutches,...
    acc_adaptive_8hutches,...
    adaptive_8hutches)

writetable(vars2,filename,'Sheet',4)

winopen([SubName '_childresults.xlsx']);

clear vars2




