% Figure - Fits and deferent images
clear
close all


% set figure
len=4.8; %cm
width=4.2; %cm

newfig=figure('NumberTitle', 'off', 'Name', 'Fit');
Position=[0.5 0.5 width len];
clf
set(newfig,'Units','in')
set(newfig,'Position',Position,'Color',[1 1 1])
fontcolor='k';
linewidth=1;
linewidth_curve=1.5;
fontsize=12;
FontName='Arial';

[r,g,b]=Analyze_Support.Get_Gold();

% plot a
Xnum=2; %axis in X
Ynum=2; %axis in Y
% spaceX=(width-Xnum*X_size)/(Xnum+1);
% spaceY=(len-Ynum*Y_size)/(Ynum+1);
spaceX=0;
spaceY=0.65;
X_size=(width/Xnum)-spaceX-0.45;
factor=1;
Y_size=X_size*factor;
X0=0.4; %general offset
Y0=0;%general offset
% posfig=[spaceX spaceY X_size  Y_size];
for i=1:Ynum
    for j=1:Xnum
        x0=X0+spaceX*j+X_size*(j-1);
        y0=Y0+spaceY*i+Y_size*(i-1);
        posfig(i,j)={[x0 y0 X_size Y_size]};
        figs(i,j)=axes('Parent',newfig,...
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
            'YAxisLocation','right',...
            'Position',posfig{i,j});
        box(figs(i,j),'on');    
        hold(figs(i,j),'all');
    end
end
%% Text
mar=0.13; %margin
SingleVotexSimulation=text(figs(2,1),0,Y_size+mar,'Single-Vortex','Units','in','Color',[0 0 0],'FontSize',10.5,'FontName',FontName);
SingleVotexFit=text(figs(1,1),0,Y_size+mar,'Single-Votex Fit','Units','in','Color',[0 0 0],'FontSize',10.5,'FontName',FontName);
MultyVotexSim=text(figs(2,2),0,Y_size+mar,'Random Vortices','Units','in','Color',[0 0 0],'FontSize',10.5,'FontName',FontName);
MultyVotexFit=text(figs(1,2),0,Y_size+mar,'Random Vortices Fit','Units','in','Color',[0 0 0],'FontSize',10.5,'FontName',FontName);
% 
% Simulations=text(figs(2,1),-mar,0,'Simulation','Units','in','Rotation',90,'Color',[0 0 0],'FontSize',10,'FontName',FontName);
% Cross_Section=text(figs(1,1),-mar,0,'Cross Section','Units','in','Rotation',90,'Color',[0 0 0],'FontSize',10,'FontName',FontName);

CrossSectionYaxis=text(figs(1,2),X_size+mar*2.5,2.2*mar,'{B^{ac}_z}(h,x)/{x_{ac}} (T/m)','Units','in','Rotation',90,'Color',[0 0 0],'FontSize',10,'FontName',FontName);
%CrossSectionYaxis=text(figs(1,2),X_size+mar*2.5,2.2*mar,'{dB_z}(h,x)/{dx} (T/m)','Units','in','Rotation',90,'Color',[0 0 0],'FontSize',10,'FontName',FontName);
CrossSectionXaxisd=text(figs(1,2),mar*4.5,-2.5*mar,'x ({\mum})','Units','in','Color',[0 0 0],'FontSize',10.5,'FontName',FontName);
CrossSectionXaxisc=text(figs(1,1),mar*4.5,-2.5*mar,'x ({\mum})','Units','in','Color',[0 0 0],'FontSize',10.5,'FontName',FontName);

% letters

a=text(figs(2,1),mar,Y_size-mar,'a','Units','in','Color','k','FontSize',fontsize,'FontName',FontName);
b=text(figs(2,2),mar,Y_size-mar,'b','Units','in','Color','k','FontSize',fontsize,'FontName',FontName);
c=text(figs(1,1),mar,Y_size-mar,'c','Units','in','Color','k','FontSize',fontsize,'FontName',FontName);
d=text(figs(1,2),mar,Y_size-mar,'d','Units','in','Color','k','FontSize',fontsize,'FontName',FontName);

XLabelePanele=text(figs(2,1),mar*3.3,mar,'x','Units','in','Color','k','FontSize',10.5,'FontName',FontName);
YLabelePanele=text(figs(2,1),0.6*mar,mar*4,'y','Units','in','Color','k','FontSize',10.5,'FontName',FontName);

PearlLengthSingleVortex=text(figs(1,1),0.25*mar,1.5*mar,'{\Lambda}=100 {\mum}','Units','in','Color',[0 0 0],'FontSize',10.5,'FontName',FontName);
PearlLengthMultyVortices=text(figs(1,2),0.25*mar,1.5*mar,'{\Lambda}=110 {\mum}','Units','in','Color',[0 0 0],'FontSize',10.5,'FontName',FontName);


