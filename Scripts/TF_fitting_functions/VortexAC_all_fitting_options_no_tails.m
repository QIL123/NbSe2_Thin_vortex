clear
close all
clc
%%
%this function is going to fit TF vortex databy Pearl Model and give the
%Pearl length and other parameters per users choise, Tip Response,
%Distansce from Sample ane The Real sapce oscillation amplitude.


% fitting parameters notice if we want to fit Tip Response in this
% option the distance from the sample has to get a value

%TipResponse=0.0060887; %Volts per Gauss
TipResponse=1.84e-3;% 5 layer sample 
%TipResponse=;


DistanceFromSample=0.26;  %distance from sample in um
TF_Amplitude=[0.149]; % in um
Use_TF_Oscillation_fit_amplitude=0;  %controling whether we fit baced on get tip vibration or fit the ocillation as well 1 means using the fit 0 fitting baced on vortex
%these first 4 chose what kind of fit the code is going to try all other ones
%are for normalizatoin the option that tries to fit all prameters doesn't
%give reasonable values 
peak=[];



LayerN=5;
thick=LayerN*(0.627)*1e-3; 
r=0.95; %radios of exlotion in the image
DC_channel=2;%1 for forward 2 for backward
TF_x_channel=4; 
TF_y_channel=6;
LIA_sensitivity=5e-4; %in Volts
DialationFactor=1;% our estimated strech in XY scanners when compared to optical or AFM data
phi_0=20.7;% units gauss*um 
tipradious=0.270/2; %in um
t=[0:pi/20:2*pi]; %created to plot the radius of exclusion on the plots
err_thick=0.001;

%% 
% choosing and uploading image

Day='15';
num_of_file_name_ending='078';
Mounth='Apr';
Path1=sprintf('C:\\Users\\Owner\\Desktop\\NbSe2\\NbSe2_Data\\%s\\%s\\SXM\\EuS01421%s.sxm',Mounth,Day,num_of_file_name_ending);
sxmFile1 = sxm.load.loadProcessedSxM(Path1);
header1=sxmFile1.header;
Scan_Pixels=sxmFile1.header.scan_pixels;
Scan_Range=sxmFile1.header.scan_range*DialationFactor;
pixsize=Scan_Range(1)*1e6/Scan_Pixels(1); %in um

DataDC=sxmFile1.channels(DC_channel).rawData;
DataTFx=sxmFile1.channels(TF_x_channel).rawData;
DataTFy=sxmFile1.channels(TF_y_channel).rawData;
x=linspace(0,Scan_Range(1)*10^6,Scan_Pixels(1)); %in um
y=linspace(0,Scan_Range(2)*10^6,Scan_Pixels(2)); %in um
[X,Y]=meshgrid(x,y);


DataDC=flipud(DataDC);
DataTFx=flipud(DataTFx).*((LIA_sensitivity)/10);
DataTFy=flipud(DataTFy).*((LIA_sensitivity)/10);


[Real_Space_Ocillation_x,Real_Space_Ocillation_Y,Min,phase]=get_tip_vibration(DataDC,DataTFy,DataTFx,x,y);

Real_Space_Ocillation_x=Real_Space_Ocillation_x*1e6;
Real_Space_Ocillation_Y=Real_Space_Ocillation_Y*1e6;
MDC=DataDC;
Min=Min;%option to add minus sine if neede

if Use_TF_Oscillation_fit_amplitude==1
    MTF=Min.*(pixsize/(Real_Space_Ocillation_Y*TipResponse));
    TF_Amplitude=Real_Space_Ocillation_Y;
    DataDC=DataDC./TipResponse;
elseif isempty(TipResponse)
    MTF=Min.*pixsize;
else
    MTF=Min.*(pixsize/(TF_Amplitude*TipResponse));
end

%% crops around a point you select

% figure;surf(X,Y,MDC)
% m=mean(MDC(:));
% s=std(MDC(:));
% caxis([m-s m+s])
% caxis
% view(2);shading flat;
% [xx,yy] = ginput(1);
% [~,xcut]=min(abs(X(1,:)-xx));
% % xcut=X(1,ix);
% [~,ycut]=min(abs(Y(:,1)-yy));
% % ycut=Y(iy,1);
% D=21;
% er=1
% while er & D>0
% try
% X=X(ycut-D:ycut+D,xcut-D:xcut+D);
% Y=Y(ycut-D:ycut+D,xcut-D:xcut+D);
% MDC=MDC(ycut-D:ycut+D,xcut-D:xcut+D);
% MTF=MTF(ycut-D:ycut+D,xcut-D:xcut+D);
% er=0
% catch
%     D=D-1;
% end
% end

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
D=21;
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
%% find peak manually

