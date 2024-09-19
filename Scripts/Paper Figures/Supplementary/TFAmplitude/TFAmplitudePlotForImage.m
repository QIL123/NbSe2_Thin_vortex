% Figure - Fits and deferent images
clear
close all


% set figure
len=6.2; %cm
width=5; %cm

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
Xnum=1; %axis in X
Ynum=3; %axis in Y
% spaceX=(width-Xnum*X_size)/(Xnum+1);
% spaceY=(len-Ynum*Y_size)/(Ynum+1);
spaceX=0.1;
spaceY=0.4;
X_size=width/Xnum-spaceX-0.4;
factor=1;
Y_size=X_size/3;
X0=0.1; %general offset
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


for i=1:3
    posfig(i+3,1)={[X0+spaceX+X_size-0.25*X_size Y0+spaceY*i+Y_size*0.02+Y_size*i X_size*0.25 Y_size*0.08]};
    figs(i+3,1)=axes('Parent',newfig,...
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
        'Position',posfig{i+3,1});
    box(figs(i+3,1),'on');    
    hold(figs(i+3,1),'all');
end

%% Text
mar=0.13; %margin
%Titles
Bz=text(figs(3,1),0.1,Y_size+1.2*mar,'{B_z}(x,y)','Units','in','Color',[0 0 0],'FontSize',12,'FontName',FontName);
dbzdx=text(figs(2,1),0.1,Y_size+1.2*mar,'d{B_z}(x,y)/dx','Units','in','Color',[0 0 0],'FontSize',12,'FontName',FontName);
Bac=text(figs(1,1),0.1,Y_size+1.2*mar,'{{B^{ac}_z}}(x,y)/{x_{ac}}','Units','in','Color',[0 0 0],'FontSize',12,'FontName',FontName);

% letters
e=text(figs(1,1),mar,Y_size-mar,'c','Units','in','Color','w','FontSize',12,'FontName',FontName);
f=text(figs(2,1),mar,Y_size-mar,'b','Units','in','Color','w','FontSize',12,'FontName',FontName);
g=text(figs(3,1),mar,Y_size-mar,'a','Units','in','Color','w','FontSize',12,'FontName',FontName);

% color bar scale
scalee=text(figs(3,1),X_size*(1-0.17),Y_size+0.25,'67 {\muT}','Units','in','Color','k','FontSize',10,'FontName',FontName);
scalef=text(figs(2,1),X_size*(1-0.17),Y_size+0.25,'24 T\m','Units','in','Color','k','FontSize',10,'FontName',FontName);
scaleg=text(figs(1,1),X_size*(1-0.17),Y_size+0.25,'24 T\m','Units','in','Color','k','FontSize',10,'FontName',FontName);

% x and y arrows
XLabelePanele=text(figs(1,1),0.5,0.18,'x','Units','in','Color','w','FontSize',12,'FontName',FontName);
YLabelePanele=text(figs(1,1),0.13,0.63,'y','Units','in','Color','w','FontSize',12,'FontName',FontName);

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

TFDcData=TFDcData-min(TFDcData(:));
TFDCDerive=(TFDCDerive-mean(TFDCDerive(:)));
TFACData=(TFACData-mean(TFACData(:)))/TFAmplitude;


TFDcData=rot90(TFDcData,1);
TFDCDerive=rot90(TFDCDerive,1);
TFACData=rot90(TFACData,1);

%% Plot

% DC

axes(figs(3,1))
surf(figs(3,1),-TFDcData)
view(2)
shading flat
axis([0 96 0 32 min(-TFDcData(:)) max(-TFDcData(:)) min(-TFDcData(:)) max(-TFDcData(:))])
% DC Derive

axes(figs(2,1))
surf(figs(2,1),-TFDCDerive)
view(2)
shading flat
axis([0 96 0 32 min(-TFACData(:)) max(-TFACData(:)) min(-TFACData(:)) max(-TFACData(:))])

%  TF
axes(figs(1,1))
surf(figs(1,1),-TFACData)
view(2)
shading flat
axis([0 96 0 32 min(-TFACData(:)) max(-TFACData(:)) min(-TFACData(:)) max(-TFACData(:))])

%ColorBar
for i=1:3
    axes(figs(i+3,1))
    colorbar=[0 10;0 10];
    surf(figs(i+3,1),colorbar)
    view(2)
    shading interp
end

%% Scales
ScaleLength=5; %in um
marg=0.1;
W=0.05; %width of scale bar in inch

% 3 Layers
figPos=posfig{2,1};
pixelsize=X(1,2)-X(1,1);
ScaleLengthPx=ScaleLength/pixelsize;
ScaleLengthIn=ScaleLengthPx*(X_size/size(X,1));
ScalePosition=[figPos(1)+marg figPos(2)+marg ScaleLengthIn W];
hThin = annotation('rectangle','Units','inches',...
    'Position',ScalePosition,...
    'color','none','FaceColor','w');

textScaleBar=text(figs(2,1),0.28,0+2*mar,'4 {\mu}m','Units','in','Color','w','FontSize',10,'FontName',FontName);


%% XY Arrows

ArrowPosition=posfig{1,1};
ArrowSize=0.35;

Arrowx=annotation("arrow",'Units','inches',...
    'Position',[ArrowPosition(1)+marg*1.5 ArrowPosition(2)+marg*1.5 ArrowSize 0],...
    'color','w');
Arrowy=annotation("arrow",'Units','inches',...
    'Position',[ArrowPosition(1)+marg*1.5 ArrowPosition(2)+marg*1.5 0 ArrowSize],...
    'color','w');