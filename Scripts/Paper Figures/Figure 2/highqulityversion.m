% Figure - Fits and deferent images
clear
close all


% set figure
len=5.3; %cm
width=7; %cm

newfig=figure('NumberTitle', 'off', 'Name', 'Fit');
Position=[0.5 0.5 width len];
clf
set(newfig,'Units','in')
set(newfig,'Position',Position,'Color',[1 1 1])
fontcolor='k';
linewidth=1;
linewidth_curve=1.25;
fontsize=10;
FontName='Arial';
Multiplyer3Layer=6;
%Multiplyer6Layer=2;

[r,g,b]=Analyze_Support.Get_Gold();


% plot a
Xnum=4; %axis in X
Ynum=3; %axis in Y
% spaceX=(width-Xnum*X_size)/(Xnum+1);
% spaceY=(len-Ynum*Y_size)/(Ynum+1);
spaceX=0.03;
spaceY=0.03;
X_size=width/Xnum-spaceX-0.2;
factor=1;
Y_size=X_size*factor;
X0=0.2; %general offset
Y0=0.4;%general offset
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
Layer14=text(figs(3,4),0,Y_size+mar,'N=14','Units','in','Color',[0 0 0],'FontSize',10,'FontName',FontName);
Layer7=text(figs(3,3),0,Y_size+mar,'N=7','Units','in','Color',[0 0 0],'FontSize',10,'FontName',FontName);
Layer5=text(figs(3,2),0,Y_size+mar,'N=6','Units','in','Color',[0 0 0],'FontSize',10,'FontName',FontName);
Layer3=text(figs(3,1),0,Y_size+mar,'N=3','Units','in','Color',[0 0 0],'FontSize',10,'FontName',FontName);
CrossSectionXaxis14=text(figs(1,4),mar*3.5,-mar*2.5,'x ({\mum})','Units','in','Color',[0 0 0],'FontSize',10,'FontName',FontName);
CrossSectionXaxis7=text(figs(1,3),mar*3.5,-mar*2.5,'x ({\mum})','Units','in','Color',[0 0 0],'FontSize',10,'FontName',FontName);
CrossSectionXaxis6=text(figs(1,2),mar*3.5,-mar*2.5,'x ({\mum})','Units','in','Color',[0 0 0],'FontSize',10,'FontName',FontName);
CrossSectionXaxis3=text(figs(1,1),mar*3.5,-mar*2.5,'x ({\mum})','Units','in','Color',[0 0 0],'FontSize',10,'FontName',FontName);
CrossSectionMultiplyer3=text(figs(1,1),mar*1.5,mar*5,strcat('X',num2str(Multiplyer3Layer)),'Units','in','Color','k','FontSize',12,'FontName',FontName);
%CrossSectionMultiplyer6=text(figs(1,2),mar*1.5,mar*5,strcat('X',num2str(Multiplyer6Layer)),'Units','in','Color','k','FontSize',12,'FontName',FontName);

Data_txt=text(figs(3,1),-mar,0,'Data','Units','in','Rotation',90,'Color',[0 0 0],'FontSize',9,'FontName',FontName);
Model_Fit_txt=text(figs(2,1),-mar,0,'Model','Units','in','Rotation',90,'Color',[0 0 0],'FontSize',9,'FontName',FontName);
Cross_Section=text(figs(1,1),-mar,0,'Cross Section','Units','in','Rotation',90,'Color',[0 0 0],'FontSize',9,'FontName',FontName);
CrossSectionYaxis=text(figs(1,4),X_size+mar*2.5,1.625*mar,'{B^{ac}_z}(h,x)/{x_{ac}} (T/m)','Units','in','Rotation',90,'Color',[0 0 0],'FontSize',10,'FontName',FontName);


% letters

