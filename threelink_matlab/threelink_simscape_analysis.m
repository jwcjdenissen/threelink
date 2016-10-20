%% Initialize threelink simscape model
% Close all windows and clean workspace
clear all
close all
clc
% Open simulink file
open('threelink_simscape_analysis.slx')

%% Settings of simulink model

solver_params.t_start = 0.0;
solver_params.t_stop = 1.0;
solver_params.rel_tol = 1e-7;
solver_params.abs_tol = 1e-7;
solver_params.t_sample = 1e-4;

% solver_params.t_step_max = 1e-3 ;
% solver_params.t_step_min = 1e-5 ;
% solver_params.t_step_init = 1e-4 ;

model_params.m = 9.375;
model_params.w = 0.05;
model_params.l = 0.5;

model_params.I = [  model_params.m*(model_params.w^2+model_params.l^2)/12 0 0; 
                    0 model_params.m*(model_params.w^2+model_params.l^2)/12 0; 
                    0 0 model_params.m*(2*model_params.w^2)/12];
                
save('global_params.mat','solver_params','model_params')

%% Run simulink model

load('global_params.mat')
sim('threelink_simscape_analysis.slx')

%%

ID2(threeLink,[simout.Data(10,1) simout.Data(10,10)],[simout.Data(10,2) simout.Data(10,11)],[simout.Data(10,3) simout.Data(10,12)])