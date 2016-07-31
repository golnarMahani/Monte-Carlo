clear all;
clc;

%% policy Evaluation, MC FirstVisit
rnd_p_s_a=ones(6,2).*(1/2);
disp('MC_FV_PE: value function for random walk policy');
[Rndvaluefunction]=MC_FV_PE(rnd_p_s_a,0.5); 

% Q approximation, MC FirstVisit
rnd_p_s_a=ones(6,2).*(1/2);
disp('MC_Q_FV:');
[QSA]=MC_Q_FV(rnd_p_s_a,0.5); 

%% Policy Improvement MC First visit Exploring start 
rnd_p_s_a=ones(6,2).*(1/2);
disp('MC_ES_FV_PI:');
[NewPolicy]=MC_ES_FV_PI(rnd_p_s_a,0.5); 

%% Policy Improvement MC First visit On Policy
rnd_p_s_a=ones(6,2).*(1/2);
disp('MC_onpolicy_FV_PI:');
[NewPolicy_onpolicy]=MC_onpolicy_FV_PI(rnd_p_s_a,0.5,0.001); 

