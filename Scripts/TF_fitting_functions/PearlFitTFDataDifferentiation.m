function [coef,Err] = PearlFitTFDataDifferentiation(Data,X,Y,pixsize,xc,yc,phi_0,DistanceFromSample,TipResponse,sel,Kernel)

if isempty(sel)
    sel=ones(size(Data));
end
if isempty(TipResponse)
    if isempty(DistanceFromSample)
        [coef,Err]=fminsearch(@(coefs) pearl_min_functionACTipResponseDataDifferentiation(Data,X,Y,pixsize,xc,yc,coefs,phi_0,sel,Kernel,DistanceFromSample),[0;0;0]);
    else
        [coef,Err]=fminsearch(@(coefs) pearl_min_functionACTipResponseDataDifferentiation(Data,X,Y,pixsize,xc,yc,coefs,phi_0,sel,Kernel,DistanceFromSample),[0,0]);
    end
elseif isempty(DistanceFromSample)
    [coef,Err]=fminsearch(@(coefs) pearl_min_functionACDistanceFromSampleDataDifferentiation(Data,X,Y,pixsize,xc,yc,coefs,phi_0,sel,Kernel,DistanceFromSample),[0,0]);
else
    [coef,Err]=fminsearch(@(coefs) pearl_min_functionACDistanceFromSampleDataDifferentiation(Data,X,Y,pixsize,xc,yc,coefs,phi_0,sel,Kernel,DistanceFromSample),[0]);
end

end

