clear all
close all
clc

%%
Lambda=0.22;
z=0.1;
phi_0=20.7;
imagesize=6;
tipradious=0.270/2; 
PearlLength=2*(Lambda^2)/0.065;

x=linspace(0,imagesize,1001)-imagesize/2;
y=linspace(0,imagesize,1001)-imagesize/2;

xc=x((size(x,2)/2)+0.5);
yc=y((size(y,2)/2)+0.5);
[X,Y]=meshgrid(x,y);
Kernel= MaskGen(tipradious,X,0);

set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperType', 'A4');

[BzPearl,ConvBzPearl] = pearlgen_no_mag(X,Y,xc,yc,PearlLength,z,phi_0,Kernel);

[~,bb]=find(X==xc,1);

BzPearl=BzPearl-min(BzPearl(:,bb));
X=X-xc;


figure(1615)
plot(X(1,:),BzPearl(:,bb),'color',[0 0.4470 0.7410]	,'LineWidth',3)
% title('Cross-Section image Pearl and Abrikosov')
% xlabel('y [\mum]')
% ylabel('B [G]')
hold on


[BzAbrikosov,ConvBzAbrikosov] = Abrikosov_Gen(X,Y,Lambda,z,Kernel,phi_0,imagesize);

BzAbrikosov=BzAbrikosov-min(BzAbrikosov(:));

plot(X(1,:),BzAbrikosov(:,bb),'color',[0.4660 0.6740 0.1880],'LineWidth',3)

axis square

PearlLength100=100;
[BzPearl100,ConvBzPearl100] = pearlgen_no_mag(X,Y,xc,yc,PearlLength100,z,phi_0,Kernel);

BzPearl100=BzPearl100-min(BzPearl100(:,bb));
BzPearl100=BzPearl100.*20;
plot(X(1,:),BzPearl100(:,bb),'color',[0.9290 0.6940 0.1250]	,'LineWidth',3)

set(gca,"FontSize",20)
x0=0;
y0=0;
width=500;
height=500;
set(gcf,'units','points','position',[x0,y0,width,height])
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperType', 'A4');

hold off

% figure(1515)
% subplot(1,2,1)
% surf(x,Y,BzAbrikosov)
% caxis([min(BzPearl(:)),max(BzPearl(:))])
% 
% 
% hold on
% subplot(1,2,2)
% surf(x,Y,BzPearl)
% caxis([min(BzPearl(:)),max(BzPearl(:))])
% hold off

