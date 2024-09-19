clear all
close all
clc
%%

load('Paper Figures\Supplementary\Multy_Vortex_Sim\SimulationPearllLength100Distance360.mat')

M=MagneticSignal;
MDerive=MagneticSignaldiff;
r=0.75;
DistanceFromSample=0.36;
tipradious=0.270/2;
mag=1;
phi_0=20.7;
TipResponse=1;
Magnetic_offset=0;
peak=[5.22 29.06];
t=[0:pi/20:2*pi];

X=X(1:end-1,1:end-1);
Y=Y(1:end-1,1:end-1);
pixsize=X(1,2)-X(1,1);

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

xc=xEx;
yc=yEx;
hold on
plot3(xc,yc,(xc./xc)*(max(MDerive(:)+1)),'o')
hold off

Kernel= MaskGen(tipradious,X,0);
%%
[coef,Err] = PearlFitTFDataDifferentiation(MDerive,X,Y,pixsize,xc,yc,phi_0,DistanceFromSample,TipResponse,sel,Kernel);

ErrDataDifferentiation=Err;
%Setting coefs from the fit
PearlLengthTFDataDifferentiation=coef(1);
if numel(coef)==3
    MatrixMultiplierTFDataDifferentiation=coef(2);
    TipResponseDataDifferentiation=MatrixMultiplierTFDataDifferentiation/Real_Space_Ocillation_Y;
    MTFDataDifferentiation=MDerive./MatrixMultiplierTFDataDifferentiation;   
    DistanceFromSampleDataDifferentiation=coef(3);
elseif numel(coef)==2
    if isempty(TipResponse)
        MatrixMultiplierTFDataDifferentiation=coef(2);
        TipResponseDataDifferentiation=MatrixMultiplierTFDataDifferentiation/Real_Space_Ocillation_Y;
        MTFDataDifferentiation=MDerive./MatrixMultiplierTFDataDifferentiation;
        DistanceFromSampleDataDifferentiation=DistanceFromSample;
    else
        DistanceFromSampleDataDifferentiation=coef(2);
    end
end
if ~isempty(TipResponse)
    TipResponseDataDifferentiation=TipResponse;
    MTFDataDifferentiation=MDerive;
end

if ~isempty(DistanceFromSample)
    DistanceFromSampleDataDifferentiation=DistanceFromSample;
end
%% cutting the image and the model by 4 lines to lose the tails

X1=X(3:end-2,3:end-2);
Y1=Y(3:end-2,3:end-2);
MTFDataDifferentiation1=MTFDataDifferentiation(3:end-2,3:end-2);

%% Plotting the data and the diviations

figure(1515)
subplot(1,5,1)
surf(X1,Y1,MTFDataDifferentiation1)% plotting data
view(2);
shading flat 
hold on


%marking the radius of exclusion on the data plot
for i=1:length(xEx)
    plot3(xEx(i)+R*cos(t),yEx(i)+R*sin(t),R*cos(t)*0+abs(max(max(MTFDataDifferentiation1)))*1.1,'k')
    plot3(xEx(i)+R2*cos(t),yEx(i)+R2*sin(t),R2*cos(t)*0+abs(max(max(MTFDataDifferentiation1)))*1.1,'k')
    
    plot3(xEx(i)+r*cos(t),yEx(i)+r*sin(t),r*cos(t)*0+abs(max(max(MTFDataDifferentiation1)))*1.1,'r')
    
    text(xEx(i),yEx(i),abs(max(max(MTFDataDifferentiation1))),num2str(i))
end

Y2=Y;
X2=X;
Y2(end+1,:)=((Y(2,1)-Y(1,1))+Y(end,1))+X(1,:)*0;
Y2(:,end+1)=Y2(:,1);
X2(:,end+1)=((X(1,2)-X(1,1))+X(1,end))+X(1,:)*0;
X2(end+1,:)=X2(1,:);

[BzDataDifferentiation,ConvBzDataDifferentiation] = pearlgen_no_mag(X2,Y2,xc,yc,PearlLengthTFDataDifferentiation,DistanceFromSampleDataDifferentiation,phi_0,Kernel);

