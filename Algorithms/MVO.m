%
function [Best_universe_Inflation_rate,Best_universe,Convergence_curve]=MVO(N,Max_time,lb,ub,dim,fobj)

%Two variables for saving the position and inflation rate (fitness) of the best universe
Best_universe=zeros(1,dim);
Best_universe_Inflation_rate=inf;

%Initialize the positions of universes
Universes=initialization(N,dim,ub,lb);

%Minimum and maximum of Wormhole Existence Probability (min and max in
% Eq.(3.3) in the paper
WEP_Max=1;
WEP_Min=0.2;

Convergence_curve=zeros(1,Max_time);

%Iteration(time) counter
Time=1;

%Main loop
while Time<Max_time+1
    
    %Eq. (3.3) in the paper
    WEP=WEP_Min+Time*((WEP_Max-WEP_Min)/Max_time);
    
    %Travelling Distance Rate (Formula): Eq. (3.4) in the paper
    TDR=1-((Time)^(1/6)/(Max_time)^(1/6));
    
    %Inflation rates (I) (fitness values)
    Inflation_rates=zeros(1,size(Universes,1));
    
    for i=1:size(Universes,1)
        
        %Boundary checking (to bring back the universes inside search
        % space if they go beyoud the boundaries
        Flag4ub=Universes(i,:)>ub;
        Flag4lb=Universes(i,:)<lb;
        Universes(i,:)=(Universes(i,:).*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;
        
        %Calculate the inflation rate (fitness) of universes
        Inflation_rates(1,i)=fobj(Universes(i,:));
        
        %Elitism
        if Inflation_rates(1,i)<Best_universe_Inflation_rate
            Best_universe_Inflation_rate=Inflation_rates(1,i);
            Best_universe=Universes(i,:);
        end
        
    end
    
    [sorted_Inflation_rates,sorted_indexes]=sort(Inflation_rates);
    
    for newindex=1:N
        Sorted_universes(newindex,:)=Universes(sorted_indexes(newindex),:);
    end
    
    %Normaized inflation rates (NI in Eq. (3.1) in the paper)
    normalized_sorted_Inflation_rates=normr(sorted_Inflation_rates);
    
    Universes(1,:)= Sorted_universes(1,:);
    
    %Update the Position of universes
    for i=2:size(Universes,1)%Starting from 2 since the firt one is the elite
        Back_hole_index=i;
        for j=1:size(Universes,2)
            r1=rand();
            if r1<normalized_sorted_Inflation_rates(i)
                White_hole_index=RouletteWheelSelection(-sorted_Inflation_rates);% for maximization problem -sorted_Inflation_rates should be written as sorted_Inflation_rates
                if White_hole_index==-1
                    White_hole_index=1;
                end
                %Eq. (3.1) in the paper
                Universes(Back_hole_index,j)=Sorted_universes(White_hole_index,j);
            end
            
            if (size(lb,2)==1)
                %Eq. (3.2) in the paper if the boundaries are all the same
                r2=rand();
                if r2<WEP
                    r3=rand();
                    if r3<0.5
                        Universes(i,j)=Best_universe(1,j)+TDR*((ub-lb)*rand+lb);
                    end
                    if r3>0.5
                        Universes(i,j)=Best_universe(1,j)-TDR*((ub-lb)*rand+lb);
                    end
                end
            end
            
            if (size(lb,2)~=1)
                %Eq. (3.2) in the paper if the upper and lower bounds are
                %different for each variables
                r2=rand();
                if r2<WEP
                    r3=rand();
                    if r3<0.5
                        Universes(i,j)=Best_universe(1,j)+TDR*((ub(j)-lb(j))*rand+lb(j));
                    end
                    if r3>0.5
                        Universes(i,j)=Best_universe(1,j)-TDR*((ub(j)-lb(j))*rand+lb(j));
                    end
                end
            end
            
        end
    end
    
    %Update the convergence curve
    Convergence_curve(Time)=Best_universe_Inflation_rate;
    
    %Print the best universe details after every 50 iterations
%     if mod(Time,50)==0
%         display(['At iteration ', num2str(Time), ' the best universes fitness is ', num2str(Best_universe_Inflation_rate)]);
%     end
    Time=Time+1;
end
end


function choice = RouletteWheelSelection(weights)
  accumulation = cumsum(weights);
  p = rand() * accumulation(end);
  chosen_index = -1;
  for index = 1 : length(accumulation)
    if (accumulation(index) > p)
      chosen_index = index;
      break;
    end
  end
  choice = chosen_index;
end




