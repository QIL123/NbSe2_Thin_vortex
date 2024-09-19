% Figure - Fits and deferent images
clear
close all

% set figure
len=2.3; %in
width=2.3; %in

newfig=figure('NumberTitle', 'off', 'Name', 'Fit');
Position=[0.5 0.5 width len];
clf
set(newfig,'Units','in')
set(newfig,'Position',Position,'Color',[1 1 1])
fontcolor='k';
linewidth=1;
linewidth_curve=1.25;
fontsize=12;
FontName='Arial';
Multiplyer3Layer=2;

[r,g,b]=Analyze_Support.Get_Gold();

% plot a
Xnum=1; %axis in X
Ynum=1; %axis in Y
X0=0.45; %general offset on the left plot
Y0=0.45;%general offset under plot
X1=0.2; %general offset right plot
Y1=0.2;%general above under plot

X_size=width-X1-X0;
factor=1;
Y_size=X_size*factor;

posfig(1,1)={[X0+X1-0.03 Y0 X_size Y_size]};
figs(1,1)=axes('Parent',newfig,...
    'ZColor',fontcolor,'YColor',fontcolor,'XColor',fontcolor,...
    'LineWidth',linewidth,...
    'FontSize',fontsize,...
    'FontName',FontName,...
    'Color','none',...
    'Units','in',...
    'xticklabel',{''},...
    'xtick',[],...
    'colormap',[r g b],...            
    'yticklabel',{''},...
    'ytick',[],...
    'YAxisLocation','left',...
    'Position',posfig{1,1});
box(figs(1,1),'on');    
hold(figs(1,1),'all');


%% Text
mar=0.13; %margin

color100nm="#c994c7";
color360nm=[0.9290 0.6940 0.1250];
color260nm="#2c7fb8";
legendfontsize=8;

DifferentDistances=text(figs(1,1),0,Y_size+mar,'Different Distances','Units','in','Color',[0 0 0],'FontSize',10.5,'FontName',FontName);
xaxis=text(figs(1,1),mar*4.5,-mar*2.5,'x ({\mum})','Units','in','Color',[0 0 0],'FontSize',10.5,'FontName',FontName);
Yaxis=text(figs(1,1),-mar*3,mar*2.5,'{dB_z}(x)/dx (T/m)','Units','in','Rotation',90,'Color',[0 0 0],'FontSize',10.5,'FontName',FontName);
f=text(figs(1,1),mar,Y_size-mar,'f','Units','in','Color','k','FontSize',fontsize,'FontName',FontName);

Dist100nm=text(figs(1,1),X_size-4*mar,Y_size-0.5*mar,'z=100 nm','Units','in','Color',color100nm,'FontSize',legendfontsize,'FontName',FontName);
Dist260nm=text(figs(1,1),X_size-4*mar,Y_size-1.5*mar,'z=260 nm','Units','in','Color',color260nm,'FontSize',legendfontsize,'FontName',FontName);
Dist360nm=text(figs(1,1),X_size-4*mar,Y_size-2.5*mar,'z=360 nm','Units','in','Color',color360nm,'FontSize',legendfontsize,'FontName',FontName);

PearlLength=text(figs(1,1),0.5*mar,1.5*mar,'{\Lambda}=100 {\mum}','Units','in','Color',[0 0 0],'FontSize',10.5,'FontName',FontName);

%% loading data

load('Paper Figures\Supplementary\Multipliar_For_For_Closer_Meas\MultiliarRelevantData.mat')
BzDerivative100nm=PlotDataMultipliar{1};
BzDerivative260nm=PlotDataMultipliar{2};
BzDerivative360nm=PlotDataMultipliar{3};
x=PlotDataMultipliar{4};

x=x-mean(x);
xc=round(size(x,2)/2);

%% Plot

axes(figs(1,1))
plot(x,BzDerivative100nm(:,xc),'Color',color100nm,'LineWidth',linewidth_curve)
hold on
plot(x(1,:),BzDerivative260nm(:,xc),'Color',color260nm,'LineWidth',linewidth_curve)
hold on
plot(x(1,:),BzDerivative360nm(:,xc),'Color',color360nm,'LineWidth',linewidth_curve)
axis([-1.14 1.14 min(BzDerivative100nm(:))+min(BzDerivative100nm(:))/10,max(BzDerivative100nm(:))+(max(BzDerivative100nm(:))/10)])
xticks([-1 0 1])
xticklabels({'-1','0','1'})

yticks([-0.3 0 0.3])
yticklabels({'-30','0','30'})


hold off