%% loading data
load('Paper Figures\Supplementary\Multy_Vortex_Sim\MultyVortexSimFit4.mat')

load('Paper Figures\Supplementary\Multy_Vortex_Sim\SingleVortexSimFit.mat')

xsize(1)=X_MultyVortexSim4(1,end)-X_MultyVortexSim4(1,1);
xsize(2)=X_SingleVortexSim(1,end)-X_SingleVortexSim(1,1);

xcutX_MultyVortexSim=xsize(1)-min(xsize);
xcutX_SingleVortexSim=xsize(2)-min(xsize);

numofpixcelcutMultyVortexSim=floor(((xcutX_MultyVortexSim)/(X_MultyVortexSim4(1,2)-X_MultyVortexSim4(1,1)))/2);
numofpixcelcutSingelVortexSim=floor(((xcutX_SingleVortexSim)/(X_SingleVortexSim(1,2)-X_SingleVortexSim(1,1)))/2);

M_MultyVortexSim=M_MultyVortexSim4(1+numofpixcelcutMultyVortexSim:end-numofpixcelcutMultyVortexSim,1+numofpixcelcutMultyVortexSim:end-numofpixcelcutMultyVortexSim);
M_SingleVortexSim=M_SingleVortexSim(1+numofpixcelcutSingelVortexSim:end-numofpixcelcutSingelVortexSim,1+numofpixcelcutSingelVortexSim:end-numofpixcelcutSingelVortexSim);

M_MultyVortexSimFit=M_MultyVortexSimFit4(1+numofpixcelcutMultyVortexSim:end-numofpixcelcutMultyVortexSim,1+numofpixcelcutMultyVortexSim:end-numofpixcelcutMultyVortexSim);
M_SingleVortexSimFit=M_SingleVortexSimFit(1+numofpixcelcutSingelVortexSim:end-numofpixcelcutSingelVortexSim,1+numofpixcelcutSingelVortexSim:end-numofpixcelcutSingelVortexSim);

X_MultyVortexSim=X_MultyVortexSim4(1+numofpixcelcutMultyVortexSim:end-numofpixcelcutMultyVortexSim,1+numofpixcelcutMultyVortexSim:end-numofpixcelcutMultyVortexSim);
X_MultyVortexSim=X_MultyVortexSim-mean(X_MultyVortexSim(1,:));
X_SingleVortexSim=X_SingleVortexSim(1+numofpixcelcutSingelVortexSim:end-numofpixcelcutSingelVortexSim,1+numofpixcelcutSingelVortexSim:end-numofpixcelcutSingelVortexSim);
X_SingleVortexSim=X_SingleVortexSim-mean(X_SingleVortexSim(1,:));

Y_MultyVortexSim=Y_MultyVortexSim4(1+numofpixcelcutMultyVortexSim:end-numofpixcelcutMultyVortexSim,1+numofpixcelcutMultyVortexSim:end-numofpixcelcutMultyVortexSim);
Y_MultyVortexSim=Y_MultyVortexSim-mean(Y_MultyVortexSim(1,:));
Y_SingleVortexSim=Y_SingleVortexSim(1+numofpixcelcutSingelVortexSim:end-numofpixcelcutSingelVortexSim,1+numofpixcelcutSingelVortexSim:end-numofpixcelcutSingelVortexSim);
Y_SingleVortexSim=Y_SingleVortexSim-mean(Y_SingleVortexSim(1,:));

%% Scales
ScaleLength=2; %in um
marg=0.1;
W=0.04; %width of scale bar in inch

% 3 Layers
figPos=posfig{2,2};
pixelsize=X_MultyVortexSim(1,2)-X_MultyVortexSim(1,1);
ScaleLengthPx=ScaleLength/pixelsize;
ScaleLengthIn=ScaleLengthPx*(X_size/size(X_MultyVortexSim,1));
ScalePosition=[figPos(1)+marg figPos(2)+marg ScaleLengthIn W];
hThin = annotation('rectangle','Units','inches',...
    'Position',ScalePosition,...
    'color','none','FaceColor',[0.9290 0.6940 0.1250]);

textScaleBar=text(figs(2,2),0+0.5*mar,0+2*mar,'2 {\mum}','Units','in','Color',[0.9290 0.6940 0.1250],'FontSize',10.5,'FontName',FontName);

textScaleBar.FontSize=fontsize;

%% XY Arrows

ArrowPosition=posfig{2,1};
ArrowSize=0.3;

Arrowx=annotation("arrow",'Units','inches',...
    'Position',[ArrowPosition(1)+marg ArrowPosition(2)+marg ArrowSize 0],...
    'color','k');
Arrowy=annotation("arrow",'Units','inches',...
    'Position',[ArrowPosition(1)+marg ArrowPosition(2)+marg 0 ArrowSize],...
    'color','k');

