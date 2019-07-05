% meausre block-based no-go stim duration
%% Learning slopes - SHEEP game 
clear all;
close all;
clc;restoredefaultpath

cd 'Z:\BINGO - PID\Data\App data\Participants json files\Not yet processed\CALM group\learning_slopes'

%% Subject details
SubName= 'BIPAK166'; %'BICA59','BICA6'};
opts=detectImportOptions(['Z:\BINGO - PID\Data\App data\Participants json files\Not yet processed\CALM group\learning_slopes\',SubName, '_LS_sheep.xlsx'],'NumHeaderLines',0); % this is for the headers names
data=readtable(['Z:\BINGO - PID\Data\App data\Participants json files\Not yet processed\CALM group\learning_slopes\',SubName, '_LS_sheep.xlsx'],opts);

%% calculate mean stim duration par block
vars={'state','run_nr','trial_nr','trial_type','phase_type','block_nr','block_type','response_0','duration','responseTime_0', 'fixationDuration', 'stimulusId', 'predicted', 'block_nr2'}

% block 1

rows0=find(data.block_nr2==1)

block_one= data(rows0,vars)

rows1=find(contains(block_one.trial_type,'nogo'))

block_one_nogo=block_one(rows1,vars)

mean_nogo_1= mean(block_one_nogo.duration,1)

clear rows0 rows1

% block 2 
rows0=find(data.block_nr2==2)

block_two= data(rows0,vars)

rows1=find(contains(block_two.trial_type,'nogo'))

block_two_nogo=block_two(rows1,vars)

mean_nogo_2= mean(block_two_nogo.duration,1)

clear rows0 rows1

% block 3

rows0=find(data.block_nr2==3)

block_three= data(rows0,vars)

rows1=find(contains(block_three.trial_type,'nogo'))

block_3_nogo=block_three(rows1,vars)

mean_nogo_3= mean(block_3_nogo.duration,1)

clear rows0 rows1

%block 4

rows0=find(data.block_nr2==4)

block_4= data(rows0,vars)

rows1=find(contains(block_4.trial_type,'nogo'))

block_4_nogo=block_4(rows1,vars)

mean_nogo_4= mean(block_4_nogo.duration,1)

clear rows0 rows1

% block 5

rows0=find(data.block_nr2==5)

block_5= data(rows0,vars)

rows1=find(contains(block_5.trial_type,'nogo'))

block_5_nogo=block_5(rows1,vars)

mean_nogo_5= mean(block_5_nogo.duration,1)

clear rows0 rows1

% block 6

rows0=find(data.block_nr2==6)

block_6= data(rows0,vars)

rows1=find(contains(block_6.trial_type,'nogo'))

block_6_nogo=block_6(rows1,vars)

mean_nogo_6= mean(block_6_nogo.duration,1)

clear rows0 rows1

%block 7

rows0=find(data.block_nr2==7)

block_7= data(rows0,vars)

rows1=find(contains(block_7.trial_type,'nogo'))

block_7_nogo=block_7(rows1,vars)

mean_nogo_7= mean(block_7_nogo.duration,1)

clear rows0 rows1

%block 8

rows0=find(data.block_nr2==8)
block_8= data(rows0,vars)
rows1=find(contains(block_8.trial_type,'nogo'))
block_8_nogo=block_8(rows1,vars)
mean_nogo_8= mean(block_8_nogo.duration,1)
clear rows0 rows1

%block 9 

rows0=find(data.block_nr2==9)
block_9= data(rows0,vars)
rows1=find(contains(block_9.trial_type,'nogo'))
block_9_nogo=block_9(rows1,vars)
mean_nogo_9= mean(block_9_nogo.duration,1)
clear rows0 rows1

%block 10
rows0=find(data.block_nr2==10)

block_10= data(rows0,vars)

rows1=find(contains(block_10.trial_type,'nogo'))

block_10_nogo=block_10(rows1,vars)

mean_nogo_10= mean(block_10_nogo.duration,1)

clear rows0 rows1

% block 11
rows0=find(data.block_nr2==11)
block_11= data(rows0,vars)
rows1=find(contains(block_11.trial_type,'nogo'))
block_11_nogo=block_11(rows1,vars)
mean_nogo_11= mean(block_11_nogo.duration,1)
clear rows0 rows1

% block 12
rows0=find(data.block_nr2==12)
block_12= data(rows0,vars)
rows1=find(contains(block_12.trial_type,'nogo'))
block_12_nogo=block_12(rows1,vars)
mean_nogo_12= mean(block_12_nogo.duration,1)
clear rows0 rows1

% block 13
rows0=find(data.block_nr2==13)
block_13= data(rows0,vars)
rows1=find(contains(block_13.trial_type,'nogo'))
block_13_nogo=block_13(rows1,vars)
mean_nogo_13= mean(block_13_nogo.duration,1)
clear rows0 rows1

%block 14
rows0=find(data.block_nr2==14)
block_14= data(rows0,vars)
rows1=find(contains(block_14.trial_type,'nogo'))
block_14_nogo=block_14(rows1,vars)
mean_nogo_14= mean(block_14_nogo.duration,1)
clear rows0 rows1

%block 15
rows0=find(data.block_nr2==15)
block_15= data(rows0,vars)
rows1=find(contains(block_15.trial_type,'nogo'))
block_15_nogo=block_15(rows1,vars)
mean_nogo_15= mean(block_15_nogo.duration,1)
clear rows0 rows1

%block 16
rows0=find(data.block_nr2==16)
block_16= data(rows0,vars)
rows1=find(contains(block_16.trial_type,'nogo'))
block_16_nogo=block_16(rows1,vars)
mean_nogo_16= mean(block_16_nogo.duration,1)
clear rows0 rows1

% block 17
rows0=find(data.block_nr2==17)
block_17= data(rows0,vars)
rows1=find(contains(block_17.trial_type,'nogo'))
block_17_nogo=block_17(rows1,vars)
mean_nogo_17= mean(block_17_nogo.duration,1)
clear rows0 rows1

% block 18
rows0=find(data.block_nr2==18)
block_18= data(rows0,vars)
rows1=find(contains(block_18.trial_type,'nogo'))
block_18_nogo=block_18(rows1,vars)
mean_nogo_18= mean(block_18_nogo.duration,1)
clear rows0 rows1

% block 19
rows0=find(data.block_nr2==19)
block_19= data(rows0,vars)
rows1=find(contains(block_19.trial_type,'nogo'))
block_19_nogo=block_19(rows1,vars)
mean_nogo_19= mean(block_19_nogo.duration,1)
clear rows0 rows1

% block 20
rows0=find(data.block_nr2==20)
block_20= data(rows0,vars)
rows1=find(contains(block_20.trial_type,'nogo'))
block_20_nogo=block_20(rows1,vars)
mean_nogo_20= mean(block_20_nogo.duration,1)
clear rows0 rows1

%block 21
rows0=find(data.block_nr2==21)
block_21= data(rows0,vars)
rows1=find(contains(block_21.trial_type,'nogo'))
block_21_nogo=block_21(rows1,vars)
mean_nogo_21= mean(block_21_nogo.duration,1)
clear rows0 rows1




vars1=table(mean_nogo_1,...
            mean_nogo_2,...
            mean_nogo_3,...
            mean_nogo_4,...
            mean_nogo_5,...
            mean_nogo_6,...
            mean_nogo_7,...
            mean_nogo_8,...
            mean_nogo_9,...
            mean_nogo_10,...
            mean_nogo_11,...
            mean_nogo_12,...
            mean_nogo_13,...
            mean_nogo_14,...
            mean_nogo_15,...
            mean_nogo_16,...
            mean_nogo_17,...
            mean_nogo_18,...
            mean_nogo_19,...
            mean_nogo_20,...
            mean_nogo_21)
        
  filename=[SubName '_LS_sheep.xlsx'];
        
  writetable(vars1,filename,'Sheet',2)    

%% for loops 





