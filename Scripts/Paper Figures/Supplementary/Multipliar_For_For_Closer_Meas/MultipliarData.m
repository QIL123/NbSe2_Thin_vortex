%%
clear all
clc
close all
%%
x=linspace(0,4,70);
[X,Y]=meshgrid(x,x);
pixsize=x(2)-x(1);
xc=x(70/2);
yc=xc;
PearlLength=100;
DistanceFromSample1=0.26;
DistanceFromSample2=0.36;
DistanceFromSample3=0.1;
phi_0=20.7;
Kernel=[];

[Bz260nm,~] = pearlgen_no_mag(X,Y,xc,yc,PearlLength,DistanceFromSample1,phi_0,Kernel);
[Bz360nm,~] = pearlgen_no_mag(X,Y,xc,yc,PearlLength,DistanceFromSample2,phi_0,Kernel);
[Bz100nm,~] = pearlgen_no_mag(X,Y,xc,yc,PearlLength,DistanceFromSample3,phi_0,Kernel);

BzDerivative260nm=diff(Bz260nm(:,1:end-1))/pixsize;
BzDerivative360nm=diff(Bz360nm(:,1:end-1))/pixsize;
BzDerivative100nm=diff(Bz100nm(:,1:end-1))/pixsize;

BzDerivative260nm=BzDerivative260nm(3:end-2,3:end-2);
BzDerivative360nm=BzDerivative360nm(3:end-2,3:end-2);
BzDerivative100nm=BzDerivative100nm(3:end-2,3:end-2);

x=x(1:end-5);

xc=round(length(x)/2);
%%

plot(x,BzDerivative100nm(:,xc),'Color',"b",'LineWidth',1)
hold on
plot(x,BzDerivative260nm(:,xc),'Color',[0.9290 0.6940 0.1250],'LineWidth',1)
hold on
plot(x,BzDerivative360nm(:,xc),'Color','r','LineWidth',1)
axis([x(1,1) x(1,end) min(BzDerivative100nm(:))+min(BzDerivative100nm(:))/10,max(BzDerivative100nm(:))+(max(BzDerivative100nm(:))/10)])

hold off

%% Save

PlotDataMultipliar={BzDerivative100nm BzDerivative260nm BzDerivative360nm x};

save('Paper Figures\Supplementary\Multipliar_For_For_Closer_Meas\MultiliarRelevantData.mat','PlotDataMultipliar')