a=text(figs(3,1),mar,Y_size-mar,'a','Units','in','Color','w','FontSize',10,'FontName',FontName);
b=text(figs(3,2),mar,Y_size-mar,'b','Units','in','Color','w','FontSize',10,'FontName',FontName);
c=text(figs(3,3),mar,Y_size-mar,'c','Units','in','Color','w','FontSize',10,'FontName',FontName);
d=text(figs(3,4),mar,Y_size-mar,'d','Units','in','Color','w','FontSize',10,'FontName',FontName);
e=text(figs(2,1),mar,Y_size-mar,'e','Units','in','Color','w','FontSize',10,'FontName',FontName);
f=text(figs(2,2),mar,Y_size-mar,'f','Units','in','Color','w','FontSize',10,'FontName',FontName);
g=text(figs(2,3),mar,Y_size-mar,'g','Units','in','Color','w','FontSize',10,'FontName',FontName);
h=text(figs(2,4),mar,Y_size-mar,'h','Units','in','Color','w','FontSize',10,'FontName',FontName);
i=text(figs(1,1),mar,Y_size-mar,'i','Units','in','Color','k','FontSize',10,'FontName',FontName);
j=text(figs(1,2),mar,Y_size-mar,'j','Units','in','Color','k','FontSize',10,'FontName',FontName);
k=text(figs(1,3),mar,Y_size-mar,'k','Units','in','Color','k','FontSize',10,'FontName',FontName);
l=text(figs(1,4),mar,Y_size-mar,'l','Units','in','Color','k','FontSize',10,'FontName',FontName);

XLabelePanele=text(figs(2,1),0.43,0.13,'x','Units','in','Color','w','FontSize',10,'FontName',FontName);
YLabelePanele=text(figs(2,1),0.07,0.54,'y','Units','in','Color','w','FontSize',10,'FontName',FontName);

PearlLength14=text(figs(1,4),0.5*mar,1.5*mar,'{\Lambda}=12 {\mum}','Units','in','Color',[0 0 0],'FontSize',10,'FontName',FontName);
PearlLength7=text(figs(1,3),0.5*mar,1.5*mar,'{\Lambda}=30 {\mum}','Units','in','Color',[0 0 0],'FontSize',10,'FontName',FontName);
PearlLength6=text(figs(1,2),0.5*mar,1.5*mar,'{\Lambda}=101 {\mum}','Units','in','Color',[0 0 0],'FontSize',10,'FontName',FontName);
PearlLength3=text(figs(1,1),0.5*mar,1.5*mar,'{\Lambda}=111 {\mum}','Units','in','Color',[0 0 0],'FontSize',10,'FontName',FontName);
%% loading data
load('Paper Figures\Figure 2\SaveplotData14Layers.mat')
Data14layers=plotData14Layers{1};
Model14Layers=plotData14Layers{2};
X14Layers=plotData14Layers{3};
CrossSection14Layers=plotData14Layers{5};
CrossSectionModel14Layers=plotData14Layers{6};

load('Paper Figures\Figure 2\SaveplotData7Layers.mat')
Data7layers=plotData7Layers{1};
Model7Layers=plotData7Layers{2};
X7Layers=plotData7Layers{3};
CrossSection7Layers=plotData7Layers{5};
CrossSectionModel7Layers=plotData7Layers{6};

load('Paper Figures\Figure 2\SaveplotData6Layers.mat')
Data6layers=plotData6Layers{1};
Model6Layers=plotData6Layers{2};
X6Layers=plotData6Layers{3};
CrossSection6Layers=plotData6Layers{5};
CrossSectionModel6Layers=plotData6Layers{6};

load('Paper Figures\Figure 2\SaveplotData3Layers.mat')
Data3layers=plotData3Layers{1};
Model3Layers=plotData3Layers{2};
X3Layers=plotData3Layers{3};
CrossSection3Layers=plotData3Layers{5};
CrossSectionModel3Layers=plotData3Layers{6};

PearlLengths=[plotData3Layers{4} plotData6Layers{4} plotData7Layers{4} plotData14Layers{4}];

load('Paper Figures\Figure 2\SaveSensitivityplot3Layers.mat')
Model94=plotSensitivity3Layers{1};
Model128=plotSensitivity3Layers{2};
CrossSectionModel94Layers=Model94(:,23);
CrossSectionModel128Layers=Model128(:,23);

xsize(1)=X3Layers(1,end)-X3Layers(1,1);
xsize(2)=X6Layers(1,end)-X6Layers(1,1);
xsize(3)=X7Layers(1,end)-X7Layers(1,1);
xsize(4)=X14Layers(1,end)-X14Layers(1,1);

xcut3=xsize(1)-min(xsize);
xcut6=xsize(2)-min(xsize);
xcut7=xsize(3)-min(xsize);
xcut14=xsize(4)-min(xsize);

