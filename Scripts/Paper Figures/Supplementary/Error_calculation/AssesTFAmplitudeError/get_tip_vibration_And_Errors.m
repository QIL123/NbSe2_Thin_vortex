function [TFAmplitude,TFAmplitudeLowerBound,TFAmplitudeUpperBound,Min,dDCdy]=get_tip_vibration_And_Errors(MDC,MTFx,MTFy,x,y)
%given DC and Tunning fork data this function will give the
%real space oscillation of the tunning fork in x and in y, it will also
%give the tunning fork data roatated to one channel and the phase rotation


%transfer the tunning fork data into one channel the Min is that channel
%and the phase in the rotation needed to through all the data into that
%channel
Mx=MTFx;
My=MTFy;

[Min,~,~]=phase_rotation_func(Mx,My);
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

DCDerive=dDCdy(:);
MTF=Min(:);

figure(6483)

plot(DCDerive,MTF,'.')
try
    TFAmpliteFit=fit(DCDerive,MTF,'poly1');
    hold on
    plot(TFAmpliteFit)
    hold off
    TFAmplitude=TFAmpliteFit.p1;
    confidencecoess=confint(TFAmpliteFit);
    TFAmplitudeLowerBound=confidencecoess(1);
    TFAmplitudeUpperBound=confidencecoess(2);
catch
    TFAmplitudeLowerBound=[];
    TFAmplitudeUpperBound=[];
    TFAmplitude=[];
end
% PlotTFFitData={DCDerive MTF};
% Path='C:\\Users\\Owner\\Desktop\\NbSe2\\codes\\Paper Figures\\Supplementary\\Error_calculation\\Error Plot\\PlotTFFitData';
% save(Path,'PlotTFFitData')
end