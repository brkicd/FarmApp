%% extract min trials RA mode - BINGO dataset

clear all;
close all;
clc;restoredefaultpath

addpath 'Z:\BINGO - PID\Data\App data\Participants json files\Not yet processed\Diandra\scripts\FarmApp'
addpath 'Z:\BINGO - PID\Data\App data\Participants json files\Not yet processed\BINGO group\excel\*'


cd 'Z:\BINGO - PID\Data\App data\Participants json files\Not yet processed\BINGO group\RA_mode\sheep_RA\excel_output'

%% Subject details
SubName= 'BIZDH44'; %'BICA59','BICA6'};
opts=detectImportOptions(['Z:\BINGO - PID\Data\App data\Participants json files\Not yet processed\BINGO group\excel\',SubName, '-data.csv'],'NumHeaderLines',0); % this is for the headers names
data=readtable(['Z:\BINGO - PID\Data\App data\Participants json files\Not yet processed\BINGO group\excel\',SubName, '-data.csv'],opts);

%% --------------------------- Sheep game first-RA ------------------------- %
    
task=find(contains(data.task_id,'sheep'));  %index of the complete state

%task=find(ismember(data.task_id(:),'sheep'));

% take only the complete runs in all modalities
data_sheep=(data(task,:));

mode=find(contains(data_sheep.mode,'ra'));
%mode=find(ismember(data_sheep.mode(:),'RA'));

data_sheep_RA=(data_sheep(mode,:));


% check how many trials in each mode
 % wrapper_sheep (i,1) --> 1= 'ra', 2='child', 3='adult'
 for i=1:size(data_sheep,1)
     if strfind(data_sheep.mode{i}, 'ra')==1  % how many runs were completed, check this with the descriptive spreadhseets
             wrapper_sheep(i,1)=1;  
     end
      if strfind(data_sheep.mode{i}, 'child')==1  % how many runs were completed, check this with the descriptive spreadhseets
             wrapper_sheep(i,1)=2;  
      end
      if strfind(data_sheep.mode{i}, 'adult')==1  % how many runs were completed, check this with the descriptive spreadhseets
             wrapper_sheep(i,1)=3;  
     end
 end 
  % ----------------------- find baseline and adaptive trials ------------------ %
   % wrapper_sheep (i,2) --> 2=baseline; 3=adaptive; 1=warmup; 0=training
   
  for i=1:size(data_sheep,1)
     if strfind(data_sheep.phase_type{i}, 'baseline')==1  % how many runs were completed, check this with the descriptive spreadhseets
             wrapper_sheep(i,2)=2;  
     end
      if strfind(data_sheep.phase_type{i}, 'adaptive')==1  % how many runs were completed, check this with the descriptive spreadhseets
             wrapper_sheep(i,2)=3;  
      end
     if strfind(data_sheep.phase_type{i}, 'warmup')==1  % how many runs were completed, check this with the descriptive spreadhseets
             wrapper_sheep(i,2)=1;  
     end  
      
      if strfind(data_sheep.phase_type{i}, 'training')==1  % how many runs were completed, check this with the descriptive spreadhseets
             wrapper_sheep(i,2)=0;  
      end
      
  
  end


% --------------------------- RA MODE tot and complete trials------------------------------- %
sheep_RA_tot_trials=size(find(wrapper_sheep(:,1)==1),1)

complete_trials_RA=size(find(contains(data_sheep_RA.state,'complete')),1)

 sheep_baseline_RA=size(find(wrapper_sheep(:,1)==1 & wrapper_sheep(:,2)==2),1)
 sheep_adaptive_RA=size(find(wrapper_sheep(:,1)==1 & wrapper_sheep(:,2)==3),1)
 sheep_warmup_RA  =size(find(wrapper_sheep(:,1)==1 & wrapper_sheep(:,2)==1),1)
 sheep_training_RA=size(find(wrapper_sheep(:,1)==1 & wrapper_sheep(:,2)==0),1)
 
 
 
 %% %% ------------- Exctract TRAINING trials --------------------- %
 
rows=find(contains(data_sheep_RA.phase_type,'training'))
vars={'state','mode','run_nr','trial_nr','trial_type','phase_type','block_nr','block_type','response_0','duration','responseTime_0'}
data_sheep_ra_training=data_sheep_RA(rows,vars)

training_goonly_trials=size(find(contains(data_sheep_ra_training.trial_type,'go')),1)

training_mix_trials=size(find(contains(data_sheep_ra_training.block_type,'mixed')),1)

training_nogo_trials=size(find(contains(data_sheep_ra_training.trial_type,'nogo')),1)


% ----------------- accuracy training - go only -------------------------%

vars={'state','mode','run_nr','trial_nr','trial_type','phase_type','block_nr','block_type','response_0','duration','responseTime_0'}

rows1=find(contains(data_sheep_ra_training.response_0,'True'));

data_sheep_RA_training_correct=data_sheep_ra_training(rows1,vars);

acc_training=size(rows1,1)

RT_training=mean(data_sheep_RA_training_correct.responseTime_0,1); % you need to save this!

clear rows1 

%--------  accuracy and RT go only

rows1=find(strcmp(data_sheep_RA_training_correct.trial_type,'go'));

acc_training_goonly=size(rows1,1)

training_goonly=data_sheep_RA_training_correct(rows1,vars)

RT_training_goonly=mean(training_goonly.responseTime_0,1); % you need to save this!

clear rows1

% ------------ NOGO accuracy 

rows1=find(contains(data_sheep_RA_training_correct.trial_type,'nogo'));

%rows1=find(ismember(data_sheep_RA_training_correct.trial_type(:),'nogo'));

acc_training_nogo=size(rows1,1)

RT_go_only_training=mean(data_sheep_RA_training_correct.responseTime_0,1); % you need to save this!

clear rows1

% export data in excel 
vars1=table(sheep_training_RA,training_mix_trials,acc_training,RT_training,training_goonly_trials,acc_training_goonly, RT_training_goonly,training_nogo_trials,acc_training_nogo)
filename=[SubName '_RAresults1.xlsx'];

writetable(vars1,filename,'Sheet',1)

clear rows1 vars vars1

%%
 
 %---------------------------- export data in excel----------------------%

vars1=table(sheep_RA_tot_trials,complete_trials_RA, sheep_baseline_RA, sheep_adaptive_RA, sheep_warmup_RA);

filename=[SubName '_RAresults1.xlsx'];

writetable(vars1,filename,'Sheet',2)

clear rows1 vars vars1
 


%% -------------------- Extract BASELINE trials ------------------- %
%let's try simple indexing - get only the basline trials
%-------------------------- MODE first - RA ---------------------- %
rows=find(contains(data_sheep_RA.phase_type,'baseline'));
vars={'state','run_nr','trial_nr','trial_type','phase_type','block_nr','block_type','response_0','duration','responseTime_0'};
data_sheep_RA_baseline=data_sheep_RA(rows,vars);
clear rows vars

tot_go_trials_bsln= size(find(contains(data_sheep_RA_baseline.block_type,'go')),1)

tot_mixed_trials_bsln=size(find(contains(data_sheep_RA_baseline.block_type,'mixed')),1)

% -------------------------------- accuracy and RTs ---------------------
rows1=find(contains(data_sheep_RA_baseline.response_0,'True'));
correct_nr_tr_baseline=size((rows1),1);
%count the incorrect trials
rows2=find(contains(data_sheep_RA_baseline.response_0,'False'));
incorrect_nr_tr_baseline=size((rows2),1);    % you might not need this
% import only the correct trials (go + mixed)
vars={'state','run_nr','trial_nr','trial_type','phase_type','block_nr','block_type','response_0','duration','responseTime_0'};
data_sheep_RA_baseline_correct=data_sheep_RA_baseline(rows1,vars);

RT_baseline= mean(data_sheep_RA_baseline_correct.responseTime_0,1)

clear rows1 

% ----------------- accuracy Baseline - go only block -------------------------%
vars={'state','run_nr','trial_nr','trial_type','phase_type','block_nr','block_type','response_0','duration','responseTime_0'};

rows1=find(strcmp(data_sheep_RA_baseline.block_type,'go'));

data_sheep_RA_gonly_bsln=data_sheep_RA_baseline(rows1,vars);

acc_go_only_bsln=size((find(contains(data_sheep_RA_gonly_bsln.response_0,'True'))),1);

rows2=find(strcmp(data_sheep_RA_baseline_correct.block_type,'go'));

go_only_baseline_correct=data_sheep_RA_baseline_correct(rows2,vars)

RT_go_only_bsln=mean(go_only_baseline_correct.responseTime_0,1); % you need to save this!

clear rows1 rows2
% ----------------- accuracy Baseline - mixed  -------------------------%

rows0=find(contains(data_sheep_RA_baseline.block_type,'mixed'));

data_sheep_RA_mix_bsln=data_sheep_RA_baseline(rows0,vars);

mix_bsln_tot_trials=size(rows0,1) % you can save this if needed!

rows1=find(strcmp(data_sheep_RA_mix_bsln.trial_type,'go'))

goonly_mix_tot_trls=size(rows1,1)

acc_mix_bsln=size((find(contains(data_sheep_RA_mix_bsln.response_0,'True'))),1)

rows2=find(strcmp(data_sheep_RA_baseline_correct.block_type,'mixed'))

mix_bsln_correct=data_sheep_RA_baseline_correct(rows2,vars)

% mixed overall RT 
RT_mix_bsln= mean(mix_bsln_correct.responseTime_0,1);

rows3= find(strcmp(mix_bsln_correct.trial_type,'go'))

goonly_mixed_data=mix_bsln_correct(rows3,vars)

acc_goonly_mix=size(rows3,1)

RT_goonly_mix_bsln=mean(goonly_mixed_data.responseTime_0,1) % you need to save this!

clear rows1 rows2
%----------- Baseline -mixed no go trials only --------------------------- %

rows1=find(contains(data_sheep_RA_mix_bsln.trial_type,'nogo'));

data_sheep_RA_nogo_bsln=data_sheep_RA_mix_bsln(rows1,vars);

nogo_bsln_tot_trials= size(rows1,1) % you can save this if needed!

rows2=find(contains(data_sheep_RA_mix_bsln.response_0(rows1),'True'));

acc_nogo_baseline=size(rows2,1)

data_sheep_RA_nogo_bsln_correct=data_sheep_RA_nogo_bsln(rows2, vars)

%Nogo_bsln_duration=mean(data_sheep_RA_nogo_bsln.duration,1)


runs_baseline=(size(data_sheep_RA_baseline.run_nr,1))/40

baseline_tot_accuracy=correct_nr_tr_baseline(1,1)/sheep_baseline_RA %baseline overall accuracy

goonly_accuracy=acc_go_only_bsln/tot_go_trials_bsln %goonly block accuracy

mixed_tot_accuracy=acc_mix_bsln/mix_bsln_tot_trials

goonly_mix_accuracy= acc_goonly_mix/goonly_mix_tot_trls

no_go_mix_accuracy= acc_nogo_baseline/nogo_bsln_tot_trials


%---------------------------- export data in excel----------------------%

corret_trls_baseline=correct_nr_tr_baseline(1,1);

vars1=table(runs_baseline,...
    sheep_baseline_RA,...
    corret_trls_baseline,...
    baseline_tot_accuracy,...
    RT_baseline,...
    tot_go_trials_bsln,...
    acc_go_only_bsln,...
    goonly_accuracy,...
    RT_go_only_bsln,...
    mix_bsln_tot_trials,...
    acc_mix_bsln,...
    mixed_tot_accuracy,...
    goonly_mix_tot_trls,...
    acc_goonly_mix,...
    goonly_mix_accuracy,...
    RT_mix_bsln,...
    RT_goonly_mix_bsln,...
    nogo_bsln_tot_trials,...
    acc_nogo_baseline,...
    no_go_mix_accuracy)


% xlswrite([SubName '_RAresults.xlsx'],vars1, sheet)

writetable(vars1,filename,'Sheet',3)

clear rows1 vars vars1

%% -------------------- Extract ADAPTIVE trials ------------------- %
%let's try simple indexing - get only the basline trials
%-------------------------- MODE first - RA ---------------------- %
rows=find(contains(data_sheep_RA.phase_type,'adaptive'));
vars={'state','run_nr','trial_nr','trial_type','phase_type','block_nr','block_type','response_0','duration','responseTime_0'}
data_sheep_RA_adaptive=data_sheep_RA(rows,vars);
how_many_tot_trials=size(rows,1)
how_many_nogo=(size(find(contains(data_sheep_RA_adaptive.trial_type,'nogo')),1))
how_many_go=(size(find(strcmp(data_sheep_RA_adaptive.trial_type,'go')),1))
clear rows vars
% -------------------------------- accuracy and RTs ---------------------
rows1=find(contains(data_sheep_RA_adaptive.response_0,'True'));
correct_nr_tr_adaptive=size((rows1),1);
%count the incorrect trials
rows2=find(contains(data_sheep_RA_adaptive.response_0,'False'));
incorrect_nr_tr_adaptive=size((rows2),1);    % you might not need this

% import only the correct trials (go + mixed)

vars={'state','run_nr','trial_nr','trial_type','phase_type','block_nr','block_type','response_0','duration','responseTime_0'};

data_sheep_RA_adaptive_correct=data_sheep_RA_adaptive(rows1,vars);

RT_adaptive=mean(data_sheep_RA_adaptive_correct.responseTime_0,1)

clear rows1 
%% -------------------------- Stimulus duration changes ------------------- %
rows1=find(contains(data_sheep_RA_adaptive.trial_type,'nogo'));

data_sheep_RA_nogo_adaptive=data_sheep_RA_adaptive(rows1,vars);

rows2=find(contains(data_sheep_RA_nogo_adaptive.response_0,'True'));

data_sheep_RA_nogo_adaptive_correct=data_sheep_RA_nogo_adaptive(rows2,vars);

acc_nogo_adaptive=size(rows2,1)

Nogo_adaptive_duration=nanmean(data_sheep_RA_nogo_adaptive_correct.duration,1)


clear rows1 rows2
%% ------------- go only trials in adaptive phase --------------- %

rows1=find(strcmp(data_sheep_RA_adaptive_correct.trial_type,'go')); 

data_sheep_RA_go_adaptive=data_sheep_RA_adaptive_correct(rows1,vars) ;

rows2=find(contains(data_sheep_RA_go_adaptive.response_0,'True'));

acc_go_only=size(rows2,1)

data_sheep_RA_go_adaptive_correct=data_sheep_RA_go_adaptive(rows2,vars);

RT_go_adaptive=nanmean(data_sheep_RA_go_adaptive_correct.responseTime_0,1)

%%
runs_adaptive=(size(data_sheep_RA_adaptive.run_nr,1))/60

%------- calculate percent of correct responses ------%

tot_accuracy=correct_nr_tr_adaptive/how_many_tot_trials

goonly_accuracy=acc_go_only/how_many_go

nogo_accuracy=acc_nogo_adaptive/how_many_nogo

% ----------------------------- Write results in excel ----------------- %
vars1=table(runs_adaptive,...
    how_many_tot_trials,...
    correct_nr_tr_adaptive,...
    tot_accuracy,...
    RT_adaptive,...
    how_many_go,...
    acc_go_only,...
    goonly_accuracy,...
    RT_go_adaptive,...
    how_many_nogo,...
    acc_nogo_adaptive,...
    nogo_accuracy,...
    Nogo_adaptive_duration);

% sheet=3;
% xlswrite([SubName '_RAresults.xlsx'],vars1,sheet);

writetable(vars1,filename, 'Sheet',4)

winopen([SubName '_RAresults1.xlsx']);

clear rows1 vars vars1

