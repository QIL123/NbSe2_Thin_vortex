function [coefs, Error, xc ,yc, DistanceFromSample, PearlDiviationCenter, PearlDiviationDistancefromSample, DistanceFromSampleoptions]=PearlCenterLocationandFit(Data,X,Y,pixsize,xEx1,yEx1,phi_0,DistanceFromSample,TipResponse,sel,Kernel,RadiusOfCheck)
DistanceFromSampleoptions=DistanceFromSample-0.06:0.002:DistanceFromSample+0.06;
xEx=(xEx1-pixsize*RadiusOfCheck):pixsize:(xEx1+pixsize*RadiusOfCheck);
yEx=(yEx1+pixsize*RadiusOfCheck):(-pixsize):(yEx1-pixsize*RadiusOfCheck);

for i=1:length(xEx)
    for j=1:length(yEx)
        [coef,Err] = PearlFitTFDataDifferentiation(Data,X,Y,pixsize,xEx(i),yEx(j),phi_0,DistanceFromSample,TipResponse,sel,Kernel);
        coefstemp(j,i)=coef;
        Errortemp(j,i)=Err;
    end
end
if size(Errortemp,1)>1
    figure
    surf(Errortemp)
end

[a,b]=find(Errortemp==min(min(Errortemp)));
coefs=coefstemp(a,b);
%Error=Errortemp(a,b);
xc=xEx(b);
yc=yEx(a);
PearlDiviationCenter=coefstemp(find(Errortemp<2*min(min(Errortemp))&Errortemp~=min(min(Errortemp))))/coefstemp(a,b);

% PlotVortexCentersChi={xEx yEx Errortemp coefstemp};
% Path='C:\\Users\\Owner\\Desktop\\NbSe2\\codes\\Paper Figures\\Supplementary\\Error_calculation\\Error Plot\\PlotVortexCentersChi';
% save(Path,'PlotVortexCentersChi')

Errortemp=[];
coefstemp=[];
for j=1:length(DistanceFromSampleoptions)
    [coef,Err] = PearlFitTFDataDifferentiation(Data,X,Y,pixsize,xc,yc,phi_0,DistanceFromSampleoptions(j),TipResponse,sel,Kernel);
    coefstemp(j)=coef;
    Errortemp(j)=Err;
end
coefs=coefstemp(find(Errortemp==min(Errortemp)));
Error=Errortemp(find(Errortemp==min(Errortemp)));
DistanceFromSample=DistanceFromSampleoptions(find(Errortemp==min(Errortemp)));
%PearlDiviationDistancefromSample=coefstemp(find(Errortemp<2*min(min(Errortemp))&Errortemp~=min(min(Errortemp))))/coefstemp(find(Errortemp==min(Errortemp)));
DistanceFromSampleoptions=[DistanceFromSampleoptions-0.02 DistanceFromSample+0.02];
try
    PearlDiviationDistancefromSample=[coefstemp(find(Errortemp==min(Errortemp))-1) coefstemp(find(Errortemp==min(Errortemp))+1)];
catch
    PearlDiviationDistancefromSample=[];
end
end