% figure;surf(X,Y,MDC)
% view(2);shading flat;
% axis square
% [xx,yy] = ginput(1);
% [~,ix]=min(abs(X(1,:)-xx));
% xEx=X(1,ix);
% [~,iy]=min(abs(Y(:,1)-yy));
% yEx=Y(iy,1);
% 
% %Exclusion area
% R=r+0.005; %[um]
% R2=r-0.05; %[um]
% sel=X*0;
% 
% for i=1:length(xEx)
%     sel=sel+((xEx(i)-X).^2+(yEx(i)-Y).^2<R^2);
% end
% % substract plane
% backDC=fit([X(sel==0),Y(sel==0)],MDC(sel==0),'poly11');
% MDC=MDC-backDC(X,Y);
% 
% backTF=fit([X(sel==0),Y(sel==0)],MTF(sel==0),'poly11');
% MTF=MTF-backTF(X,Y);
% 
% xc=xEx;
% yc=yEx;
% 
% figure;
% subplot(1,2,1)
% surf(X,Y,MDC)
% view(2);shading flat;
% axis image
% 
% hold on
% plot3(xc,yc,(xc./xc)*(max(MDC(:)+1)),'o')
% hold off
% 
% subplot(1,2,2)
% surf(X,Y,MTF)
% view(2);shading flat;
% axis image
% 
% hold on
% plot3(xc,yc,(xc./xc)*(max(MTF(:)+1)),'o')
% hold off
% 
% 
% hold on
% Kernel= MaskGen(tipradious,X,0);

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

[coef,Err] = PearlFitTFDataDifferentiation(MTF,X,Y,xc,yc,phi_0,DistanceFromSample,TipResponse,sel,Kernel);
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

% lambdaDataDifferentiation=sqrt(PearlLengthTFDataDifferentiation*thick/2);%calculating the pentration depth
% lam_errDataDifferentiation=(1/(2*sqrt(2))) * sqrt(lambdaDataDifferentiation/thick) * err_thick*1e3;%calculating the pentration depth error

%add_to_data_index_excel_ACImageDiffdistanceOnlyDataFit(num_of_file_name_ending, Mounth, Day,PearlLengthTFDataDifferentiation, DistanceFromSampleDataDifferentiation, TipResponseDataDifferentiation,Real_Space_Ocillation_Y, tipradious,r,xc,yc,LayerN,ErrDataDifferentiation)

%% fitting based on model derivative

[coef,Err] = PearlFitTFModelDerivative(MTF,X,Y,xc,yc,phi_0,DistanceFromSample,TipResponse,sel,Kernel);
ErrModelDerivative=Err;
%Setting coefs from the fit
PearlLengthTFModelDerivative=coef(1);
if numel(coef)==3
    MatrixMultiplierTFModelDerivative=coef(2);
    TipResponseModelDerivative=MatrixMultiplierTFModelDerivative/Real_Space_Ocillation_Y;
    MTFModelDerivative=MTF./MatrixMultiplierTFModelDerivative;   
    DistanceFromSampleModelDerivative=coef(3);
elseif numel(coef)==2
    if isempty(TipResponse)
        MatrixMultiplierTFModelDerivative=coef(2);
        TipResponseModelDerivative=MatrixMultiplierTFModelDerivative/Real_Space_Ocillation_Y;
        MTFModelDerivative=MTF./MatrixMultiplierTFModelDerivative;
        DistanceFromSampleModelDerivative=DistanceFromSample;
    else
        DistanceFromSampleModelDerivative=coef(2);
    end
end
if ~isempty(TipResponse)
    TipResponseModelDerivative=TipResponse;
    MTFModelDerivative=MTF;
end

if ~isempty(DistanceFromSample)
    DistanceFromSampleModelDerivative=DistanceFromSample;
end
MTFModelDerivative1=MTFModelDerivative(3:end-2,3:end-2);

