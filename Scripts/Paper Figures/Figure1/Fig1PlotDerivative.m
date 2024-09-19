clear all
close all
clc

%%

% set figure
len=2.4; %in
width=2.4*2; %in

newfig=figure('NumberTitle', 'off', 'Name', 'Fit');
Position=[0.5 0.5 width len];
clf
set(newfig,'Units','in')
set(newfig,'Position',Position,'Color',[1 1 1])
fontcolor='k';
linewidth=1;
linewidth_curve=1.13;
fontsize=10;
FontName='Arial';

% plot a
Xnum=2; %axis in X
Ynum=1; %axis in Y
spaceX=0.05;
spaceY=0;
X0=0.5; %general offset on the left plot
Y0=0.4;%general offset under plot
X1=0; %general offset right plot
Y1=0;%general above under plot

X_size=1.85;
factor=1;
Y_size=X_size*factor;


x0=X0+spaceX;
y0=Y0+spaceY;
posfig(1,1)={[x0 y0 X_size Y_size]};
figs(1,1)=axes('Parent',newfig,...
    'ZColor',fontcolor,'YColor',fontcolor,'XColor',fontcolor,...
    'LineWidth',linewidth,...
    'FontSize',fontsize,...
    'FontName',FontName,...
    'Color','none',...
    'Units','in',...
    'Position',posfig{1,1});
box(figs(1,1),'on');    
hold(figs(1,1),'all');

x0=X0+spaceX*2+X_size;
y0=Y0+spaceY*Y_size;
posfig(1,2)={[x0 y0 X_size Y_size]};
figs(1,2)=axes('Parent',newfig,...
    'ZColor',fontcolor,'YColor',fontcolor,'XColor',fontcolor,...
    'LineWidth',linewidth,...
    'FontSize',fontsize,...
    'FontName',FontName,...
    'Color','none',...
    'Units','in',...
    'YAxisLocation','right',...
    'Position',posfig{1,2});
box(figs(1,2),'on');    
hold(figs(1,2),'all');



%% loading plot data

Lambda=0.22;
z=0.26;
phi_0=20.7;
imagesize=2.4;
tipradious=0.270/2; 
PearlLength=2*(Lambda^2)/0.065;
abrikosovcolor="#c994c7";
pearl1color="#2c7fb8";
pearl100color=[0.9290 0.6940 0.1250];

x=linspace(0,imagesize,1001)-imagesize/2;
y=linspace(0,imagesize,1001)-imagesize/2;
pixsize=x(2)-x(1);

xc=x((size(x,2)/2)+0.5);
yc=y((size(y,2)/2)+0.5);
[X,Y]=meshgrid(x,y);
Kernel= MaskGen(tipradious,X,0);

set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperType', 'A4');

[BzPearl,ConvBzPearl] = pearlgen_no_mag(X,Y,xc,yc,PearlLength,z,phi_0,Kernel);

[~,bb]=find(X==xc,1);

BzPearl=(BzPearl-min(BzPearl(:,bb)))*100;%change to umT
X=X-xc;
BzPearlDerivative=diff(BzPearl(:,1:end-1))/pixsize;

[BzAbrikosov,ConvBzAbrikosov] = Abrikosov_Gen(X,Y,Lambda,z,Kernel,phi_0,imagesize);

BzAbrikosov=(BzAbrikosov-min(BzAbrikosov(:)))*100;%change to umT

AbrikosovDerivative=diff(BzAbrikosov(:,1:end-1))/pixsize;

% PearlLength100=100;
% [BzPearl100,ConvBzPearl100] = pearlgen_no_mag(X,Y,xc,yc,PearlLength100,z,phi_0,Kernel);
% 
% BzPearl100=(BzPearl100-min(BzPearl100(:,bb)))*100;%change to umT
% 
% BzPearl100Derivative=diff(BzPearl100(:,1:end-1))/pixsize;

%% Plots
figure(newfig)

axes(figs(1,1))
xticks([-1 0 1])
xlim([-1.2 1.2])

yticks([0 300 600])
yticklabels({'0','300','600'})
ylim([0 650])

