clear
close all
clc
%%
%this function is going to fit TF vortex databy Pearl Model and give the
%Pearl length and other parameters per users choise, Tip Response,
%Distansce from Sample ane The Real sapce oscillation amplitude.

TipResponse=1.84e-3;% 5 layer sample 

WantedDistanceFromSample=0.36;
DistanceFromSample=0.26;  %distance from sample in um
TF_Amplitude=[0.149]; % in um
Use_TF_Oscillation_fit_amplitude=0;  %controling whether we fit baced on get tip vibration or fit the ocillation as well 1 means using the fit 0 fitting baced on vortex

peak=[2.52 2.68];

LayerN=6;
thick=LayerN*(0.627)*1e-3; 
r=1; %radios of exlotion in the image
DC_channel=2;%1 for forward 2 for backward
TF_x_channel=8; 
TF_y_channel=10;
LIA_sensitivity=5e-4; %in Volts
DialationFactor=1;% our estimated strech in XY scanners when compared to optical or AFM data
phi_0=20.7;% units gauss*um 
tipradious=0.270/2; %in um
t=[0:pi/20:2*pi]; %created to plot the radius of exclusion on the plots
err_thick=0.001;

%% 
% choosing and uploading image

Year='2023';
Day='15';
mounth='May';
NameStart='NbS00882';

nums=["040"]; %list of images in string array form
numsrot=[0]; % 1 rotates thw image by 90 degrees 0 leaves it the same
numsbackgrounnum=["042"]; %list of background in string array form
numsbackgroundrot=[0 0 0];

[DataDCAv,DataACXAv,DataACYAv,x,y,X,Y,Scan_Pixels,Scan_Range,pixsize]=AveregedImages(Year,Day,mounth,NameStart,nums,numsrot,TF_y_channel,TF_x_channel,DC_channel);
if ~isempty(numsbackgrounnum)
    [DataDCBack,DataACXBack,DataACYBack,x,y,X,Y,Scan_Pixels,Scan_Range,pixsize]=AveregedImages(Year,Day,mounth,NameStart,numsbackgrounnum,numsbackgroundrot,TF_y_channel,TF_x_channel,DC_channel);

    DataTFy=DataACYAv-DataACYBack;

    DataTFx=DataACXAv-DataACXBack;

    DataDC=DataDCAv-DataDCBack;
else
    DataTFy=DataACYAv;

    DataTFx=DataACXAv;

    DataDC=DataDCAv;
end

DataDC=flipud(DataDC);
DataTFx=flipud(DataTFx).*((LIA_sensitivity)/10);
DataTFy=flipud(DataTFy).*((LIA_sensitivity)/10);


%%
[Real_Space_Ocillation_x,Real_Space_Ocillation_Y,Min,phase]=get_tip_vibration(DataDC,DataTFy,DataTFx,x,y);

Real_Space_Ocillation_x=Real_Space_Ocillation_x*1e6;
Real_Space_Ocillation_Y=Real_Space_Ocillation_Y*1e6;
MDC=DataDC;
Min=Min;%option to add minus sine if neede

if Use_TF_Oscillation_fit_amplitude==1
    MTF=Min.*(1/(Real_Space_Ocillation_Y*TipResponse));
    TF_Amplitude=Real_Space_Ocillation_Y;
    DataDC=DataDC./TipResponse;
elseif isempty(TipResponse)
    MTF=Min;
else
    MTF=Min.*(1/(TF_Amplitude*TipResponse));
end


%%
if isempty(peak)
    figure;surf(X,Y,MTF)
    m=mean(MTF(:));
    s=std(MTF(:));
    caxis([m-s m+s])
    caxis
    view(2);shading flat;
    [xx,yy] = ginput(1);
else
    xx=peak(1);
    yy=peak(2);
end
[~,xcut]=min(abs(X(1,:)-xx));
% xcut=X(1,ix);
[~,ycut]=min(abs(Y(:,1)-yy));
% ycut=Y(iy,1);
D=26;
er=1
while er & D>0
try
X=X(ycut-D:ycut+D,xcut-D:xcut+D);
Y=Y(ycut-D:ycut+D,xcut-D:xcut+D);
MDC=MDC(ycut-D:ycut+D,xcut-D:xcut+D);
MTF=MTF(ycut-D:ycut+D,xcut-D:xcut+D);
er=0
catch
    D=D-1;
end
end

%%
if isempty(peak)
    figure;surf(X,Y,MTF)
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
backDC=fit([X(sel==0),Y(sel==0)],MDC(sel==0),'poly11');
MDC=MDC-backDC(X,Y);

backTF=fit([X(sel==0),Y(sel==0)],MTF(sel==0),'poly11');
MTF=MTF-backTF(X,Y);

xc=xEx;
yc=yEx;

figure;
subplot(1,2,1)
surf(X,Y,MDC)
view(2);shading flat;
axis image

hold on
plot3(xc,yc,(xc./xc)*(max(MDC(:)+1)),'o')
hold off

subplot(1,2,2)
surf(X,Y,MTF)
view(2);shading flat;
axis image

hold on
plot3(xc,yc,(xc./xc)*(max(MTF(:)+1)),'o')
hold off


hold on
Kernel= MaskGen(tipradious,X,0);



%% fitting based on image differentiation