%% Plotting

axes(figs(2,1))
box(figs(2,1),'off')
set(gca,'XColor','none','YColor','none')

axes(figs(2,2))
box(figs(2,2),'off')
set(gca,'XColor','none','YColor','none')

% Multy Vortices Simulation

xcMultySim=floor(size(M_MultyVortexSim,1)/2);
Size=size(M_MultyVortexSim,1);
axes(figs(1,2))
plot(X_MultyVortexSim(1,:),M_MultyVortexSimFit(:,xcMultySim)*100,'Color',"#2c7fb8",'LineWidth',linewidth_curve)
hold on
plot(X_MultyVortexSim(1,:),M_MultyVortexSim(:,xcMultySim)*100,'Color',[0.9290 0.6940 0.1250],'LineWidth',linewidth_curve)
axis([X_MultyVortexSim(1,1) X_MultyVortexSim(1,end) min(M_MultyVortexSim(:))*100+min(M_MultyVortexSim(:))*100/10,max(M_MultyVortexSim(:))*100+(max(M_MultyVortexSim(:))*100/10)])
xticks([-4 0 4])
xticklabels({'-4','0','4'})
xlim([min(X_MultyVortexSim(:)) max(X_MultyVortexSim(:))])

yticks([-9 0 9])
yticklabels({'-9','0','9'})
ylim([min(M_SingleVortexSimFit(:))*100+min(M_SingleVortexSimFit(:))*100/10 max(M_SingleVortexSimFit(:))*100+max(M_SingleVortexSimFit(:))*100/10])
hold off

% single Vortex Simulation

xcSingleSim=floor(size(M_SingleVortexSim,1)/2);
Size=size(M_SingleVortexSim,1);
axes(figs(1,1))
plot(X_SingleVortexSim(1,:),M_SingleVortexSimFit(:,xcSingleSim)*100,'Color',"#2c7fb8",'LineWidth',linewidth_curve)
hold on
plot(X_SingleVortexSim(1,:),M_SingleVortexSim(:,xcSingleSim)*100,'Color',[0.9290 0.6940 0.1250],'LineWidth',0.75)
axis([X_SingleVortexSim(1,1) X_SingleVortexSim(1,end) min(M_SingleVortexSimFit(:))*100+min(M_SingleVortexSimFit(:))*100/10,max(M_SingleVortexSimFit(:))*100+(max(M_SingleVortexSimFit(:))*100/10)])
xticks([-4 0 4])
xticklabels({'-4','0','4'})
xlim([min(X_SingleVortexSim(:)) max(X_SingleVortexSim(:))])
hold off


%% only surfaces plot
newfig1=figure('NumberTitle', 'off', 'Name', 'Fit');
Position1=[0.5 0.5 width len];
clf
set(newfig1,'Units','in')
set(newfig1,'Position',Position1,'Color',[1 1 1])
[r,g,b]=Analyze_Support.Get_Gold();

for i=1:Ynum
    for j=1:Xnum
        x0=X0+spaceX*j+X_size*(j-1);
        y0=Y0+spaceY*i+Y_size*(i-1);
        posfig(i,j)={[x0 y0 X_size Y_size]};
        figs(i,j)=axes('Parent',newfig1,...
            'ZColor',fontcolor,'YColor',fontcolor,'XColor',fontcolor,...
            'LineWidth',linewidth,...
            'FontSize',fontsize,...
            'FontName',FontName,...
            'Color','none',...
            'Units','in',...
            'xticklabel',{''},...
            'xtick',[],...
            'XColor','none',...
            'colormap',[r g b],...            
            'yticklabel',{''},...
            'ytick',[],...
            'YAxisLocation','right',...
            'YColor','none',...
            'Position',posfig{i,j});
        box(figs(i,j),'off');    
        hold(figs(i,j),'all');
    end
end

% single Vortex Simulation

Size=size(M_SingleVortexSim,1);
axes(figs(2,1))
box(figs(2,1),'off')
surf(figs(2,1),rot90(M_SingleVortexSim,3))
axis(figs(2,1),[1 Size 1 Size])
axis([1 Size 1 Size min(M_MultyVortexSim(:)) max(M_MultyVortexSim(:)) min(M_MultyVortexSim(:)) max(M_MultyVortexSim(:))])

shading interp

% Multy Vortices Simulation

Size=size(M_MultyVortexSim,1);
axes(figs(2,2))
box(figs(2,2),'off')
surf(figs(2,2),rot90(M_MultyVortexSim,3))
axis(figs(2,2),[1 Size 1 Size])
axis([1 Size 1 Size min(M_MultyVortexSim(:)) max(M_MultyVortexSim(:)) min(M_MultyVortexSim(:)) max(M_MultyVortexSim(:))])

shading interp