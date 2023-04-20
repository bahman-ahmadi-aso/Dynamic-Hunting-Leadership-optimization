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

function position=checkB(llb,uub,dim,position)
lb=repmat(llb,1,dim);
ub=repmat(uub,1,dim);
for jdim=1:dim
            while position(1,jdim)>ub(1,jdim) || position(1,jdim)<lb(1,jdim)
        
                 if position(1,jdim)>ub(1,jdim)
                    b=abs(position(1,jdim)-ub(1,jdim));
                    position(1,jdim)=ub(1,jdim)-b;
                 end
                 if position(1,jdim)<lb(1,jdim)
                    b=abs(lb(1,jdim)-position(1,jdim));
                    position(1,jdim)=lb(1,jdim)+b;
                 end

             end
    %
end
end