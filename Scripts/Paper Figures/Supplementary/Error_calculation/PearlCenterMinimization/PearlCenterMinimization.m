clear all
close all
clc
%%

load('Paper Figures\Supplementary\Multy_Vortex_Sim\SimulationPearllLength100Distance360.mat')

M=MagneticSignal;
MDerive=MagneticSignaldiff;
r=0.5;
DistanceFromSample=0.36;
tipradious=0.270/2;
mag=1;
phi_0=20.7;
TipResponse=1;
Magnetic_offset=0;
peak=[5.164 29.06];
t=[0:pi/20:2*pi];

X=X(1:end-1,1:end-1);
Y=Y(1:end-1,1:end-1);
pixsize=X(1,2)-X(1,1);
RadiusOfCheck=0;

%%
if isempty(peak)
    figure;surf(X,Y,MDerive)
    m=mean(MDerive(:));
    s=std(MDerive(:));
    caxis([m-s m+s])
    caxis
    view(2);shading flat;
    [xx,yy] = ginput(1);
else
    xx=peak(1);
    yy=peak(2);
end
[~,xcut]=min(abs(X(1,:)-xx));
[~,ycut]=min(abs(Y(:,1)-yy));
D=350;
er=1
while er & D>0
try
M=M(ycut-D:ycut+D,xcut-D:xcut+D);
X=X(ycut-D:ycut+D,xcut-D:xcut+D);
Y=Y(ycut-D:ycut+D,xcut-D:xcut+D);
MDerive=MDerive(ycut-D:ycut+D,xcut-D:xcut+D);
er=0
catch
    D=D-1;
end
end

if isempty(peak)
    figure;surf(X,Y,MDerive)
    view(2);shading flat;
    axis square
    [xx,yy] = ginput(1);
end
[~,ix]=min(abs(X(1,:)-xx));
xEx=X(1,ix);
[~,iy]=min(abs(Y(:,1)-yy));
yEx=Y(iy,1);

%Exclusion area
R=r+0.005; %[um]
R2=r-0.05; %[um]
sel=X*0;

for i=1:length(xEx)
    sel=sel+((xEx(i)-X).^2+(yEx(i)-Y).^2<R^2);
end
% substract plane

back=fit([X(sel==0),Y(sel==0)],MDerive(sel==0),'poly11');
MDerive=MDerive-back(X,Y);

figure;surf(X,Y,MDerive)
view(2);shading flat;
axis image


hold on
plot3(xEx,yEx,(xEx./yEx)*(max(MDerive(:)+1)),'o')
hold off
Kernel= MaskGen(tipradious,X,0);
%%
[coefs, Error, xc ,yc]=PearlCenterLocationandFit(MDerive,X,Y,pixsize,xEx,yEx,phi_0,DistanceFromSample,TipResponse,sel,Kernel,RadiusOfCheck);

PearlLengthTFDataDifferentiation=coefs(1);
if numel(coefs)==3
    MatrixMultiplierTFDataDifferentiation=coefs(2);
    TipResponseDataDifferentiation=MatrixMultiplierTFDataDifferentiation/Real_Space_Ocillation_Y;
    MTFDataDifferentiation=MDerive./MatrixMultiplierTFDataDifferentiation;   
    DistanceFromSampleDataDifferentiation=coefs(3);
elseif numel(coefs)==2
    if isempty(TipResponse)
        MatrixMultiplierTFDataDifferentiation=coefs(2);
        TipResponseDataDifferentiation=MatrixMultiplierTFDataDifferentiation/Real_Space_Ocillation_Y;
        MTFDataDifferentiation=MDerive./MatrixMultiplierTFDataDifferentiation;
        DistanceFromSampleDataDifferentiation=DistanceFromSample;
    else
        DistanceFromSampleDataDifferentiation=coefs(2);
    end
end
if ~isempty(TipResponse)
    TipResponseDataDifferentiation=TipResponse;
    MTFDataDifferentiation=MDerive;
end

if ~isempty(DistanceFromSample)
    DistanceFromSampleDataDifferentiation=DistanceFromSample;
end




