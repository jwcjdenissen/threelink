%% Initialize threelink model
% The ros connection is shutted down intially and then 
% started again

rosshutdown
clear all
close all
clc
rosinit

threelink(1).joint = 'joint_1';
threelink(1).control_input_topic = '/threelink/joint_1_effort_controller/command';
threelink(1).state_topic = '/threelink/joint_states';

threelink(2).joint = 'joint_2';
threelink(2).control_input_topic = '/threelink/joint_2_position_controller/command';

%% Set solver settings and save them to mat file

solversettings.t_start = 0.0;
solversettings.t_stop = 2.0;
solversettings.t_sample = 0.0005;
solversettings.rel_tol = 1e-7;
solversettings.abs_tol = 1e-7;

save('solversettings.mat','solversettings')

%%

load('solversettings.mat')
open('threelink_simulink_analysis')
sim('threelink_simulink_analysis')

%% Generate data
u=input.Data;
y=output.Data;

system=iddata(y,u,Ts);
system_normalized=detrend(system);

w = linspace(0.001,1000,2048);
sys_np=spa(system,[],w);

bode(sys_np)