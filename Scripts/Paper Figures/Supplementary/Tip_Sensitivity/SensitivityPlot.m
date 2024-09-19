% Figure - Thick Vortices Fits and unavailable Fits
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
linewidth_curve=1;
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

Layer3=text(figs(1,1),0,Y_size+mar,'Cross Section N=3','Units','in','Color',[0 0 0],'FontSize',10.5,'FontName',FontName);
xaxis=text(figs(1,1),mar*4.5,-mar*2.5,'x ({\mum})','Units','in','Color',[0 0 0],'FontSize',10.5,'FontName',FontName);
Yaxis=text(figs(1,1),-mar*3,mar*2.5,'{B_{ac}}(x,y)/{x_{ac}} (T/m)','Units','in','Rotation',90,'Color',[0 0 0],'FontSize',10.5,'FontName',FontName);
c=text(figs(1,1),mar,Y_size-mar,'c','Units','in','Color','k','FontSize',12,'FontName',FontName);

%% loading data

% load('Paper Figures\Supplementary\Tip_Sensitivity\SaveSuppData6Layers.mat')
% Data6layers=SuppData6Layers{1};
% Model6Layers=SuppData6Layers{2};
% X6Layers=SuppData6Layers{3};
% PearlLength6=SuppData6Layers{4};

load('Paper Figures\Supplementary\Tip_Sensitivity\SensitivityPlotData.mat')
Data3layers=SensitivityPlotData{1};
Model3Layers=SensitivityPlotData{2};
X3Layers=SensitivityPlotData{3};
PearlLength3=SensitivityPlotData{5};
PearlLengthBottom3=SensitivityPlotData{6};
PearlLengthUpper3=SensitivityPlotData{7};


xsize(1)=X3Layers(1,end)-X3Layers(1,1);
% xsize(2)=X6Layers(1,end)-X6Layers(1,1);

xcut3=xsize(1)-min(xsize);
%xcut6=xsize(2)-min(xsize);

pixsize3Layers=X3Layers(1,2)-X3Layers(1,1);
% pixsize6Layers=X6Layers(1,2)-X6Layers(1,1);

numofpixcelcut3=floor((xcut3/pixsize3Layers)/2);
% numofpixcelcut6=floor((xcut6/pixsize6Layers)/2);

% Data3layers=Data3layers(1+numofpixcelcut3:end-numofpixcelcut3,1+numofpixcelcut3:end-numofpixcelcut3);
% %Delta3Layers=max(Data3layers(:))-min(Data3layers(:));
% Data6layers=Data6layers(1+numofpixcelcut6:end-numofpixcelcut6,1+numofpixcelcut6:end-numofpixcelcut6);
% %Delta6Layers=max(Data6layers(:))-min(Data6layers(:));

Model3Layers=Model3Layers(1+numofpixcelcut3:end-numofpixcelcut3,1+numofpixcelcut3:end-numofpixcelcut3);
%Model6Layers=Model6Layers(1+numofpixcelcut6:end-numofpixcelcut6,1+numofpixcelcut6:end-numofpixcelcut6);

X3Layers=X3Layers(1+numofpixcelcut3:end-numofpixcelcut3,1+numofpixcelcut3:end-numofpixcelcut3);
X3Layers=X3Layers-mean(X3Layers(1,:));
% X6Layers=X6Layers(1+numofpixcelcut6:end-numofpixcelcut6,1+numofpixcelcut6:end-numofpixcelcut6);
% X6Layers=X6Layers-mean(X6Layers(1,:));

x3Layers2=0:pixsize3Layers:pixsize3Layers*53;
x3Layers2=x3Layers2-x3Layers2(1,end)/2
y3Layers2=x3Layers2';;
[X3Layers2,Y3Layers2]=meshgrid(x3Layers2,y3Layers2);

aa3=size(Data3layers,1)/2+0.5;
% aa6=size(Data6layers,1)/2+0.5;
phi_0=20.7;
tipradious=0.269/2;

Kernel3Layers= MaskGen(tipradious,X3Layers2,0);
PearlforPlot=[94 128];
for i=1:length(PearlforPlot)
    [~,ModelDiffrentPearls3Layers]=pearlgen_no_mag(X3Layers2,Y3Layers2,X3Layers2(1,size(x3Layers2,2)/2),Y3Layers2(size(x3Layers2,2)/2),PearlforPlot(i),0.36,phi_0,Kernel3Layers);
    TempModelDiff=diff(ModelDiffrentPearls3Layers(:,1:end-1))/pixsize3Layers;
    DiffModelDiffrentPearls3Layers{i}=TempModelDiff(3:end-2,3:end-2);
end