numofpixcelcut3=floor(((xcut3)/(X3Layers(1,2)-X3Layers(1,1)))/2);
numofpixcelcut6=floor(((xcut6)/(X6Layers(1,2)-X6Layers(1,1)))/2);
numofpixcelcut7=floor(((xcut7)/(X7Layers(1,2)-X7Layers(1,1)))/2);
numofpixcelcut14=floor(((xcut14)/(X14Layers(1,2)-X14Layers(1,1)))/2);

Data3layers=Data3layers(1+numofpixcelcut3:end-numofpixcelcut3,1+numofpixcelcut3:end-numofpixcelcut3);
Data6layers=Data6layers(1+numofpixcelcut6:end-numofpixcelcut6,1+numofpixcelcut6:end-numofpixcelcut6);
Data7layers=Data7layers(1+numofpixcelcut7:end-numofpixcelcut7,1+numofpixcelcut7:end-numofpixcelcut7);
Data14layers=Data14layers(1+numofpixcelcut14:end-numofpixcelcut14,1+numofpixcelcut14:end-numofpixcelcut14);

Model3Layers=Model3Layers(1+numofpixcelcut3:end-numofpixcelcut3,1+numofpixcelcut3:end-numofpixcelcut3);
Model6Layers=Model6Layers(1+numofpixcelcut6:end-numofpixcelcut6,1+numofpixcelcut6:end-numofpixcelcut6);
Model7Layers=Model7Layers(1+numofpixcelcut7:end-numofpixcelcut7,1+numofpixcelcut7:end-numofpixcelcut7);
Model14Layers=Model14Layers(1+numofpixcelcut14:end-numofpixcelcut14,1+numofpixcelcut14:end-numofpixcelcut14);

X3Layers=X3Layers-mean(X3Layers(1,:));
X6Layers=X6Layers-mean(X6Layers(1,:));
X7Layers=X7Layers-mean(X7Layers(1,:));
X14Layers=X14Layers-mean(X14Layers(1,:));

X3Layers1=X3Layers(1+numofpixcelcut3:end-numofpixcelcut3,1+numofpixcelcut3:end-numofpixcelcut3);
X6Layers1=X6Layers(1+numofpixcelcut6:end-numofpixcelcut6,1+numofpixcelcut6:end-numofpixcelcut6);
X7Layers1=X7Layers(1+numofpixcelcut7:end-numofpixcelcut7,1+numofpixcelcut7:end-numofpixcelcut7);
X14Layers1=X14Layers(1+numofpixcelcut14:end-numofpixcelcut14,1+numofpixcelcut14:end-numofpixcelcut14);

CrossSection3Layers=CrossSection3Layers-mean(CrossSection3Layers);
CrossSection6Layers=CrossSection6Layers-mean(CrossSection6Layers);
CrossSection7Layers=CrossSection7Layers-mean(CrossSection7Layers);
CrossSection14Layers=CrossSection14Layers-mean(CrossSection14Layers);

CrossSectionModel3Layers=CrossSectionModel3Layers-mean(CrossSectionModel3Layers);
CrossSectionModel6Layers=CrossSectionModel6Layers-mean(CrossSectionModel6Layers);
CrossSectionModel7Layers=CrossSectionModel7Layers-mean(CrossSectionModel7Layers);
CrossSectionModel14Layers=CrossSectionModel14Layers-mean(CrossSectionModel14Layers);

SurfaceMatrix={rot90(Data14layers,3) rot90(Model14Layers,3) rot90(Data7layers,3) rot90(Model7Layers,3) rot90(Data6layers,3) rot90(Model6Layers,3) rot90(Data3layers,3) rot90(Model3Layers,3)}

%% Plot
ModelColor='#eeb429';
DataColor='#67290f';
% 14 Layers

Size=size(Data14layers,1);
axes(figs(3,4))
set(gca,'XColor','none','YColor','none')
box(figs(3,4),'off')

% surf(figs(3,4),rot90(Data14layers,3))
% axis(figs(3,4),[1 Size 1 Size])
% axis([1 Size 1 Size min(Model14Layers(:)) max(Data14layers(:)) min(Model14Layers(:)) max(Data14layers(:))])
% shading interp

%DeltaXaxis14=text(figs(3,4),mar*3,Y_size-mar*1,strcat(num2str(round(Delta14Layers,2)),'(G/{\mum})'),'Units','in','Color',[0 0 0],'FontSize',12,'FontName',FontName);

