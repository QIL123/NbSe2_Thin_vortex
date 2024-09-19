clear all
close all
clc

%%

% set figure
len=2.2; %cm
width=2.1*2-0.34; %cm

newfig=figure('NumberTitle', 'off', 'Name', 'Fit');
Position=[0.5 0.5 width len];
clf
set(newfig,'Units','in')
set(newfig,'Position',Position,'Color',[1 1 1])
fontcolor='k';
linewidth=1;
linewidth_curve=2;
fontsize=12;
FontName='Arial';

[r,g,b]=Analyze_Support.Get_Gold();

% plot a
Xnum=2; %axis in X
Ynum=1; %axis in Y
spaceX=0.05;
spaceY=0.05;
X_size=1.85;
factor=1;
Y_size=X_size*factor;
X0=0; %general offset
Y0=0;%general offset

for i=1:Ynum
    for j=1:Xnum
        x0=X0+spaceX*j+X_size*(j-1);
        y0=Y0+spaceY*i+Y_size*(i-1);
        posfig(i,j)={[x0 y0 X_size Y_size]};
        figs(i,j)=axes('Parent',newfig,...
            'box','on',...
            'ZColor',fontcolor,'YColor',fontcolor,'XColor',fontcolor,...
            'LineWidth',linewidth,...
            'FontSize',fontsize,...
            'FontName',FontName,...
            'Units','in',...
            'xticklabel',{''},...
            'xtick',[],...
            'XColor','none',...
            'colormap',[r g b],...
            'yticklabel',{''},...
            'ytick',[],...
            'YColor','none',...
            'Position',posfig{i,j});
        box(figs(i,j),'off');    
        hold(figs(i,j),'all');
    end
end
posfig(1,3)={[width-X_size*0.3-0.06 y0+Y_size+0.03 X_size*0.3 Y_size*0.05]};
figs(1,3)=axes('Parent',newfig,...
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
    'YColor','none',...
    'Position',posfig{1,3});
box(figs(1,3),'off');    
hold(figs(1,3),'all');

posfig(1,4)={[width/2-X_size*0.3-0.02 y0+Y_size+0.03 X_size*0.3 Y_size*0.05]};
figs(1,4)=axes('Parent',newfig,...
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
    'YColor','none',...
    'Position',posfig{1,4});
box(figs(1,4),'off');    
hold(figs(1,4),'all');


%% loading Data

TipResponse=6.586e-3;%Sample 1
DC_channel=2;%1 for forward 2 for backward
TF_x_channel=4; 
TF_y_channel=6;
LIA_sensitivity=5e-4; %in Volts
peak=[1.9683 2.0317];
r=0.8;
imagesize=2.4;

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

[Real_Space_Ocillation_Y,TFAmplitudeLowerBound,TFAmplitudeUpperBound,Min]=get_tip_vibration_And_Errors(DataDC,DataTFy,DataTFx,x,y);

Real_Space_Ocillation_Y=Real_Space_Ocillation_Y*1e6;

MTF=Min./(Real_Space_Ocillation_Y*TipResponse);%option to add minus sine if neede
TF_Amplitude=Real_Space_Ocillation_Y;
MDC=DataDC./TipResponse;
NumberOfWantedPixcels=imagesize/pixsize;

NumberOfWantedPixcels=ceil(NumberOfWantedPixcels);

[~,xcut]=min(abs(X(1,:)-peak(1)));
[~,ycut]=min(abs(Y(:,1)-peak(2)));

D=32;
er=1
while er & D>0
try
X=X(ycut-D:ycut+D,xcut-D:xcut+D);
Y=Y(ycut-D:ycut+D,xcut-D:xcut+D);
MDC=MDC(ycut-D:ycut+D,xcut-D:xcut+D);
MTF=MTF(ycut-D:ycut+D,xcut-D:xcut+D);
er=0;
catch
    D=D-1;
end
end

R=r+0.005; %[um]
R2=r-0.05; %[um]
sel=X*0;

sel=sel+((peak(1)-X).^2+(peak(2)-Y).^2<R^2);
% substract plane
backDC=fit([X(sel==0),Y(sel==0)],MDC(sel==0),'poly11');
MDC=MDC-backDC(X,Y);

backTF=fit([X(sel==0),Y(sel==0)],MTF(sel==0),'poly11');
MTF=MTF-backTF(X,Y);

%%

NumberOfPixelsToCut=(size(sel,1)-NumberOfWantedPixcels)/2;

MDC=MDC(1+NumberOfPixelsToCut:end-NumberOfPixelsToCut,1+NumberOfPixelsToCut:end-NumberOfPixelsToCut);
MTF=MTF(1+NumberOfPixelsToCut:end-NumberOfPixelsToCut,1+NumberOfPixelsToCut:end-NumberOfPixelsToCut);
X=X(1+NumberOfPixelsToCut:end-NumberOfPixelsToCut,1+NumberOfPixelsToCut:end-NumberOfPixelsToCut);
Y=Y(1+NumberOfPixelsToCut:end-NumberOfPixelsToCut,1+NumberOfPixelsToCut:end-NumberOfPixelsToCut);
sel=sel(1+NumberOfPixelsToCut:end-NumberOfPixelsToCut,1+NumberOfPixelsToCut:end-NumberOfPixelsToCut);


axes(figs(1,1))
box(figs(1,1),'off')
surf(figs(1,1),X,Y,rot90(-MDC,3))
shading interp
axis square
DeltaMDC=max(MDC(:))-min(MDC(:));



axes(figs(1,2))
box(figs(1,2),'off')
surf(figs(1,2),X,Y,rot90(MTF,3))
shading interp
axis square
DeltaMTF=max(MTF(:))-min(MTF(:));


axes(figs(1,3))
box(figs(1,3),'on')
colorbar=[0 10;0 10];
surf(figs(1,3),colorbar)
view(2)
shading interp

axes(figs(1,4))
box(figs(1,4),'on')
surf(figs(1,4),colorbar)
view(2)
shading interp
%% ploting scale bar

ScaleLength=0.5; %in um
marg=0.1;
W=0.04; %width of scale bar in inch

%  Layers
% figPos=posfig{1,1};
% ScaleLengthPx=ScaleLength/pixsize;
% ScaleLengthIn=ScaleLengthPx*(X_size/size(X,1));
% ScalePosition=[figPos(1)+marg*2.5 figPos(2)+marg ScaleLengthIn W];
% hThin = annotation('rectangle','Units','inches',...
%     'Position',ScalePosition,...
%     'color','none','FaceColor',"w");

% textScaleBar=annotation("textbox",'Position',[0.05 0.25 0 0],'String','0.5({\mum})')
% textScaleBar.FontSize=fontsize;
mar=0.13;
% c=text(figs(1,1),mar,Y_size-mar,'a','Units','in','Color',"w",'FontSize',12,'FontName',FontName);
% e=text(figs(1,2),mar,Y_size-mar,'b','Units','in','Color',"w",'FontSize',12,'FontName',FontName);
%textScaleBar=text(figs(1,1),mar,2*mar,'0.5({\mum})','Units','in','Color',"w",'FontSize',8,'FontName',FontName);
% textScolormap1=text(figs(1,1),X_size-mar*3,Y_size+mar*1.5,strcat(num2str(round(DeltaMDC,1)*100),' {\mu}T'),'Units','in','Color','k','FontSize',8,'FontName',FontName);
% textScolormap2=text(figs(1,2),X_size-mar*3.3,Y_size+mar*1.5,strcat(num2str(round(DeltaMTF,1)*100),' T/m'),'Units','in','Color','k','FontSize',8,'FontName',FontName);
% 

