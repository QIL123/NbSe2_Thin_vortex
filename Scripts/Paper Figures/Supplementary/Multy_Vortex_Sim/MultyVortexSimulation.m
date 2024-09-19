clear all
clc

%%
SizeOfSimulationwindow=50;
RangeBetweenDifferentVortices=3;
pixnum=(SizeOfSimulationwindow/RangeBetweenDifferentVortices)*64; %I scanned 64 pixcells per line and the smallest window was 3X3 now creating 50X50 frame and kipping consistent
x=linspace(0,SizeOfSimulationwindow,pixnum); % creating a vectore of 50 um with same pixcell size as I scanned mostly
y=linspace(0,SizeOfSimulationwindow,pixnum);% creating a vectore of 50 um with same pixcell size as I scanned mostly
pixsize=x(2)-x(1); % in um 
[X,Y]=meshgrid(x,y);
vortexnumber=round(SizeOfSimulationwindow^2/RangeBetweenDifferentVortices^2); %number of vortices per the density 
pearl_length=100;
z=0.36;
phi_0=20.7;
tipradios=0.270/2;
Kernel=MaskGen(tipradios,X,1);
MagneticSignal=zeros(length(x));
surf(X,Y,MagneticSignal)
for i=1:vortexnumber
    xpeak=round(rand(1)*pixnum/pixsize); %the vortex will be put in this place
    ypeak=round(rand(1)*pixnum/pixsize); % the vortex will be put in this place
    [Bz,ConvBz] = pearlgenNotCentered(X,Y,xpeak,ypeak,pearl_length,z,phi_0,Kernel);
    MagneticSignal=MagneticSignal+ConvBz;
end
MagneticSignaldiff=diff(MagneticSignal(:,1:end-1))/pixsize;
X1=X(1:end-1,1:end-1);
Y1=Y(1:end-1,1:end-1);

figure(1)
surf(X,Y,MagneticSignal)
view(2)
shading flat

figure(2)
surf(X1,Y1,MagneticSignaldiff)
view(2)
shading flat

save(['Paper Figures\Supplementary\Multy_Vortex_Sim\SimulationPearllLength100Distance360.mat'],'X','Y','MagneticSignal','MagneticSignaldiff')