axes(figs(2,4))
set(gca,'XColor','none','YColor','none')
box('off')
% surf(rot90(Model14Layers,3))
% axis([1 Size 1 Size])
% %axis([1 Size 1 Size min(Model14Layers(:)) max(Data14layers(:)) min(Model14Layers(:)) max(Data14layers(:))])
% shading interp

axes(figs(1,4))
% plot(X14Layers(1,:)-0.15*(X14Layers(1,2)-X14Layers(1,1)),CrossSection14Layers,'Color',"#662506",'LineWidth',linewidth_curve)
% hold on
% plot(X14Layers(1,:),CrossSectionModel14Layers,'Color',[0.9290 0.6940 0.1250],'LineWidth',linewidth_curve)
plot(X14Layers(1,:)-0.15*(X14Layers(1,2)-X14Layers(1,1)),CrossSection14Layers,'Color',DataColor,'LineWidth',linewidth_curve)
hold on
plot(X14Layers(1,:),CrossSectionModel14Layers,'Color',ModelColor,'LineWidth',linewidth_curve)
axis([X14Layers1(1,1) X14Layers1(1,end) min(Model14Layers(:)),max(Model14Layers(:))+(max(Model14Layers(:))/10)])
%axis([X14Layers(1,1) X14Layers(1,end) min(Model14Layers(:)),max(Model14Layers(:))+(max(Model14Layers(:))/10)])
xticks([-1 0 1])
xticklabels({'-1','0','1'})
xlim([min(X6Layers1(:)) max(X6Layers1(:))])



yticks([round(min(Model14Layers(:)),1) 0 round(max(Model14Layers(:)),1)])
yticklabels({num2str(round(min(Model14Layers(:)),1)*100),'0',num2str(round(max(Model14Layers(:)),1)*100)})
ylim([min(Model14Layers(:))+min(Model14Layers(:))/10 max(Model14Layers(:))+max(Model14Layers(:))/10])
hold off

% 7 Layers

Size=size(Data7layers,1);
axes(figs(3,3))
set(gca,'XColor','none','YColor','none')
box(figs(3,3),'off')
% surf(figs(3,3),rot90(Data7layers,3))
% axis(figs(3,3),[1 Size 1 Size])
% %axis([1 Size 1 Size min(Model7Layers(:)) max(Model7Layers(:)) min(Model7Layers(:)) max(Model7Layers(:))])
% %axis([1 Size 1 Size min(Model14Layers(:)) max(Data14layers(:)) min(Model14Layers(:)) max(Data14layers(:))])
% %DeltaXaxis7=text(figs(3,3),mar*3,Y_size-mar*1,strcat(num2str(round(Delta7Layers,2)),'(G/{\mum})'),'Units','in','Color',[0 0 0],'FontSize',12,'FontName',FontName);
% 
% shading interp

axes(figs(2,3))
set(gca,'XColor','none','YColor','none')
box('off')
% surf(rot90(Model7Layers,3))
% axis([1 Size 1 Size])
% %axis([1 Size 1 Size min(Model7Layers(:)) max(Model7Layers(:)) min(Model7Layers(:)) max(Model7Layers(:))])
% %axis([1 Size 1 Size min(Model14Layers(:)) max(Data14layers(:)) min(Model14Layers(:)) max(Data14layers(:))])
% 
% shading interp

axes(figs(1,3))
% plot(X7Layers(1,:)-0.3*(X7Layers(1,2)-X7Layers(1,1)),CrossSection7Layers,'Color',"#662506",'LineWidth',linewidth_curve)
% hold on
% plot(X7Layers(1,:),CrossSectionModel7Layers,'Color',[0.9290 0.6940 0.1250],'LineWidth',linewidth_curve)
plot(X7Layers(1,:)-0.3*(X7Layers(1,2)-X7Layers(1,1)),CrossSection7Layers,'Color',DataColor,'LineWidth',linewidth_curve)
hold on
plot(X7Layers(1,:),CrossSectionModel7Layers,'Color',ModelColor,'LineWidth',linewidth_curve)
axis([X7Layers1(1,1) X7Layers1(1,end) min(Model14Layers(:)),max(Model14Layers(:))+(max(Model14Layers(:))/10)])
xticks([-1 0 1])
xticklabels({'-1','0','1'})
xlim([min(X7Layers1(:)) max(X7Layers1(:))])
hold off

% 6 Layers

