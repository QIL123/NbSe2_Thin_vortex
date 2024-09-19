function [Min,TFAmplitude,UncertaintyAmplitudebelow,UncertaintyAmplitudeabove]=AssesTFAmplitudeError(MDC,MTFy,MTFx,x,y)

Mx=MTFx;
My=MTFy;

[Min,Mout,phase]=phase_rotation_func(Mx,My);
xvect=x.*1e-6;
yvect=y.*1e-6;
NX=length(xvect);
NY=length(yvect);
DC=MDC;
dDCdx=zeros(size(DC));
dDCdy=zeros(size(DC));

warning('off','MATLAB:polyfit:RepeatedPointsOrRescale');
K=5;
for j=1:NY
    j1=max([1,j-K]);
    j2=min([NY,j+K]);

    for i=1:NX
        i1=max([1,i-K]);
        i2=min([NX,i+K]);
% a*sumx+b*n=sumDC
% a*sumx2+b*sumx=sumxDC
        n=i2-i1+1; 
        sumx=sum(xvect(i1:i2)); 
        sumx2=sum(xvect(i1:i2).^2); 
        sumDC=sum(DC(j,i1:i2)); 
        sumxDC=sum(xvect(i1:i2).*DC(j,i1:i2));
        dDCdx(j,i)=1/(n*sumx2-sumx^2)*(n*sumxDC-sumx*sumDC);

        n=j2-j1+1; 
        sumy=sum(yvect(j1:j2)); 
        sumy2=sum(yvect(j1:j2).^2); 
        sumDC=sum(DC(j1:j2,i)); 
        sumyDC=sum(yvect(j1:j2).*DC(j1:j2,i)');
        dDCdy(j,i)=1/(n*sumy2-sumy^2)*(n*sumyDC-sumy*sumDC);
    end
end
warning('on','MATLAB:polyfit:RepeatedPointsOrRescale');

N=NX*NY;
x=reshape(dDCdx,1,N);
y=reshape(dDCdy,1,N);
z=reshape(Min,1,N);

sumx=sum(x)/N;
sumy=sum(y)/N;
sumz=sum(z)/N;
sumx2=sum(x.^2)/N;
sumy2=sum(y.^2)/N;
sumxy=sum(x.*y)/N;
sumxz=sum(x.*z)/N;
sumyz=sum(y.*z)/N;

M=[sumx2,sumxy,sumx;sumxy,sumy2,sumy;sumx,sumy,1]; R=[sumxz;sumyz;sumz];
v=M\R;
dx=v(1); dy=v(2); C=v(3);
dycheck=(dy-dy):0.1*dy:(dy+dy);

for i=1:length(dycheck)
    DCDerivativeFittemp=1e3*flip((dDCdx*dx+dDCdy*dycheck(i)+C),1);
    Residualstemporary{i}=(1e3*flip(Min,1)-DCDerivativeFittemp)./Min;
    Residualstemporary2=Residualstemporary{i};
    errors(i)=sum(sum(Residualstemporary2.^2));
end

for j=1:length(errors)
    if 2*min(errors)>=errors(j)
        relevntval(j)=find(errors==errors(j))
    end
end
UncertaintyAmplitudebelow=dycheck(relevntval(1));
UncertaintyAmplitudeabove=dycheck(relevntval(end));
TFAmplitude=dycheck(find(errors==min(errors)));

% Residuals=Residualstemporary{find(errors==min(errors))};

% figure(i);
% tiledlayout('flow','Padding', 'none', 'TileSpacing', 'compact');
% set(gcf, 'Position', [2811 654 1102 878],'Color','w')
% 
% nexttile;
% DCDerivativeFit=1e3*flip((dDCdx*dx+dDCdy*dy+C),1);
% surf(DCDerivativeFit)
% view(2)
% shading flat
% 
% nexttile;
% MTF=flip(Min,1)*1e3;
% surf(MTF)
% view(2)
% shading flat
% 
% nexttile;
% Residuals=MTF-DCDerivativeFit;
% surf(Residuals)
% view(2)
% shading flat

end