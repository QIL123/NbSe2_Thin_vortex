function [coefs, Error, xc ,yc]=PearlCenterLocationandFit(Data,X,Y,pixsize,xEx1,yEx1,phi_0,DistanceFromSample,TipResponse,sel,Kernel,RadiusOfCheck)
xEx=(xEx1-pixsize*RadiusOfCheck):pixsize:(xEx1+pixsize*RadiusOfCheck);
yEx=(yEx1+pixsize*RadiusOfCheck):(-pixsize):(yEx1-pixsize*RadiusOfCheck);

for i=1:length(xEx)
    for j=1:length(yEx)
        [coef,Err] = PearlFitTFDataDifferentiation(Data,X,Y,pixsize,xEx(i),yEx(j),phi_0,DistanceFromSample,TipResponse,sel,Kernel);
        coefstemp{j,i}=coef;
        Errortemp(j,i)=Err;
    end
end
if size(Errortemp,1)==size(Errortemp,2) & size(Errortemp,1)>1
    surf(Errortemp)
end
[a,b]=find(Errortemp==min(min(Errortemp)));
coefs=coefstemp{a,b};
Error=Errortemp(a,b);
xc=xEx(b);
yc=yEx(a);

end