Size=size(Data6layers,1);
axes(figs(3,2))
set(gca,'XColor','none','YColor','none')
box(figs(3,2),'off')
% surf(figs(3,2),rot90(Data6layers,3))
% %surf(figs(3,2),Data6layers*Multiplyer6Layer)
% axis(figs(3,2),[1 Size 1 Size])
% %axis([1 Size 1 Size min(Data6layers(:)) max(Model6Layers(:)) min(Data6layers(:)) max(Model6Layers(:))])
% %axis([1 Size 1 Size min(Model14Layers(:)) max(Data14layers(:)) min(Model14Layers(:)) max(Data14layers(:))])
% 
% shading interp
%DeltaXaxis6=text(figs(3,2),mar*3,Y_size-mar*1,strcat(num2str(round(Delta6Layers,2)),'(G/{\mum})'),'Units','in','Color',[0 0 0],'FontSize',12,'FontName',FontName);

axes(figs(2,2))
set(gca,'XColor','none','YColor','none')
box('off')
% surf(rot90(Model6Layers,3))
% %surf(Model6Layers*Multiplyer6Layer)
% axis([1 Size 1 Size])
% 
% %axis([1 Size 1 Size min(Model6Layers(:)) max(Model6Layers(:)) min(Model6Layers(:)) max(Model6Layers(:))])
% %axis([1 Size 1 Size min(Model14Layers(:)) max(Data14layers(:)) min(Model14Layers(:)) max(Data14layers(:))])
% 
% shading interp

axes(figs(1,2))
% plot(X6Layers(1,:)-0.25*(X6Layers(1,2)-X6Layers(1,1)),CrossSection6Layers+0.01,'Color',"#662506",'LineWidth',linewidth_curve)
% hold on
% plot(X6Layers(1,:),CrossSectionModel6Layers,'Color',[0.9290 0.6940 0.1250],'LineWidth',linewidth_curve)
plot(X6Layers(1,:)-0.25*(X6Layers(1,2)-X6Layers(1,1)),CrossSection6Layers+0.01,'Color',DataColor,'LineWidth',linewidth_curve)
hold on
plot(X6Layers(1,:),CrossSectionModel6Layers,'Color',ModelColor,'LineWidth',linewidth_curve)
axis([X6Layers1(1,1) X6Layers1(1,end) min(Model14Layers(:)),max(Model14Layers(:))+(max(Model14Layers(:))/10)])
xticks([-1 0 1])
xticklabels({'-1','0','1'})
xlim([min(X6Layers1(:)) max(X6Layers1(:))])

hold off


% 3 Layers
Size=size(Data3layers,1);
axes(figs(3,1))
set(gca,'XColor','none','YColor','none')
box(figs(3,1),'off')
% surf(figs(3,1),rot90(Data3layers,3))
% %surf(figs(3,1),rot90(Data3layers*Multiplyer3Layer,3))
% axis(figs(3,1),[1 Size 1 Size])
% 
% %axis([1 Size 1 Size min(Model14Layers(:)) max(Data14layers(:)) min(Model14Layers(:)) max(Data14layers(:))])
% 
% %axis([1 Size 1 Size min(Data3layers(:)) max(Model3Layers(:)) min(Data3layers(:)) max(Model3Layers(:))])
% shading interp
%DeltaXaxis3=text(figs(3,1),mar*3,Y_size-mar*1,strcat(num2str(round(Delta3Layers,2)),'(G/{\mum})'),'Units','in','Color',[0 0 0],'FontSize',12,'FontName',FontName);

axes(figs(2,1))
set(gca,'XColor','none','YColor','none')
box('off')
% surf(rot90(Model3Layers,3))
% %surf(Model3Layers*Multiplyer3Layer)
% axis([1 Size 1 Size])
% %axis([1 Size 1 Size min(Model14Layers(:)) max(Data14layers(:)) min(Model14Layers(:)) max(Data14layers(:))])
% 
% %axis([1 Size 1 Size min(Model3Layers(:)) max(Model3Layers(:)) min(Model3Layers(:)) max(Model3Layers(:))])
% shading interp
PearlColors=["#2b2bdf" "#ff3f21"]