BzDataDifferentiation_diff=diff(BzDataDifferentiation(:,1:end-1))/pixsize;
ConvBzDataDifferentiation_diff=diff(ConvBzDataDifferentiation(:,1:end-1))/pixsize;

ConvBzDataDifferentiation_diff1=ConvBzDataDifferentiation_diff(3:end-2,3:end-2);


axis square
hold off
figure(1515)
subplot(1,3,2)
surf(X1,Y1,MTFDataDifferentiation1-ConvBzDataDifferentiation_diff1)
view(2);
shading flat;
caxis([min(min(MTFDataDifferentiation1)) max(max(MTFDataDifferentiation1))])
axis square

hold off


fig=figure(1515);
subplot(1,3,3)
surf(X1,Y1,ConvBzDataDifferentiation_diff1)
view(2);
shading flat;

caxis([min(min(MTFDataDifferentiation1)) max(max(MTFDataDifferentiation1))])
axis square
hold off

fig.WindowState = 'maximized';

axis square
hold off

sgtitle(['Pearl Length Fit Data Diff = ',num2str(PearlLengthTFDataDifferentiation),' Dist = ',num2str(DistanceFromSampleDataDifferentiation)...
    ,' Tip Response = ',num2str(TipResponseDataDifferentiation)])


figure(555)
subplot(6,6,[1 3 13 15])
surf(X1,Y1,MTFDataDifferentiation1)
shading interp
title('Data')
axis equal
subplot(6,6,[4 6 16 18])
surf(X1,Y1,ConvBzDataDifferentiation_diff1)
shading interp
title('Model diffrentiated with image diff')
caxis([min(MTFDataDifferentiation1(:)),max(MTFDataDifferentiation1(:))])
axis equal
subplot(6,6,[19 21 31 33])
surf(X1,Y1,MTFDataDifferentiation1-ConvBzDataDifferentiation_diff1)
shading interp
title('Residuals')
axis equal
caxis([min(MTFDataDifferentiation1(:)),max(MTFDataDifferentiation1(:))])

subplot(6,6,[22 24])
title('Cross-Section image diff fit')
[~,bb]=find(X1==xc,1);
plot(X1(1,:),MTFDataDifferentiation1(:,bb))
xlabel('y [\mum]')
ylabel('B [G]')
grid on
axis([X1(1,1) X1(1,end) min(MTFDataDifferentiation1(:)),max(MTFDataDifferentiation1(:))+(max(MTFDataDifferentiation1(:))/10)])
hold on
plot(X1(1,:),ConvBzDataDifferentiation_diff1(:,bb))
hold off
legend('Data','Model image diff')
subplot(6,6,[34 36])
title('Cross-Section image diff fit')
[aa,~]=find(Y1==yc,1);
plot(Y1(:,1),MTFDataDifferentiation1(aa,:))
xlabel('x [\mum]')
ylabel('B [G]')
grid on
axis([Y1(1,1) Y1(end,1) min(MTFDataDifferentiation1(:)),max(MTFDataDifferentiation1(:))+(max(MTFDataDifferentiation1(:))/10)])
hold on
plot(Y1(:,1),ConvBzDataDifferentiation_diff1(aa,:))
legend('Data','Model image diff')
hold off

sgtitle(['Pearl Length Fit Data Diff = ',num2str(PearlLengthTFDataDifferentiation)])

%%
X_MultyVortexSim4=X1;
Y_MultyVortexSim4=X1;
M_MultyVortexSim4=MTFDataDifferentiation1;
M_MultyVortexSimFit4=ConvBzDataDifferentiation_diff1;
PearlLengthMultyVortexSimFit4=round(PearlLengthTFDataDifferentiation);

%save(['Paper Figures\Supplementary\Multy_Vortex_Sim\MultyVortexSimFit4.mat'],'X_MultyVortexSim4','Y_MultyVortexSim4','M_MultyVortexSim4','M_MultyVortexSimFit4','PearlLengthMultyVortexSimFit4')
