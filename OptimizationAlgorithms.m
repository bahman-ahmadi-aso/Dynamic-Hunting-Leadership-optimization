function Out=OptimizationAlgorithms(para)
Algs=para.alg;
SearchAgents_no=para.N;
Max_iteration=para.Max_iteration;
if max(size(para.lb))==1
    lb=ones(1,para.dim)*para.lb;
    ub=ones(1,para.dim)*para.ub;
else
    lb=para.lb;
    ub=para.ub;
end
dim=para.dim;
fobj=para.fobj;


tic
Out.nLcurve=[];
switch Algs
    case 'GWO'
        [Out.Fit,Out.pos,Out.CC]=GWO(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);
    case 'DHL_V1'
        [Out.Fit,Out.pos,Out.CC,Out.nLcurve]=DHL_V1(SearchAgents_no,Max_iteration,lb,ub,dim,fobj,SearchAgents_no);
    case 'DHL_V2'
        [Out.Fit,Out.pos,Out.CC,Out.nLcurve]=DHL_V2(SearchAgents_no,Max_iteration,lb,ub,dim,fobj,SearchAgents_no);
    case 'DHL_V3'
        [Out.Fit,Out.pos,Out.CC,Out.nLcurve]=DHL_V3(SearchAgents_no,Max_iteration,lb,ub,dim,fobj,SearchAgents_no);
    
    case 'DHL_V4'
        TOL=5; %it is in % and compare the leader fit to TOL% of iteration befor based on the paper
        [Out.Fit,Out.pos,Out.CC,Out.nLcurve]=DHL_V4(SearchAgents_no,Max_iteration,lb,ub,dim,fobj,SearchAgents_no,TOL);

    case 'PSO'
        [Out.Fit,Out.pos,Out.CC]=PSO(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);
    case 'MVO'
        [Out.Fit,Out.pos,Out.CC]=MVO(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);

end
Out.simTime=toc;


end