[coef,Err] = PearlFitTFDataDifferentiation(MTF,X,Y,pixsize,xc,yc,phi_0,DistanceFromSample,TipResponse,sel,Kernel);
ErrDataDifferentiation=Err;
%Setting coefs from the fit
PearlLengthTFDataDifferentiation=coef(1);
if numel(coef)==3
    MatrixMultiplierTFDataDifferentiation=coef(2);
    TipResponseDataDifferentiation=MatrixMultiplierTFDataDifferentiation/Real_Space_Ocillation_Y;
    MTFDataDifferentiation6=MTF./MatrixMultiplierTFDataDifferentiation;   
    DistanceFromSampleDataDifferentiation=coef(3);
elseif numel(coef)==2
    if isempty(TipResponse)
        MatrixMultiplierTFDataDifferentiation=coef(2);
        TipResponseDataDifferentiation=MatrixMultiplierTFDataDifferentiation/Real_Space_Ocillation_Y;
        MTFDataDifferentiation6=MTF./MatrixMultiplierTFDataDifferentiation;
        DistanceFromSampleDataDifferentiation=DistanceFromSample;
    else
        DistanceFromSampleDataDifferentiation=coef(2);
    end
end
if ~isempty(TipResponse)
    TipResponseDataDifferentiation=TipResponse;
    MTFDataDifferentiation6=MTF;
end

if ~isempty(DistanceFromSample)
    DistanceFromSampleDataDifferentiation=DistanceFromSample;
end

xcpixelnumData=find(X(1,:)==xc)
ycpixelnumData=find(Y(:,1)==yc)
X1=X(3:end-2,3:end-2);
Y1=Y(3:end-2,3:end-2);
MTFDataDifferentiation16=MTFDataDifferentiation6(3:end-2,3:end-2);

figure(11)
surf(X,Y,MTFDataDifferentiation6)
view(2)
shading interp
axis equal
xlim([X(1,xcpixelnumData-24) X(1,xcpixelnumData+24)])
ylim([Y(ycpixelnumData-24,1) Y(ycpixelnumData+24,1)])
hold off

Y2=Y;
X2=X;
Y2(end+1,:)=((Y(2,1)-Y(1,1))+Y(end,1))+X(1,:)*0;
Y2(:,end+1)=Y2(:,1);
X2(:,end+1)=((X(1,2)-X(1,1))+X(1,end))+X(1,:)*0;
X2(end+1,:)=X2(1,:);

%[Bz_ratio] = VortexDistanceRatio(X2,Y2,xc,yc,DistanceFromSampleDataDifferentiation,WantedDistanceFromSample);

%Bz_ratio_Derivative=diff(Bz_ratio(:,1:end-1));

%Bz_ratio1=Bz_ratio(3:end-2,3:end-2);

% Bz_ratio_Derivative=1-abs(Bz_ratio_Derivative);
% Bz_ratio_Derivative1=1-abs(Bz_ratio_Derivative1);

[BzDataDifferentiation6,ConvBzDataDifferentiation6] = pearlgen_no_mag(X2,Y2,xc,yc,PearlLengthTFDataDifferentiation,DistanceFromSample,phi_0,Kernel);

BzDataDifferentiation_diff6=diff(BzDataDifferentiation6(:,1:end-1))/pixsize;
ConvBzDataDifferentiation_diff6=diff(ConvBzDataDifferentiation6(:,1:end-1))/pixsize;

ConvBzDataDifferentiation_diff16=ConvBzDataDifferentiation_diff6(3:end-2,3:end-2);

xcpixelnumModel=find(X1(1,:)==xc)
ycpixelnumModel=find(Y1(:,1)==yc)

figure(12)
surf(X1,Y1,ConvBzDataDifferentiation_diff16)
view(2)
shading interp
axis equal
xlim([X1(1,xcpixelnumModel-24) X1(1,xcpixelnumModel+24)])
ylim([Y1(ycpixelnumModel-24,1) Y1(ycpixelnumModel+24,1)])
hold off


%MTFDataDifferentiation16=MTFDataDifferentiation16.*Bz_ratio1;

figure(13)
plot(X1(1,:),MTFDataDifferentiation16(:,xcpixelnumModel),'color',[0 0.4470 0.7410]	,'LineWidth',3)
grid off
axis([X1(1,xcpixelnumModel-24) X1(1,xcpixelnumModel+24) min(MTFDataDifferentiation16(:))-(min(MTFDataDifferentiation16(:))/10),max(MTFDataDifferentiation16(:))+(max(MTFDataDifferentiation16(:))/10)])
hold on
plot(X1(1,:),ConvBzDataDifferentiation_diff16(:,xcpixelnumModel),'color',[0.9290 0.6940 0.1250]	,'LineWidth',3)
xlabel('y [{\mu}m]')
ylabel('{dB_z (y)}\{dy [G]}')
ax=gca;
ax.FontSize=15;
axis square
hold off

%% Save

% [BzDataDifferentiation6r,ConvBzDataDifferentiation6r] = pearlgen_no_mag(X2,Y2,xc,yc,PearlLengthTFDataDifferentiation,0.36,phi_0,Kernel);
% 
% RatioOfSignalStregthBecausedCloserScanning=(max(ConvBzDataDifferentiation6(:))-max(ConvBzDataDifferentiation6r(:)))/max(ConvBzDataDifferentiation6r(:));

Data6layers=MTFDataDifferentiation16;
Model6Layers=ConvBzDataDifferentiation_diff16;
X6Layers=X1;
PearlLengthFit=PearlLengthTFDataDifferentiation;

SuppData6Layers={Data6layers Model6Layers X6Layers PearlLengthFit};

save('Paper Figures\\Supplementary\\Tip_Sensitivity\\SaveSuppData6Layers.mat','SuppData6Layers')