plot(X(1,:),BzAbrikosov(:,bb),'color',abrikosovcolor,'LineWidth',linewidth_curve)

hold on

plot(X(1,:),BzPearl(:,bb),'color',pearl1color,'LineWidth',linewidth_curve)

%plot(X(1,:),BzPearl100(:,bb)*20,'color',pearl100color,'LineWidth',linewidth_curve)

hold off


axes(figs(1,2))
xticks([-1 0 1])
xlim([-1.2 1.2])
yticks([-1000 0 1000])
yticklabels({'-1000','0','1000'})
ylim([-1300 1300])


plot(X(1,1:end-1),AbrikosovDerivative(:,bb),'color',abrikosovcolor,'LineWidth',linewidth_curve)

hold on


plot(X(1,1:end-1),BzPearlDerivative(:,bb),'color',pearl1color,'LineWidth',linewidth_curve)



%plot(X(1,1:end-1),BzPearl100Derivative(:,bb)*20,'color',pearl100color,'LineWidth',linewidth_curve)

mar=0.13
d=text(figs(1,1),mar,Y_size-mar,'d','Units','in','Color','k','FontSize',10,'FontName',FontName);
f=text(figs(1,2),mar,Y_size-mar,'f','Units','in','Color','k','FontSize',10,'FontName',FontName);
%LambdaL=text(figs(1,2),X_size-6*mar,Y_size-mar,'{\phi}:{\lambda}_L 220(nm)','Units','in','Color',abrikosovcolor,'FontSize',8,'FontName',FontName);
% Pearl1=text(figs(1,2),X_size-6*mar,Y_size-2.5*mar,'{\phi}:{\wedge} 1.5({\mum})','Units','in','Color',pearl1color,'FontSize',8,'FontName',FontName);
% Pearl100=text(figs(1,2),X_size-6*mar,Y_size-4*mar,'{\phi}:{\wedge} 100({\mum})','Units','in','Color',pearl100color,'FontSize',8,'FontName',FontName);
LambdaL=text(figs(1,1),X_size-4*mar,Y_size-2.5*mar,'{\lambda}_L 220nm','Units','in','Color',abrikosovcolor,'FontSize',8,'FontName',FontName);
Pearl1=text(figs(1,1),X_size-4.2*mar,Y_size-mar,'{\Lambda} 1.5 {\mum}','Units','in','Color',pearl1color,'FontSize',8,'FontName',FontName);
%Pearl100=text(figs(1,1),X_size-4.2*mar,Y_size-2.5*mar,'{\Lambda} 100 {\mum}','Units','in','Color',pearl100color,'FontSize',8,'FontName',FontName);
Ylabel2=text(figs(1,2),X_size+2.5*mar,3.4*mar,'B^{ac}_z(h,x)/x_{ac} (T/m)','Units','in','Rotation',90,'Color','k','FontSize',10,'FontName',FontName);
Ylabel1=text(figs(1,1),-3*mar,4.5*mar,'{B_z}(h,x) ({\mu}T)','Units','in','Rotation',90,'Color','k','FontSize',10,'FontName',FontName);
Xlabel2=text(figs(1,2),5*mar,-2*mar,'x ({\mum})','Units','in','Color','k','FontSize',10,'FontName',FontName);
Xlabel1=text(figs(1,1),5*mar,-2*mar,'x ({\mum})','Units','in','Color','k','FontSize',10,'FontName',FontName);
rDerivative=text(figs(1,2),0.2*X_size,0.9*Y_size,'{1/r^2}','Units','in','Color',pearl1color,'FontSize',10,'FontName',FontName);
rModel=text(figs(1,1),0.35*X_size,0.9*Y_size,'{1/r}','Units','in','Color',pearl1color,'FontSize',10,'FontName',FontName);
ModelFactor=text(figs(1,1),0.43*X_size,0.1*Y_size,'X20','Units','in','Color',pearl100color,'FontSize',10,'FontName',FontName);
DerivativeFactor=text(figs(1,2),0.3*X_size,0.4*Y_size,'X20','Units','in','Color',pearl100color,'FontSize',10,'FontName',FontName);



hold off



