%% Tip Responses read tip characterization
% Sample 1

Year='2022';
Day='12';
mounth='Apr';
fbase='10.00 Info.inf';

fdir=sprintf('C:\\Users\\Owner\\Dropbox\\QIL projects\\NbSe2_thin vortex\\Data\\%s\\%s\\%s',Year,mounth,Day);
Matrix11=readmatrix(fullfile(fdir,[fbase(1:5),' UP.txt']));
Matrix12=readmatrix(fullfile(fdir,[fbase(1:5),' DOWN.txt']));

Vbias1=linspace(-1.5,1.5,201)';
H1=linspace(-100,100,41)';

TipResponse1=Matrix11(:,174);
polyfit1=fit(H1(20:24),TipResponse1(20:24),'poly1')
plot(H1,TipResponse1,'.')
hold on
plot(polyfit1)
TipResponse=polyfit1.p1;

%% histogram

%% Images of background taken with TF amplitude 20.076 belonging to this set of measurements

Year='2022';
Day='18';
mounth='Apr';
NameStart='NbSe2422';

nums=["078"]; %list of images in string array form
numsrot=[0]; % 1 rotates thw image by 90 degrees 0 leaves it the same
numsbackgrounnum=[]; %list of background in string array form
numsbackgroundrot=[];
TF_x_channel=4;
TF_y_channel=6;
DC_channel=2;
LIA_sensitivity=0.2e-3;
load('C:\Users\Owner\Desktop\NbSe2\codes\Paper Figures\Supplementary\Error_calculation\TipResponses\SaveAmpltideOschilationDataForBachgroundHistogram.mat','Real_Space_Ocillation')
Real_Space_Ocillation=Real_Space_Ocillation*1e6;
Path=sprintf('C:\\Users\\Owner\\Dropbox\\QIL projects\\NbSe2_thin vortex\\Data\\%s\\%s\\%s\\SXM\\%s%s.sxm',Year,mounth,Day,NameStart,convertStringsToChars(nums));

sxmFile = sxm.load.loadProcessedSxM(Path);
header=sxmFile.header;

Scan_Pixels=sxmFile.header.scan_pixels;

Scan_Range=sxmFile.header.scan_range;
pixsize=Scan_Range(1)*1e6/Scan_Pixels(1);

x=linspace(0,Scan_Range(1)*10^6,Scan_Pixels(1));
y=linspace(0,Scan_Range(2)*10^6,Scan_Pixels(2));
[X,Y]=meshgrid(x,y);            

DataACYt=sxmFile.channels(TF_y_channel).rawData/((TipResponse*Real_Space_Ocillation*10)/LIA_sensitivity); %normalized to mT/um

DataACXt=sxmFile.channels(TF_x_channel).rawData/((TipResponse*Real_Space_Ocillation*10)/LIA_sensitivity); %normalized to mT/um

DataDCt=sxmFile.channels(DC_channel).rawData/(TipResponse*10); %normalized to Tesla


surf(DataACXt)
surf(DataACYt)
surf(DataDCt)

histogram(DataDCt-mean(DataDCt(:)),101)
histogram(DataACXt-mean(DataACXt(:)),101)
histogram(DataACYt-mean(DataACYt(:)),101)

dDC=histfit(DataDCt(:))
dACX=histfit(DataACXt(:))
dACY=histfit(DataACYt(:))

pdDC=fitdist(DataDCt(:),'Normal')
pdACX=fitdist(DataACXt(:),'Normal')
pdACY=fitdist(DataACYt(:),'Normal')


[hACX,p,stats] = chi2gof(DataACXt(:))
[hACY,p,stats] = chi2gof(DataACYt(:))
[hDC,p,stats] = chi2gof(DataDCt(:))


%% Images of vortex and it's Image subtraction after fit histograms

clear
close all
clc
%%
%this function is going to fit TF vortex databy Pearl Model and give the
%Pearl length and other parameters per users choise, Tip Response,
%Distansce from Sample ane The Real sapce oscillation amplitude.

% TipResponse=6.586e-3;%Sample 1
% 
% DistanceFromSample=0.37;  %distance from sample in um
% TF_Amplitude=0.082; % in um
% Use_TF_Oscillation_fit_amplitude=0;  %controling whether we fit baced on get tip vibration or fit the ocillation as well 1 means using the fit 0 fitting baced on vortex
% 
% peak=[1.54 1.38];
% 
% LayerN=3;
% thick=LayerN*(0.627)*1e-3;
% r=1; %radios of exlotion in the image
% DC_channel=2;%1 for forward 2 for backward
% TF_x_channel=4; 
% TF_y_channel=6;
% LIA_sensitivity=5e-4; %in Volts
% DialationFactor=1;% our estimated strech in XY scanners when compared to optical or AFM data
% phi_0=20.7;% units gauss*um 
% tipradious=0.269/2; %in um
% t=[0:pi/20:2*pi]; %created to plot the radius of exclusion on the plots
% err_thick=0.001;
% 
% %% 
% % choosing and uploading images avreges batch of images and substracts
% % backround as needed, will work the same for singel image and no backgroun
% 
% Year='2022';
% Day='18';
% mounth='Apr';
% NameStart='NbSe2422';
% 
% nums=["013" "014" "015"]; %list of images in string array form
% numsrot=[0 0 0]; % 1 rotates thw image by 90 degrees 0 leaves it the same
% numsbackgrounnum=[]; %list of background in string array form
% numsbackgroundrot=[];
% 
% [DataDCAv,DataACXAv,DataACYAv,x,y,X,Y,Scan_Pixels,Scan_Range,pixsize]=AveregedImages(Year,Day,mounth,NameStart,nums,numsrot,TF_y_channel,TF_x_channel,DC_channel);
% if ~isempty(numsbackgrounnum)
%     [DataDCBack,DataACXBack,DataACYBack,x,y,X,Y,Scan_Pixels,Scan_Range,pixsize]=AveregedImages(Year,Day,mounth,NameStart,numsbackgrounnum,numsbackgroundrot,TF_y_channel,TF_x_channel,DC_channel);
% 
%     DataTFy=DataACYAv-DataACYBack;
% 
%     DataTFx=DataACXAv-DataACXBack;
% 
%     DataDC=DataDCAv-DataDCBack;
% else
%     DataTFy=DataACYAv;
% 
%     DataTFx=DataACXAv;
% 
%     DataDC=DataDCAv;
% end
% 
% DataDC=flipud(DataDC);
% DataTFx=flipud(DataTFx).*((LIA_sensitivity)/10);
% DataTFy=flipud(DataTFy).*((LIA_sensitivity)/10);



