%% Figure - The plot
close all

%% set figure

newfig=figure('NumberTitle', 'off', 'Name', 'MasterPlot');
Position=[2 2 4.9 4.9*0.7];
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
Xlim1=[1.7 35];
Xlim2=Xlim1/0.627;
Ylim=[2.4 120];

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

CalculatedTheory=readtable('theoryPoints.csv');

PearlLengthsTheory=CalculatedTheory{:,2};
ThicknessesTheory=CalculatedTheory{:,1};

axes(fig1)

% plot(ThicknessesTheory,PearlLengthsTheory,'o','color','none','MarkerFaceColor',"#2c7fb8")

MeasData=readtable('VortexUpdatedList230604.xlsx');

PearlLengthsMeas=MeasData{:,1};
ThicknessesMeas=MeasData{:,2};

axes(fig1)
plot(ThicknessesMeas(1:7),PearlLengthsMeas(1:7),'o','Color','none','MarkerFaceColor',[0.9290 0.6940 0.1250],'MarkerSize',7)
grid off
plot(ThicknessesMeas(8:18),PearlLengthsMeas(8:18),'o','Color','none','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerSize',7)
plot(ThicknessesMeas(19:26),PearlLengthsMeas(19:26),'o','Color','none','MarkerFaceColor',[0.6350 0.0780 0.1840],'MarkerSize',7)
plot(ThicknessesMeas(27:42),PearlLengthsMeas(27:42),'o','Color','none','MarkerFaceColor',[0 0.4470 0.7410],'MarkerSize',7)
plot(ThicknessesMeas(43:47),PearlLengthsMeas(43:47),'o','Color','none','MarkerFaceColor',[0.4940 0.1840 0.5560],'MarkerSize',7)

% text(ThicknessesMeas(1),PearlLengthsMeas(1)+1,['\leftarrow' num2str(1)])
% text(ThicknessesMeas(2),PearlLengthsMeas(2),['\leftarrow  2'])
% text(ThicknessesMeas(3),PearlLengthsMeas(3)+1,['\leftarrow 3-4'])
% text(ThicknessesMeas(5),PearlLengthsMeas(5),[num2str(5)])
% text(ThicknessesMeas(6),PearlLengthsMeas(6),['\leftarrow' num2str(6)])
% text(ThicknessesMeas(7)-0.2,PearlLengthsMeas(7),'  7')
% 
% text(ThicknessesMeas(8),PearlLengthsMeas(8)+1,['\leftarrow' '8-10'])
% text(ThicknessesMeas(11),PearlLengthsMeas(11),['11-16' '\uparrow'])
% text(ThicknessesMeas(17)-0.2,PearlLengthsMeas(17),['\leftarrow' '17-18'])
% 
% text(ThicknessesMeas(27),PearlLengthsMeas(27)+1,['\leftarrow' '27'])



%Theory=text(fig1,X_Scale_a-0.15*X_Scale_a,Y_Scale_a-X_Scale_a*0.05,'Model','Units','in','Color',"#2c7fb8",'FontSize',8,'FontName',FontName);
%Data=text(fig1,X_Scale_a-0.15*X_Scale_a,Y_Scale_a-X_Scale_a*0.1,'Exp','Units','in','Color',[0.9290 0.6940 0.1250],'FontSize',8,'FontName',FontName);
ylabel=text(fig1,-0.35,0.8,'\wedge ({\mum})','Units','in','Rotation',90,'Color','k','FontSize',12,'FontName',FontName);

