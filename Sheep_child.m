% Exctract CHILD Sheep Game 

clear all;
close all;
clc;restoredefaultpath

addpath 'Z:\BINGO - PID\Data\App data\Participants json files\Not yet processed\Diandra\scripts'
addpath 'Z:\BINGO - PID\Data\App data\Participants json files\Not yet processed\CALM group\excel_data\*'


cd 'Z:\BINGO - PID\Data\App data\Participants json files\Not yet processed\CALM group\excel_results'

%% Subject details
SubName= 'BICA6'; %'BICA59','BICA6'};
opts=detectImportOptions(['Z:\BINGO - PID\Data\App data\Participants json files\Not yet processed\CALM group\excel_data\',SubName, '-data.csv'],'NumHeaderLines',0); % this is for the headers names
data=readtable(['Z:\BINGO - PID\Data\App data\Participants json files\Not yet processed\CALM group\excel_data\',SubName, '-data.csv'],opts);

%% --------------------------- Sheep game first-vhild mode ------------------------- %
    
task=find(contains(data.task_id,'sheep'));  %index of the complete state

%task=find(ismember(data.task_id(:),'sheep'));

% take only the complete runs in all modalities
data_sheep=(data(task,:));

mode=find(contains(data_sheep.mode,'child'));
%mode=find(ismember(data_sheep.mode(:),'RA'));

data_sheep_child=(data_sheep(mode,:));


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


% --------------------------- Child MODE tot and complete trials------------------------------- %
sheep_child_tot_trials=size(find(wrapper_sheep(:,1)==2),1)

complete_trials_child=size(find(contains(data_sheep_child.state,'complete')),1)

 sheep_baseline_child=size(find(wrapper_sheep(:,1)==2 & wrapper_sheep(:,2)==2),1)
 sheep_adaptive_child=size(find(wrapper_sheep(:,1)==2 & wrapper_sheep(:,2)==3),1)
 sheep_warmup_child  =size(find(wrapper_sheep(:,1)==2 & wrapper_sheep(:,2)==1),1)
 
 %---------------------------- export data in excel----------------------%

vars1=table(sheep_child_tot_trials,complete_trials_child, sheep_baseline_child, sheep_adaptive_child, sheep_warmup_child);

filename=[SubName '_childresults2.xlsx'];

writetable(vars1,filename,'Sheet',1)

clear rows1 vars vars1
 
 

%% -------------------- Extract BASELINE trials ------------------- %
%let's try simple indexing - get only the basline trials
%-------------------------- MODE first - child ---------------------- %
rows=find(contains(data_sheep_child.phase_type,'baseline'));
vars={'state','run_nr','trial_nr','trial_type','phase_type','block_nr','block_type','response_0','duration','responseTime_0'};
data_sheep_child_baseline=data_sheep_child(rows,vars);
clear rows vars

tot_go_trials_bsln= size(find(contains(data_sheep_child_baseline.block_type,'go')),1)

tot_mixed_trials_bsln=size(find(contains(data_sheep_child_baseline.block_type,'mixed')),1)

% -------------------------------- accuracy and RTs ---------------------
rows1=find(contains(data_sheep_child_baseline.response_0,'True'));
correct_nr_tr_baseline=size((rows1),1);
%count the incorrect trials
rows2=find(contains(data_sheep_child_baseline.response_0,'False'));
incorrect_nr_tr_baseline=size((rows2),1);    % you might not need this
% import only the correct trials (go + mixed)
vars={'state','run_nr','trial_nr','trial_type','phase_type','block_nr','block_type','response_0','duration','responseTime_0'};
data_sheep_child_baseline_correct=data_sheep_child_baseline(rows1,vars);

RT_baseline_correct= mean(data_sheep_child_baseline_correct.responseTime_0,1)

clear rows1 

% ----------------- accuracy Baseline - go only -------------------------%
vars={'state','run_nr','trial_nr','trial_type','phase_type','block_nr','block_type','response_0','duration','responseTime_0'};

rows1=find(contains(data_sheep_child_baseline.block_type,'go'));

data_sheep_child_gonly_bsln=data_sheep_child_baseline(rows1,vars);

acc_go_only_bsln=size((find(contains(data_sheep_child_gonly_bsln.response_0,'True'))),1);

rows2=find(strcmp(data_sheep_child_baseline_correct.block_type,'go'));

go_only_baseline_correct=data_sheep_child_baseline_correct(rows2,vars)

RT_go_only_bsln=mean(go_only_baseline_correct.responseTime_0,1); % you need to save this!

clear rows1 rows2
% ----------------- accuracy Baseline - mixed  -------------------------%

rows0=find(contains(data_sheep_child_baseline.block_type,'mixed'));

data_sheep_child_mix_bsln=data_sheep_child_baseline(rows0,vars);

mix_bsln_tot_trials=size(rows0,1) % you can save this if needed!

rows1=find(strcmp(data_sheep_child_mix_bsln.trial_type,'go'))

goonly_mix_tot_trls=size(rows1,1)

acc_mix_bsln=size((find(contains(data_sheep_child_mix_bsln.response_0,'True'))),1)

rows2=find(strcmp(data_sheep_child_baseline_correct.block_type,'mixed'))


mix_bsln_correct=data_sheep_child_baseline_correct(rows2,vars)

% mixed overall RT 
RT_mix_bsln= mean(mix_bsln_correct.responseTime_0,1);

% go-only mixed acuracy & RT

rows3= find(strcmp(mix_bsln_correct.trial_type,'go'))

goonly_mixed_data=mix_bsln_correct(rows3,vars)

acc_goonly_mix=size(rows3,1)

RT_goonly_mix_bsln=mean(goonly_mixed_data.responseTime_0,1) % you need to save this!

clear rows1 rows2
%----------- Baseline -mixed no go trials only --------------------------- %

rows1=find(contains(data_sheep_child_mix_bsln.trial_type,'nogo'));

data_sheep_child_nogo_bsln=data_sheep_child_mix_bsln(rows1,vars);

nogo_bsln_tot_trials= size(rows1,1) % you can save this if needed!

rows2=find(contains(data_sheep_child_mix_bsln.response_0(rows1),'True'));

acc_nogo_baseline=size(rows2,1)

data_sheep_child_nogo_bsln_correct=data_sheep_child_nogo_bsln(rows2, vars)

%Nogo_bsln_duration=mean(data_sheep_child_nogo_bsln.duration,1)



runs_baseline=(size(data_sheep_child_baseline.run_nr,1))/40

baseline_tot_accuracy=correct_nr_tr_baseline(1,1)/sheep_baseline_child %baseline overall accuracy

goonly_accuracy=acc_go_only_bsln/tot_go_trials_bsln %goonly block accuracy

mixed_tot_accuracy=acc_mix_bsln/mix_bsln_tot_trials

goonly_mix_accuracy= acc_goonly_mix/goonly_mix_tot_trls

no_go_mix_accuracy= acc_nogo_baseline/nogo_bsln_tot_trials


%---------------------------- export data in excel----------------------%

corret_trls_baseline=correct_nr_tr_baseline(1,1);

vars1=table(runs_baseline,...
    sheep_baseline_child,...
    corret_trls_baseline,...
    baseline_tot_accuracy,...
    RT_baseline_correct,...
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


% xlswrite([SubName '_childresults.xlsx'],vars1, sheet)

writetable(vars1,filename,'Sheet',2)

clear rows1 vars vars1

%% -------------------- Extract ADAPTIVE trials ------------------- %
%let's try simple indexing - get only the basline trials
%-------------------------- MODE first - child ---------------------- %
rows=find(contains(data_sheep_child.phase_type,'adaptive'));
vars={'state','run_nr','trial_nr','trial_type','phase_type','block_nr','block_type','response_0','duration','responseTime_0'}
data_sheep_child_adaptive=data_sheep_child(rows,vars);
how_many_tot_trials=size(rows,1)
how_many_nogo=(size(find(contains(data_sheep_child_adaptive.trial_type,'nogo')),1))
how_many_go=(size(find(strcmp(data_sheep_child_adaptive.trial_type,'go')),1))
clear rows vars
% -------------------------------- accuracy and RTs ---------------------
rows1=find(contains(data_sheep_child_adaptive.response_0,'True'));
correct_nr_tr_adaptive=size((rows1),1);
%count the incorrect trials
rows2=find(contains(data_sheep_child_adaptive.response_0,'False'));
incorrect_nr_tr_adaptive=size((rows2),1);    % you might not need this

% import only the correct trials (go + mixed)

vars={'state','run_nr','trial_nr','trial_type','phase_type','block_nr','block_type','response_0','duration','responseTime_0'};

data_sheep_child_adaptive_correct=data_sheep_child_adaptive(rows1,vars);

RT_adaptive=mean(data_sheep_child_adaptive_correct.responseTime_0,1)

clear rows1 
%% -------------------------- Stimulus duration changes ------------------- %
rows1=find(contains(data_sheep_child_adaptive.trial_type,'nogo'));

data_sheep_child_nogo_adaptive=data_sheep_child_adaptive(rows1,vars);

rows2=find(contains(data_sheep_child_nogo_adaptive.response_0,'True'));

data_sheep_child_nogo_adaptive_correct=data_sheep_child_nogo_adaptive(rows2,vars);

acc_nogo_adaptive=size(rows2,1)

Nogo_adaptive_duration=nanmean(data_sheep_child_nogo_adaptive_correct.duration,1)


clear rows1 rows2
%% ------------- go only trials in adaptive phase --------------- %

rows1=find(strcmp(data_sheep_child_adaptive_correct.trial_type,'go')); 

data_sheep_child_go_adaptive=data_sheep_child_adaptive_correct(rows1,vars) ;

rows2=find(contains(data_sheep_child_go_adaptive.response_0,'True'));

acc_go_only=size(rows2,1)

data_sheep_child_go_adaptive_correct=data_sheep_child_go_adaptive(rows2,vars);

RT_goonly_adaptive=nanmean(data_sheep_child_go_adaptive_correct.responseTime_0,1)


runs_adaptive=(size(data_sheep_child_adaptive.run_nr,1))/60

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
    RT_goonly_adaptive,...
    how_many_nogo,...
    acc_nogo_adaptive,...
    nogo_accuracy,...
    Nogo_adaptive_duration);

% sheet=3;
% xlswrite([SubName '_RAresults.xlsx'],vars1,sheet);

writetable(vars1,filename, 'Sheet',3)

winopen([SubName '_childresults2.xlsx']);

clear rows1 vars vars1