% lambdaModelDerivative=sqrt(PearlLengthTFModelDerivative*thick/2);%calculating the pentration depth
% lam_errModelDerivative=(1/(2*sqrt(2))) * sqrt(lambdaModelDerivative/thick) * err_thick*1e3;%calculating the pentration depth error

%add_to_data_index_excel_ACAnalyticalDerivativedistanceOnlyDataF(num_of_file_name_ending, Mounth, Day,PearlLengthTFModelDerivative, DistanceFromSampleModelDerivative, TipResponseModelDerivative,Real_Space_Ocillation_Y, tipradious,r,xc,yc,LayerN,ErrModelDerivative)

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
    %plot3(xEx(i),yEx(i),abs(max(max(M))),'.','markersize',10,'color',[1 1 1]*0)
end
%plotting the error between the model and the data
Y2=Y;
X2=X;
Y2(end+1,:)=((Y(2,1)-Y(1,1))+Y(end,1))+X(1,:)*0;
Y2(:,end+1)=Y2(:,1);
X2(:,end+1)=((X(1,2)-X(1,1))+X(1,end))+X(1,:)*0;
X2(end+1,:)=X2(1,:);

[BzDataDifferentiation,ConvBzDataDifferentiation] = pearlgen_no_mag(X2,Y2,xc,yc,PearlLengthTFDataDifferentiation,DistanceFromSampleDataDifferentiation,phi_0,Kernel);

BzDataDifferentiation_diff=diff(BzDataDifferentiation(:,1:end-1));
ConvBzDataDifferentiation_diff=diff(ConvBzDataDifferentiation(:,1:end-1));

ConvBzDataDifferentiation_diff1=ConvBzDataDifferentiation_diff(3:end-2,3:end-2);


axis square
hold off
% axis off
% figure(124)
figure(1515)
subplot(1,5,2)
% surf(X(aa-l:aa+l,bb-l:bb+l),Y(aa-l:aa+l,bb-l:bb+l),M(aa-l:aa+l,bb-l:bb+l)-Bz(aa-l:aa+l,bb-l:bb+l))
surf(X1,Y1,MTFDataDifferentiation1-ConvBzDataDifferentiation_diff1)
view(2);
shading flat;
caxis([min(min(MTFDataDifferentiation1)) max(max(MTFDataDifferentiation1))])
axis square

hold off

%plotting the model with the numbers from the fit

fig=figure(1515);
subplot(1,5,3)
% surf(X(aa-l:aa+l,bb-l:bb+l),Y(aa-l:aa+l,bb-l:bb+l),Bz(aa-l:aa+l,bb-l:bb+l))
surf(X1,Y1,ConvBzDataDifferentiation_diff1)
view(2);
shading flat;

caxis([min(min(MTFDataDifferentiation1)) max(max(MTFDataDifferentiation1))])
axis square
hold off

[Bz_diff_model_derivative,ConvBz_diff_model_derivative,Bz_model_derivative,ConvBz_model_derivative] = pearlgen_combine_no_mag(X,Y,xc,yc,PearlLengthTFModelDerivative,DistanceFromSampleModelDerivative,phi_0,Kernel);

ConvBz_diff_model_derivative1=ConvBz_diff_model_derivative(3:end-2,3:end-2);

axis square
hold off
% axis off
% figure(124)
figure(1515)
subplot(1,5,4)
% surf(X(aa-l:aa+l,bb-l:bb+l),Y(aa-l:aa+l,bb-l:bb+l),M(aa-l:aa+l,bb-l:bb+l)-Bz(aa-l:aa+l,bb-l:bb+l))
surf(X1,Y1,MTFModelDerivative1-ConvBz_diff_model_derivative1)
view(2);
shading flat;
caxis([min(min(MTFModelDerivative1)) max(max(MTFModelDerivative1))])
axis square

hold off

%plotting the model with the numbers from the fit

fig=figure(1515);
subplot(1,5,5)
% surf(X(aa-l:aa+l,bb-l:bb+l),Y(aa-l:aa+l,bb-l:bb+l),Bz(aa-l:aa+l,bb-l:bb+l))
surf(X1,Y1,ConvBz_diff_model_derivative1)
view(2);
shading flat;

