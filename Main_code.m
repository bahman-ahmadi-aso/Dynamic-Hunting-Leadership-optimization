%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Dynamic hunting leadership source codes version 1.0              %
%  Developed in MATLAB R2022b                                       %
%                                                                   %
%  Author and programmer: Bahman Ahmadi                             %
%                                                                   %
%         e-Mail: b.ahmadi@ieee.org                                 %
%                 b.ahmadi@utwente.nl                               %
%                                                                   %
%       Homepage: https://orcid.org/0000-0002-1745-2228             %
%                                                                   %
%                                                                   %
%___________________________________________________________________%

close all;clear all;clc
%%%%%%%%%%%%%%%%%%%%%%%%


Algs={'DHL_V4','DHL_V1','DHL_V2','DHL_V3','GWO','PSO','MVO'};
run_N=1; % number of individual runs for each algorithm
N=30; % Number of search agents

name='F1_F13_30dim';%{'F1_F13_30dim','F14_F23','F1_F13_60dim','F1_F13_200dim','F14_F23','CECfuncs'};

switch name
    case 'CECfuncs'
        Max_iteration=50000;
        TFn=1:10;
    case 'F1_F13_30dim'
        dim=30;
        Max_iteration=200;
        TFn=1;%:13;
    case 'F1_F13_200dim'
        dim=200;
        Max_iteration=600;
        TFn=1:13;
    case 'F14_F23'
        Max_iteration=200;
        TFn=14:23;
    case 'F1_F13_60dim'
        dim=60;
        Max_iteration=400;
        TFn=1:13;
end

addpath(fullfile(pwd, 'Algorithms'),fullfile(pwd, 'DHLs'))
jTest_f=TFn;
switch name
    case 'CECfuncs'
        Function_name=['cec0' num2str(jTest_f)];
        [lb,ub,dim,fobj]=Select_Functions(Function_name);
    case 'F1_F13_30dim'
        Function_name=['F' num2str(jTest_f)];
        [lb,ub,base_dim,fobj]=Select_Functions(Function_name);
    case 'F1_F13_200dim'
        Function_name=['F' num2str(jTest_f)];
        [lb,ub,base_dim,fobj]=Select_Functions(Function_name);
    case 'F14_F23'
        Function_name=['F' num2str(jTest_f)];
        [lb,ub,base_dim,fobj]=Select_Functions(Function_name);
        if jTest_f>13
            dim=base_dim;
        end
    case 'F1_F13_60dim'
        Function_name=['F' num2str(jTest_f)];
        [lb,ub,base_dim,fobj]=Select_Functions(Function_name);
        if jTest_f>13
            dim=base_dim;
        end
end


for i_alg=1:max(size(Algs))

    out_put(i_alg,1).alg=Algs{1,i_alg};
    out_put(i_alg,1).alg_n=i_alg;
    out_put(i_alg,1).Function_name=Function_name;

    out_put(i_alg,1).Fn_i=jTest_f;

    out_put(i_alg,1).N=N;
    out_put(i_alg,1).Max_iteration=Max_iteration;
    out_put(i_alg,1).lb=lb;
    out_put(i_alg,1).ub=ub;
    out_put(i_alg,1).dim=dim;
    out_put(i_alg,1).fobj=fobj;
    out_put(i_alg,1).n_run=run_N;

    for i_run=1:run_N
        %% Results
        Out=OptimizationAlgorithms(out_put(i_alg,1));

        out_put(i_alg,1).Fit(i_run,1)=Out.Fit;
        out_put(i_alg,1).pos(i_run,:)=Out.pos;
        out_put(i_alg,1).CC(i_run,:)=Out.CC;
        out_put(i_alg,1).simTime(i_run,1)=Out.simTime;
        out_put(i_alg,1).nLcurve(i_run).nL=Out.nLcurve;
        if i_run==1
            CC=out_put(i_alg,1).CC(i_run,:);
            hold on
            semilogy(CC,LineWidth=2)
            title('Objective space')
            xlabel('Iteration');
            ylabel('Best score obtained so far');
        end

    end
    out_put(i_alg,1).meanFit=mean(out_put(i_alg,1).Fit(i_run,1));
    out_put(i_alg,1).mean_simTime=mean(out_put(i_alg,1).simTime(i_run,1));

end

legend(Algs)

