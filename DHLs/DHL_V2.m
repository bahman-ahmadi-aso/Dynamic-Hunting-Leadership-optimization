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

function [BF,BS,Convergence_curve,n_L_hist]=DHL_V2(N,Max_iter,lb,ub,dim,fobj,NL)

% initialize ledears
L_pos=initialization(NL,dim,ub,lb);
L_fit=inf*ones(NL,1);

%Initialize the positions of search agents
SA=initialization(N,dim,ub,lb);


Convergence_curve=[];
n_L_hist=[];

% Main loop
for l=1:Max_iter
    for i=1:size(SA,1)

        % Return back the search agents that go beyond the boundaries of the search space
        SA(i,:)=checkB(lb,ub,dim,SA(i,:));
        %Flag4ub=SA(i,:)>ub;
        %Flag4lb=SA(i,:)<lb;
        %SA(i,:)=(SA(i,:).*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;
        
        % Calculate objective function for each search agent
        fitness=fobj(SA(i,:));

        for i_b=1:NL
            if fitness<L_fit(i_b,1)
                L_fit(i_b,1)=fitness; % Update i_b^th best fit
                L_pos(i_b,:)=SA(i,:);
                break
            end
        end

    end

    %% Evaluation
    a=2-l*((2)/Max_iter); % a decreases linearly fron 2 to 0

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%determining the numbers of leaders based on number of iteration%%%

    AA=1-l/(Max_iter);       %for iter 1:max/2 linear from 1 to 0
    
    n_L=1+round(AA*(NL-1));
    n_L_hist=[n_L_hist n_L];



    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Update the Position of search agents including omegas
    for i=1:N
        for j=1:dim
            for i_x=1:n_L
                r1=rand(); % r1 is a random number in [0,1]
                r2=rand(); % r2 is a random number in [0,1]

                A1=2*a*r1-a; 
                C1=2*r2; 

                D_alpha=abs(C1*L_pos(i_x,j)-SA(i,j)); 
                XX(i_x,1)=L_pos(i_x,j)-A1*D_alpha; 
            end

            SA(i,j)=mean(XX);
            clear XX
        end
    end
    Convergence_curve=[Convergence_curve L_fit(1,1)];
end
BF=L_fit(1,1);
BS=L_pos(1,:);
end