axes(figs(1,1))
plot(X3Layers(1,:)-0.75*(X3Layers(1,2)-X3Layers(1,1)),CrossSection3Layers*Multiplyer3Layer,'Color',DataColor,'LineWidth',linewidth_curve)
hold on
%[0.9290 0.6940 0.1250]
plot(X3Layers(1,:),CrossSectionModel94Layers(3:end-2)*Multiplyer3Layer-CrossSectionModel94Layers(1)+0.01,'Color',PearlColors(1),'LineWidth',0.9)
plot(X3Layers(1,:),CrossSectionModel128Layers(3:end-2)*Multiplyer3Layer-CrossSectionModel128Layers(3)+0.01,'Color',PearlColors(2),'LineWidth',0.9)
plot(X3Layers(1,:),CrossSectionModel3Layers*Multiplyer3Layer,'Color',ModelColor,'LineWidth',linewidth_curve)
axis([X3Layers1(1,1) X3Layers1(1,end) min(Model14Layers(:)),max(Model14Layers(:))+(max(Model14Layers(:))/10)])
xticks([-1 0 1])
xticklabels({'-1','0','1'})
xlim([min(X3Layers1(:)) max(X3Layers1(:))])
Model=text(figs(1,1),X_size-3.3*mar,Y_size-2*mar,'Model','Units','in','Color',ModelColor,'FontSize',10,'FontName',FontName);
Data=text(figs(1,1),X_size-2.7*mar,Y_size-mar,'Data','Units','in','Color',DataColor,'FontSize',10,'FontName',FontName);
Model94=text(figs(1,1),X_size-5.6*mar,Y_size-3*mar,'{\Lambda}=  94 {\mum}','Units','in','Color',PearlColors(1),'FontSize',10,'FontName',FontName);
Model128=text(figs(1,1),X_size-5.6*mar,Y_size-4*mar,'{\Lambda}=128 {\mum}','Units','in','Color',PearlColors(2),'FontSize',10,'FontName',FontName);

hold off
%% Scales
ScaleLength=0.5; %in um
marg=0.1;
W=0.04; %width of scale bar in inch

% 3 Layers
figPos=posfig{2,2};
pixelsize=X3Layers1(1,2)-X3Layers1(1,1);
ScaleLengthPx=ScaleLength/pixelsize;
ScaleLengthIn=ScaleLengthPx*(X_size/size(X3Layers1,1));
ScalePosition=[figPos(1)+marg figPos(2)+marg ScaleLengthIn W];
hThin = annotation('rectangle','Units','inches',...
    'Position',ScalePosition,...
    'color','none','FaceColor',[0.9290 0.6940 0.1250]);

textScaleBar=text(figs(2,2),0.05,0+2*mar,'500 nm','Units','in','Color',[0.9290 0.6940 0.1250],'FontSize',10,'FontName',FontName);


%% XY Arrows

ArrowPosition=posfig{2,1};
ArrowSize=0.3;

Arrowx=annotation("arrow",'Units','inches',...
    'Position',[ArrowPosition(1)+marg ArrowPosition(2)+marg ArrowSize 0],...
    'color','w');
Arrowy=annotation("arrow",'Units','inches',...
    'Position',[ArrowPosition(1)+marg ArrowPosition(2)+marg 0 ArrowSize],...
    'color','w');


%% ploting and saving each surface separatly
[r,g,b]=Analyze_Support.Get_Gold();

for i=1:8
    newfig1=figure('NumberTitle',10+i);
    Position=[0.5+i 0.5 X_size X_size];
    set(newfig1,'Units','in')
    set(newfig1,'Position',Position,'Color',[1 1 1])
    posfig(1,1)={[0 0 X_size X_size]};
    figs(1,1)=axes('Parent',newfig1,...
        'ZColor','none','YColor','none','XColor','none',...
        'Color','none',...
        'Units','in',...
        'xticklabel',{''},...
        'xtick',[],...
        'colormap',[r g b],...            
        'yticklabel',{''},...
        'ytick',[],...
        'Position',posfig{1,1});
    box(figs(1,1),'off');    
    hold(figs(1,1),'all');
    surf(SurfaceMatrix{i})
    Size=size(SurfaceMatrix{i},1)
    axis(figs(1,1),[1 Size 1 Size])
    data=SurfaceMatrix{i};
    axis([1 Size 1 Size min(data(:)) max(data(:)) min(data(:)) max(data(:))])
    shading interp
    imagewd = gcf;
    figname=sprintf('C:/Users/Owner/Dropbox/QIL papers/NbSe2_thin vortex/Figures/finel versions/paper/Figure 3/panel%s.tiff',num2str(i))
    exportgraphics(imagewd,figname,'Resolution',300)
end