caxis([min(min(MTFModelDerivative1)) max(max(MTFModelDerivative1))])
fig.WindowState = 'maximized';

axis square
hold off



sgtitle(['Pearl Length Fit Data Diff = ',num2str(PearlLengthTFDataDifferentiation),'Pearl Length Fit model Diff = ',num2str(PearlLengthTFModelDerivative),' Dist = ',num2str(DistanceFromSampleDataDifferentiation),' DistAnalyticalDiff = ',num2str(DistanceFromSampleDataDifferentiation),num2str(DistanceFromSampleModelDerivative)...
    ,' Tip Response = ',num2str(TipResponseDataDifferentiation),' Tip Response = ',num2str(TipResponseModelDerivative),' number of layers=',num2str(LayerN),' day ',Day,' num of file name ending',num_of_file_name_ending])

fn=sprintf('C:\\Users\\Desktop\\NbSe2\\NbSe2_Data\\Figures\\%s\\%s\\%s.jpg',Day,num_of_file_name_ending);

figure(555)
subplot(6,6,[1 2 7 8])
surf(X1,Y1,MTFDataDifferentiation1)
shading interp
title('Data')
axis equal
subplot(6,6,[3 4 9 10])
surf(X1,Y1,ConvBzDataDifferentiation_diff1)
shading interp
title('Model diffrentiated with image diff')
caxis([min(MTFDataDifferentiation1(:)),max(MTFDataDifferentiation1(:))])
axis equal
subplot(6,6,[5 6 11 12])
surf(X1,Y1,MTFDataDifferentiation1-ConvBzDataDifferentiation_diff1)
shading interp
title('Residuals')
axis equal
caxis([min(MTFDataDifferentiation1(:)),max(MTFDataDifferentiation1(:))])
subplot(6,6,[13 14 19 20])
surf(X1,Y1,MTFModelDerivative1)
shading interp
title('Data')
axis equal
subplot(6,6,[15 16 21 22])
surf(X1,Y1,ConvBz_diff_model_derivative1)
shading interp
title('Model Analitical diffrentiation')
caxis([min(MTFModelDerivative1(:)),max(MTFModelDerivative1(:))])
axis equal
subplot(6,6,[17 18 23 24])
surf(X1,Y1,MTFModelDerivative1-ConvBz_diff_model_derivative1)
shading interp
title('Residuals')
axis equal
caxis([min(MTFModelDerivative1(:)),max(MTFModelDerivative1(:))])
subplot(6,6,[26 27])
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
subplot(6,6,[32 33])
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
subplot(6,6,[28 29])
title('Cross-Section analitical derivative')
plot(X1(1,:),MTFModelDerivative1(:,bb))
xlabel('y [\mum]')
ylabel('B [G]')
grid on
axis([X1(1,1) X1(1,end) min(MTFModelDerivative1(:)),max(MTFModelDerivative1(:))+(max(MTFModelDerivative1(:))/10)])
hold on
plot(X1(1,:),ConvBz_diff_model_derivative1(:,bb))
hold off
legend('Data','Model analitical derivative')
subplot(6,6,[34 35])
title('Cross-Section analitical derivative')
plot(Y1(:,1),MTFModelDerivative1(aa,:))
xlabel('x [\mum]')
ylabel('B [G]')
grid on
axis([Y1(1,1) Y1(end,1) min(MTFModelDerivative1(:)),max(MTFModelDerivative1(:))+(max(MTFModelDerivative1(:))/10)])
hold on
plot(Y1(:,1),ConvBz_diff_model_derivative1(aa,:))
legend('Data','Model analitical derivative')
hold off

sgtitle(['Pearl Length Fit Data Diff = ',num2str(PearlLengthTFDataDifferentiation),'Pearl Length Fit model Diff = ',num2str(PearlLengthTFModelDerivative),' DistImageDiff = ',num2str(DistanceFromSampleModelDerivative),' DistAnalyticalDiff = ',num2str(DistanceFromSampleDataDifferentiation),num2str(DistanceFromSampleModelDerivative)...
    ,' Tip Response = ',num2str(TipResponseDataDifferentiation),' Tip Response = ',num2str(TipResponseModelDerivative),' number of layers=',num2str(LayerN),' day ',Day,' num of file name ending',num_of_file_name_ending])