function [Min,Mout,phase]=phase_rotation_func(Mx,My)

%fixing the phase by minimizing: -ACX*sin(phase)+ACY*cos(phase);

% (-ACX*sin(phase)+ACY*cos(phase))*(-ACX*cos(phase)-ACY*sin(phase))=0
% (ACX.*ACY)*cos(2*phase)=0.5*(ACX^2-ACY^2)*sin(2*phase)

    theta_vect=linspace(-pi/2,pi/2,500);

    n=numel(Mx);

    avgX=sum(Mx(:))/n;
    avgY=sum(My(:))/n;
    avgX2=sum(Mx(:).^2)/n;
    avgY2=sum(My(:).^2)/n;
    avgXY=sum(Mx(:).*My(:))/n;

    varYrot=(avgX2-avgX^2)*sin(theta_vect).^2+(avgY2-avgY^2)*cos(theta_vect).^2-2*(avgXY-avgX*avgY)*cos(theta_vect).*sin(theta_vect);
    [minvar,i]=min(varYrot);
    phase=theta_vect(i);

    Min=Mx*cos(phase)+My*sin(phase);
    Mout=-Mx*sin(phase)+My*cos(phase);
end
