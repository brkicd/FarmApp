%% Learning slopes - SHEEP game 
clear all;
close all;
clc;restoredefaultpath

addpath 'Z:\BINGO - PID\Data\App data\Participants json files\Not yet processed\Diandra\scripts\*'
%addpath 'Z:\BINGO - PID\Data\App data\Participants json files\Not yet processed\BINGO group\excel\*'
addpath 'Z:\BINGO - PID\Data\App data\Participants json files\Not yet processed\CALM group\excel_data\*'
addpath 'Z:\BINGO - PID\Data\App data\Participants json files\Not yet processed\CALM group\learning_slopes\*'
%% Subject details
SubName= 'BICA31'; %'BICA59','BICA6'};
% opts=detectImportOptions(['Z:\BINGO - PID\Data\App data\Participants json files\Not yet processed\BINGO group\excel\',SubName, '-data.csv'],'NumHeaderLines',0); % this is for the headers names
% data=readtable(['Z:\BINGO - PID\Data\App data\Participants json files\Not yet processed\BINGO group\excel\',SubName, '-data.csv'],opts);

opts=detectImportOptions(['Z:\BINGO - PID\Data\App data\Participants json files\Not yet processed\CALM group\excel_data\',SubName, '-data.csv'],'NumHeaderLines',0); % this is for the headers names
data=readtable(['Z:\BINGO - PID\Data\App data\Participants json files\Not yet processed\CALM group\excel_data\',SubName, '-data.csv'],opts);

%% --------------------------- Sheep game first-child mode ------------------------- %
% I GAME - sheep
task=find(contains(data.task_id,'sheep'));  %index of the complete state
data_sheep_raw=(data(task,:));

% II mode - RA or child
mode= find(contains(data_sheep_raw.mode,'child'))
data_sheep_child=(data_sheep_raw(mode,:))

% III complete trials only 
state= find(contains(data_sheep_child.state,'complete'))
data_sheep_child_complete=(data_sheep_child(state,:));

% IV adaptive and complete phase only 
phase=find(contains(data_sheep_child_complete.phase_type,'adaptive'))
sheep_child_adaptive=(data_sheep_child_complete(phase,:))

% V adaptive incomplete
vars={'state','run_nr','trial_nr','trial_type','phase_type','block_nr','block_type','response_0','duration','responseTime_0', 'fixationDuration', 'stimulusId', 'predicted'}
phase2=find(contains(data_sheep_child.phase_type,'adaptive'))
sheep_child_adaptive_all=(data_sheep_child(phase2,vars))

% beggining of a trial


    for row=find(sheep_child_adaptive_all.trial_nr==0)
       sheep_child_adaptive_all.block_nr_2(row,1)=1
    end
block_nr=size(find(sheep_child_adaptive_all.block_nr_2==1),1)

for row=find(sheep_child_adaptive_all.block_nr_2==1)
     sheep_child_adaptive_all.block_nr_3(row,1)=1:1:block_nr
end
 

for i=1:length(sheep_child_adaptive_all.block_nr_3)
    %row=find(sheep_child_adaptive_all.block_nr_2>=1)
    j=find(sheep_child_adaptive_all.block_nr_3~=0)
    for z=find(sheep_child_adaptive_all.block_nr_3==0)
        %sheep_child_adaptive_all.block_nr_4(z)=sheep_child_adaptive_all.block_nr_3(row,1)
       %sheep_child_adaptive_all.block_nr_4(z)=1:sheep_child_adaptive_all.block_nr_3(j):j
    sheep_child_adaptive_all.block_nr_4(z)=repelem(sheep_child_adaptive_all.block_nr_3(j),[1:) %FIX ME
    end
    
end


 %% code the blocks in succession of presentation
% for i=size(sheep_child_adaptive,1)
%     for j=size(sheep_child_adaptive.trial_nr(1:20,1))
%     sheep_child_adaptive.block_nr_2(j)=1
%     
%     end
% end

%% extract mean stim duration over blocks

vars={'state','run_nr','trial_nr','trial_type','phase_type','block_nr','block_type','response_0','duration','responseTime_0', 'fixationDuration', 'stimulusId', 'predicted'}

data_sheep=sheep_child_adaptive(:,vars)

% create a forloop that keeps track of blocs in order
% for j=1:length(data_sheep.trial_nr)
%  for k=1:length(a(bl_nr))
%      data_sheep.block_nr_2(1:k,1)=bl_nr(j)
% end
% end
% 
% for j=length(data_sheep.trial_nr)
%     for m=1:length(a)
%      data_sheep.block_nr_2(a,1)=bl_nr(m,1)
% end
% end
%% This is for complete blocks only 
num_rows=size(data_sheep,1)
nr_blocks=size(data_sheep,1)/20
a=1:20:size(data_sheep)
bl_nr=1:1:nr_blocks

% if data_sheep.trial_nr(:,1)<=20
%     data_sheep.block_nr_2(1:20,1)=1
% else 
%     data_sheep.block_nr_2(21:40,1)=2
% end
% 
% 
% i=20
% m=1

% for g=1:length(data_sheep.block_nr_2)
%  data_sheep.block_nr_2(v)=m
%  data_sheep.block_nr_2(v+k)=m+1
%  data_sheep.block_nr_2(v+2*k)=m+2
%  data_sheep.block_nr_2(v+3*k)=m+3
% data_sheep.block_nr_2(v+4*k)=m+4
% end



data_sheep.block_nr_2=zeros(num_rows,1)
bl_num_rep=repelem(bl_nr,20)
data_sheep.block_nr_2(a)=bl_nr
data_sheep.block_nr_3=zeros(num_rows,1)
data_sheep.block_nr_3(:,1)=bl_num_rep



%% write results to excel files
cd 'Z:\BINGO - PID\Data\App data\Participants json files\Not yet processed\CALM group\learning_slopes'

filename=[SubName 'LS_sheep.xlsx'];

writetable(data_sheep, filename,'Sheet',1)

winopen([SubName 'LS_sheep.xlsx']);

%%

