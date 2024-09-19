% Figure - Fits and deferent images
clear
close all


% set figure
len=2.5; %cm
width=7; %cm

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
DataColor=[0.9290 0.6940 0.1250];
FitColor="#0072BD";

[r,g,b]=Analyze_Support.Get_Gold();


% plot a
Xnum=3; %axis in X
Ynum=1; %axis in Y
% spaceX=(width-Xnum*X_size)/(Xnum+1);
% spaceY=(len-Ynum*Y_size)/(Ynum+1);
spaceX=0.1;
spaceY=0.1;
X_size=width/Xnum-spaceX-0.2;
factor=1;
Y_size=X_size;
X0=0.2; %general offset
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
            'Units','in',....
            'xticklabel',{''},...
            'xtick',[],...
            'XColor','none',...            
            'yticklabel',{''},...
            'ytick',[],...
            'YColor','none',...            
            'colormap',[r g b],...            
            'YAxisLocation','left',...
            'Position',posfig{i,j});
        box(figs(i,j),'on');    
        hold(figs(i,j),'all');
    end
end


for i=1:Xnum
    posfig(1,i+3)={[X0+spaceX*i+i*X_size-0.3*X_size Y0+spaceY*1.1+Y_size*1 X_size*0.3 Y_size*0.05]};
    figs(1,i+3)=axes('Parent',newfig,...
        'ZColor',fontcolor,'YColor',fontcolor,'XColor',fontcolor,...
        'LineWidth',linewidth,...
        'FontSize',fontsize,...
        'FontName',FontName,...
        'Color','none',...
        'Units','in',...
        'xticklabel',{''},...
        'xtick',[],...
        'XColor','none',...
        'YColor','none',...            
        'colormap',[r g b],...
        'yticklabel',{''},...
        'ytick',[],...
        'Position',posfig{1,i+3});
    box(figs(1,i+3),'on');    
    hold(figs(1,i+3),'all');
end

%% Text
mar=0.13; %margin
%Titles
Bz=text(figs(1,1),0,Y_size+1.2*mar,'{B_z}(x,y)','Units','in','Color',[0 0 0],'FontSize',12,'FontName',FontName);
dbzdx=text(figs(1,2),0,Y_size+1.2*mar,'d{B_z}(x,y)/dx','Units','in','Color',[0 0 0],'FontSize',12,'FontName',FontName);
Bac=text(figs(1,3),0,Y_size+1.2*mar,'{{B^{ac}_z}}(x,y)/{x_{ac}}','Units','in','Color',[0 0 0],'FontSize',12,'FontName',FontName);

% letters
e=text(figs(1,1),mar,Y_size-mar,'a','Units','in','Color','w','FontSize',12,'FontName',FontName);
f=text(figs(1,2),mar,Y_size-mar,'b','Units','in','Color','w','FontSize',12,'FontName',FontName);
g=text(figs(1,3),mar,Y_size-mar,'c','Units','in','Color','w','FontSize',12,'FontName',FontName);

% color bar scale
scalee=text(figs(1,1),X_size*(1-0.3),Y_size+0.2,'30 {\muT}','Units','in','Color','k','FontSize',10,'FontName',FontName);
scalef=text(figs(1,2),X_size*(1-0.3),Y_size+0.2,'60 T\m','Units','in','Color','k','FontSize',10,'FontName',FontName);
scaleg=text(figs(1,3),X_size*(1-0.3),Y_size+0.2,'60 T\m','Units','in','Color','k','FontSize',10,'FontName',FontName);

% x and y arrows
XLabelePanele=text(figs(1,1),0.43,0.13,'x','Units','in','Color','w','FontSize',12,'FontName',FontName);
YLabelePanele=text(figs(1,1),0.07,0.54,'y','Units','in','Color','w','FontSize',12,'FontName',FontName);

%% loading data