TipResponse=6.586e-3;%Sample 1

DistanceFromSample=0.36;  %distance from sample in um
TF_Amplitude=[]; % in um
Use_TF_Oscillation_fit_amplitude=1;  %controling whether we fit baced on get tip vibration or fit the ocillation as well 1 means using the fit 0 fitting baced on vortex

peak=[2.03 2.06];

LayerN=7;
thick=LayerN*(0.627)*1e-3;
r=1.25; %radios of exlotion in the image
DC_channel=2;%1 for forward 2 for backward
TF_x_channel=4; 
TF_y_channel=6;
LIA_sensitivity=5e-4; %in Volts
DialationFactor=1;% our estimated strech in XY scanners when compared to optical or AFM data
phi_0=20.7;% units gauss*um 
tipradious=0.269/2; %in um
t=[0:pi/20:2*pi]; %created to plot the radius of exclusion on the plots
err_thick=0.001;

%% 
% choosing and uploading images avreges batch of images and substracts
% backround as needed, will work the same for singel image and no backgroun

Year='2022';
Day='14';
mounth='Apr';
NameStart='Eus01421';

nums=["028"]; %list of images in string array form
numsrot=[0]; % 1 rotates thw image by 90 degrees 0 leaves it the same
numsbackgrounnum=[]; %list of background in string array form
numsbackgroundrot=[];

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
    MTFDataDifferentiation=MTF./MatrixMultiplierTFDataDifferentiation;   
    DistanceFromSampleDataDifferentiation=coef(3);
elseif numel(coef)==2
    if isempty(TipResponse)
        MatrixMultiplierTFDataDifferentiation=coef(2);
        TipResponseDataDifferentiation=MatrixMultiplierTFDataDifferentiation/Real_Space_Ocillation_Y;
        MTFDataDifferentiation=MTF./MatrixMultiplierTFDataDifferentiation;
        DistanceFromSampleDataDifferentiation=DistanceFromSample;
    else
        DistanceFromSampleDataDifferentiation=coef(2);
    end
end
if ~isempty(TipResponse)
    TipResponseDataDifferentiation=TipResponse;
    MTFDataDifferentiation=MTF;
end

if ~isempty(DistanceFromSample)
    DistanceFromSampleDataDifferentiation=DistanceFromSample;
end
X1=X(3:end-2,3:end-2);
Y1=Y(3:end-2,3:end-2);

Y2=Y;
X2=X;
Y2(end+1,:)=((Y(2,1)-Y(1,1))+Y(end,1))+X(1,:)*0;
Y2(:,end+1)=Y2(:,1);
X2(:,end+1)=((X(1,2)-X(1,1))+X(1,end))+X(1,:)*0;
X2(end+1,:)=X2(1,:);

[~,ConvBzDataDifferentiation] = pearlgen_no_mag(X2,Y2,xc,yc,PearlLengthTFDataDifferentiation,DistanceFromSampleDataDifferentiation,phi_0,Kernel);

ConvBzDataDifferentiation_diff=diff(ConvBzDataDifferentiation(:,1:end-1))/pixsize;

ConvBzDataDifferentiation_diff1=ConvBzDataDifferentiation_diff(3:end-2,3:end-2);

MTF=MTF(3:end-2,3:end-2);

r=0.75;
R=r+0.005; %[um]
R2=r-0.05; %[um]
sel1=X1*0;

for i=1:length(xEx)
    sel1=sel1+((xEx(i)-X1).^2+(yEx(i)-Y1).^2<R^2);
end

figure
surf(ConvBzDataDifferentiation_diff1)
view(2)
shading flat

MTFjustcenter=MTF.*sel1;
figure
surf(MTFjustcenter)
view(2)
shading flat
MTFjustcenter1=nonzeros(MTFjustcenter);
hisfitVortexData=histfit(MTFjustcenter1)

pdACY=fitdist(MTFjustcenter1,'Normal');

[hVortex,p,stats] = chi2gof(MTFjustcenter1);

BackgroungSignal=MTF-ConvBzDataDifferentiation_diff1;
surf(BackgroungSignal)
view(2)
shading flat

BackgroungSignalJustCenter=BackgroungSignal.*sel1;
BackgroungSignalJustCenter1=nonzeros(BackgroungSignalJustCenter);

hisfitBackgroundData=histfit(BackgroungSignalJustCenter1)

[hBackGround,p,stats] = chi2gof(BackgroungSignalJustCenter1);