% X6Layers2=X6Layers;
% X6Layers2(:,end+1)=((X6Layers(1,2)-X6Layers(1,1))+X6Layers(1,end))+X6Layers(1,:)*0;
% X6Layers2(end+1,:)=X6Layers2(1,:);
% Y6Layers2=rot90(X6Layers2,3);
% 
% Kernel6Layers= MaskGen(tipradious,X6Layers2,0);
% 
% for i=1:length(PearlforPlot)
%     [~,ModelDiffrentPearls6Layers] = pearlgen_no_mag(X6Layers2,Y6Layers2,X6Layers2(1,aa6),Y6Layers2(aa6,1),PearlforPlot(i),0.26,phi_0,Kernel6Layers);
%     DiffModelDiffrentPearls6Layers{i}=diff(ModelDiffrentPearls6Layers(:,1:end-1))/pixsize6Layers;
% end


%% Plot

PearlColors=["#0072BD" "#c994c7" "#D95319"];

% % 6 Layers
% 
% axes(figs(1,2))
% plot(X6Layers(1,:),Model6Layers(:,aa6),'Color',"#A2142F",'LineWidth',linewidth_curve)
% hold on
% plot(X6Layers(1,:),Data6layers(:,aa6),'Color',[0.9290 0.6940 0.1250],'LineWidth',linewidth_curve)
% for i=1:length(PearlforPlot)
%     ModelsdiffPearls=DiffModelDiffrentPearls6Layers{i};
%     plot(X6Layers(1,:),ModelsdiffPearls(:,aa6),'Color',PearlColors(i),'LineWidth',linewidth_curve)
% end
% axis([X6Layers(1,1) X6Layers(1,end) min(min(DiffModelDiffrentPearls6Layers{1})),max(max(DiffModelDiffrentPearls6Layers{1}))+(max(max(DiffModelDiffrentPearls6Layers{1}))/10)])
% xticks([-1 0 1])
% xticklabels({'-1','0','1'})
% xlim([min(X6Layers(:)) max(X6Layers(:))])
% hold off

% 3 Layers
axes(figs(1,1))
plot(X3Layers(1,:),Model3Layers(:,aa3)-Model3Layers(1,aa3)+0.01,'Color',PearlColors(3),'LineWidth',linewidth_curve)
hold on

ModelsdiffPearls94=DiffModelDiffrentPearls3Layers{1};
plot(X3Layers(1,:),ModelsdiffPearls94(:,aa3)-ModelsdiffPearls94(1,aa3)+0.01,'Color',PearlColors(1),'LineWidth',linewidth_curve)

ModelsdiffPearls128=DiffModelDiffrentPearls3Layers{2};
plot(X3Layers(1,:),ModelsdiffPearls128(:,aa3)-ModelsdiffPearls128(3,aa3)+0.01,'Color',PearlColors(2),'LineWidth',linewidth_curve)

plot(X3Layers(1,:)-0.5*pixsize3Layers,Data3layers(:,aa3)-Data3layers(4,aa3)+0.01,'Color',[0.9290 0.6940 0.1250],'LineWidth',1.85)
axis([X3Layers(1,1) X3Layers(1,end) -0.1,0.1])
xticks([-1 0 1])
yticks([-0.09 0 0.09])
xticklabels({'-1','0','1'})
yticklabels({'-9','0','9'})
xlim([X3Layers(1,1) X3Layers(1,end-1)])
ModelFit=text(figs(1,1),X_size-6.8*mar,Y_size-1.5*mar,'Model:{\Lambda}=111 {\mum}','Units','in','Color',PearlColors(3),'FontSize',8,'FontName',FontName);
Data=text(figs(1,1),X_size-6.8*mar,Y_size-2.5*mar,'Data:{\Lambda}=111 {\mum}','Units','in','Color',[0.9290 0.6940 0.1250],'fontweight','bold','FontSize',8,'FontName',FontName);
Model150=text(figs(1,1),X_size-6.8*mar,Y_size-3.5*mar,'Model:{\Lambda}=128 {\mum}','Units','in','Color',PearlColors(2),'FontSize',8,'FontName',FontName);
Model80=text(figs(1,1),X_size-6.8*mar,Y_size-0.5*mar,'Model:{\Lambda}=94 {\mum}','Units','in','Color',PearlColors(1),'FontSize',8,'FontName',FontName);

hold off

% % 
% plotSensitivity3Layers={ModelsdiffPearls94 ModelsdiffPearls128};
% 
% save('C:\Users\Owner\Desktop\NbSe2\codes\Paper Figures\Figure 2\SaveSensitivityplot3Layers.mat','plotSensitivity3Layers')