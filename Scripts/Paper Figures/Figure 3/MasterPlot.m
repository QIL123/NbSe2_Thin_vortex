%% Figure - The plot
close all

%% set figure

newfig=figure('NumberTitle', 'off', 'Name', 'MasterPlot');
Position=[2 2 3.6 2.9];
clf
set(newfig,'Units','in')
set(newfig,'Position',Position,'Color',[1 1 1])
fontcolor='k';
linewidth=1;
linewidth_curve=1;
fontsize=10;
FontName='Arial' ;


% set axis
widthx=0.8;
widthy=1.1;
X_Scale_a=Position(3)-widthx;
Y_Scale_a=Position(4)-widthy;
posfig1=[0.54 0.54 X_Scale_a Y_Scale_a];
Xlim1=[1.7 36];
Xlim2=Xlim1/0.627;
Ylim=[1.5 145];

fig1=axes('Parent',newfig,...
    'ZColor',fontcolor,'YColor',fontcolor,'XColor',fontcolor,...
    'box','off',...
    'LineWidth',linewidth,...
    'FontSize',fontsize,...
    'FontName',FontName,...
    'Xlim',Xlim1,...
    'XScale','log',...
    'YScale','log',...
    'ylim',Ylim,...
    'Color','none',...
    'Units','in',...
    'Position',posfig1);
hold(fig1,'all');
xlabel('d (nm)','FontSize',12)
fig2=axes('Parent',newfig,...
    'ZColor',fontcolor,'YColor',fontcolor,'XColor',fontcolor,...
    'box','off',...
    'LineWidth',linewidth,...
    'FontSize',fontsize,...
    'FontName',FontName,...
    'XAxisLocation','top',...
    'XScale','log',...
    'YAxisLocation','right',...
    'YTick',[],...
    'ylim',Ylim,...
    'Xlim',Xlim2,...
    'Color','none',...
    'Units','in',...
    'Position',posfig1);  
hold(fig1,'all');
xlabel(fig2,'N','FontSize',12)
%% loading data


axes(fig2)

xticks([1 2 3 4 5 6 7 8 10 14 20 30 40 50 60])
xticklabels({'1','2','3','4','5','6','7','8','10','14','20','30','40','50','60'})
xtickangle(0)
grid off



axes(fig1)

xticks([2 3 4 5 6 7 8 10 14 20 30 40])
xticklabels({'2','3','4','5','6','7','8','10','14','20','30','40'})
xtickangle(0)


yticks([10 100])
yticklabels({'10','100'})

% CalculatedTheory=readtable('theoryPoints.csv');
% 
% PearlLengthsTheory=CalculatedTheory{:,2};
% ThicknessesTheory=CalculatedTheory{:,1};

CalculatedTheory=readtable('TheoryPointsUpdated.csv');

PearlLengthsTheory=CalculatedTheory{:,1};
ThicknessesTheory=((3:1:55).*0.627)';

axes(fig1)

% plot(ThicknessesTheory,PearlLengthsTheory,'o','color','none','MarkerFaceColor',"#2c7fb8")

MeasData=readtable('VortexUpdatedList230730.xlsx');

PearlLengthsMeas=MeasData{:,1};
PearlLengthsLowwer=MeasData{:,2};
PearlNeg=PearlLengthsMeas-PearlLengthsLowwer;
PearlLengthsUpper=MeasData{:,3};
PearlPos=PearlLengthsUpper-PearlLengthsMeas;
ThicknessesMeas=MeasData{:,4};
ThicknessesError=MeasData{:,5};

axes(fig1)

%plot(ThicknessesMeas,PearlLengthsMeas,'o','Color','none','MarkerFaceColor',[0.9290 0.6940 0.1250],'MarkerSize',5)
plot(ThicknessesMeas,PearlLengthsMeas,'o','Color','none','MarkerFaceColor',"#f05a5c",'MarkerSize',5)

grid off

%errorbar(ThicknessesMeas,PearlLengthsMeas,PearlNeg,PearlPos,'.','color',[0.9290 0.6940 0.1250],'CapSize',1)
errorbar(ThicknessesMeas,PearlLengthsMeas,PearlNeg,PearlPos,'.','color',"#f05a5c",'CapSize',1)

%errorbar(ThicknessesMeas,PearlLengthsMeas,ThicknessesError,'horizontal','.','color',[0.9290 0.6940 0.1250],'CapSize',1)
errorbar(ThicknessesMeas,PearlLengthsMeas,ThicknessesError,'horizontal','.','color',"#f05a5c",'CapSize',1)

plot(ThicknessesTheory,PearlLengthsTheory,".",'color',"#2c7fb8",'MarkerSize',8)

linecolor='k';%[0.4, 0.4, 0.4];
linethick=1;

LondonFactor=2*(230)^2;
x=0.5:1:40;
y=(LondonFactor./x)*1e-3;
plot(x,y,'--','color',linecolor,'LineWidth',linethick)

Theory=text(fig1,X_Scale_a-0.15*X_Scale_a,Y_Scale_a-X_Scale_a*0.05,'Model','Units','in','Color',"#2c7fb8",'FontSize',10,'FontName',FontName);
Data=text(fig1,X_Scale_a-0.15*X_Scale_a,Y_Scale_a-X_Scale_a*0.1,'Exp','Units','in','Color',"#f05a5c",'FontSize',10,'FontName',FontName);
line=text(fig1,X_Scale_a-0.15*X_Scale_a,Y_Scale_a-X_Scale_a*0.17,'2{\lambda}_L^2/d','Units','in','Color','k','FontSize',10,'FontName',FontName);
ylabel=text(fig1,-0.35,0.75,'\Lambda ({\mum})','Units','in','Rotation',90,'Color','k','FontSize',12,'FontName',FontName);
%b=text(fig1,-0.4,2.2,'b','Units','in','Color',[0 0 0],'FontSize',12,'FontName',FontName);