%TF Amplitude
TipResponse=6.586e-3/100; %V/muT
load('Paper Figures\Supplementary\TFAmplitude\SaveTFAmpltideDataFigure.mat','TFAmpltideData')
TFDcData=TFAmpltideData{1}/TipResponse; %100 to turn into muT units and 1e6 to turn from nm to mum
TFDCDerive=TFAmpltideData{2}/(TipResponse*1e6);
TFACData=TFAmpltideData{3}/TipResponse;
X=TFAmpltideData{4}-min(min(TFAmpltideData{4}));
Y=TFAmpltideData{5}-min(min(TFAmpltideData{5}));
TFAmplitude=TFAmpltideData{6}*1e6;

% cut to 32*32 pixcells
m=5; %the pixcell I chose to cut from
TFDcDataPlot=-rot90(TFDcData,1);
TFDcDataPlot=TFDcDataPlot-min(TFDcDataPlot(:));
%Exclusion area
r=1.2;
R=r+0.005; %[um]
R2=r-0.05; %[um]
sel=X*0;
xEx=1.9683;
yEx=2.0317;
sel=sel+((xEx-X).^2+(yEx-Y).^2<R^2);
% substract plane
backDC=fit([X(sel==0),Y(sel==0)],TFDcDataPlot(sel==0),'poly11');
TFDcDataPlot=TFDcDataPlot-backDC(X,Y);
TFDcDataPlot=TFDcDataPlot(14:14+37,15:15+37);

TFDCDerivePlot=-rot90(TFDCDerive,1);
TFDCDerivePlot=TFDCDerivePlot-mean(TFDCDerivePlot(:));
TFDCDerivePlot=TFDCDerivePlot(14:14+37,15:15+37);

TFACDataPlot=-rot90(TFACData,1)/TFAmplitude;
TFACDataPlot=TFACDataPlot-mean(TFACDataPlot(:));
TFACDataPlot=TFACDataPlot(14:14+37,15:15+37);

X=X(1:38,1:38);
Y=Y(1:38,1:38);
%% Plot

% DC

axes(figs(1,1))
%surf(figs(1,1),X,Y,TFDcDataPlot)
%view(2)
%shading interp
%axis([0 X(1,end) 0 Y(end,end) min(TFDcDataPlot(:)) max(TFDcDataPlot(:)) min(TFDcDataPlot(:)) max(TFDcDataPlot(:))])
% DC Derive

axes(figs(1,2))
%surf(figs(1,2),X,Y,TFDCDerivePlot)
%view(2)
%shading interp
%axis([0 X(1,end) 0 Y(end,end) min(TFACDataPlot(:)) max(TFACDataPlot(:)) min(TFACDataPlot(:)) max(TFACDataPlot(:))])

%  TF
axes(figs(1,3))
%surf(figs(1,3),X,Y,TFACDataPlot)
%view(2)
%shading interp
%axis([0 X(1,end) 0 Y(end,end) min(TFACDataPlot(:)) max(TFACDataPlot(:)) min(TFACDataPlot(:)) max(TFACDataPlot(:))])

%ColorBar
for i=1:3
    axes(figs(1,i+3))
    box(figs(1,5),'on')
    colorbar=[0 10;0 10];
    %surf(figs(1,i+3),colorbar)
    view(2)
    shading interp
end

%% Scales
ScaleLength=0.5; %in um
marg=0.1;
W=0.04; %width of scale bar in inch

% 3 Layers
figPos=posfig{1,2};
pixelsize=X(1,2)-X(1,1);
ScaleLengthPx=ScaleLength/pixelsize;
ScaleLengthIn=ScaleLengthPx*(X_size/size(X,1));
ScalePosition=[figPos(1)+marg figPos(2)+marg ScaleLengthIn W];
hThin = annotation('rectangle','Units','inches',...
    'Position',ScalePosition,...
    'color','none','FaceColor','w');

textScaleBar=text(figs(1,2),0.075,0+2*mar,'500 nm','Units','in','Color','w','FontSize',10,'FontName',FontName);


%% XY Arrows

ArrowPosition=posfig{1,1};
ArrowSize=0.3;

Arrowx=annotation("arrow",'Units','inches',...
    'Position',[ArrowPosition(1)+marg ArrowPosition(2)+marg ArrowSize 0],...
    'color','w');
Arrowy=annotation("arrow",'Units','inches',...
    'Position',[ArrowPosition(1)+marg ArrowPosition(2)+marg 0 ArrowSize],...
    'color','w');