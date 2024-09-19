% Figure - Fits and deferent images
clear
close all


% set figure
len=2.8; %cm
width=7.1; %cm

newfig=figure('NumberTitle', 'off', 'Name', 'Fit');
Position=[0.5 0.5 width len];
clf
set(newfig,'Units','in')
set(newfig,'Position',Position,'Color',[1 1 1])
fontcolor='k';
linewidth=1;
linewidth_curve=1.5;
fontsize=10;
FontName='Arial';
DataColor=[0.9290 0.6940 0.1250];
FitColor="#0072BD";

[r,g,b]=Analyze_Support.Get_Gold();


% plot a
Xnum=3; %axis in X
Ynum=1; %axis in Y
% spaceX=(width-Xnum*X_size)/(Xnum+1);
% spaceY=(len-Ynum*Y_size)/(Ynum+1);
spaceX=0.4;
spaceY=0.2;
X_size=width/Xnum-spaceX-0.05;
factor=1;
Y_size=X_size*factor;
X0=0; %general offset
Y0=0.3;%general offset
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
            'colormap',[r g b],...            
            'YAxisLocation','left',...
            'Position',posfig{i,j});
        box(figs(i,j),'on');    
        hold(figs(i,j),'all');
    end
end



%% Text
mar=0.13; %margin
%Titles
TFAmplitudeFit=text(figs(1,1),0.75*mar,Y_size+mar,'Tunning Fork Amplitude','Units','in','Color',[0 0 0],'FontSize',12,'FontName',FontName);
TipResponseFit=text(figs(1,2),1.5*mar,Y_size+mar,'SOT Charaterization','Units','in','Color',[0 0 0],'FontSize',12,'FontName',FontName);
PearlLengthError=text(figs(1,3),0.5*mar,Y_size+mar,'Pearl Length Uncertainty','Units','in','Color',[0 0 0],'FontSize',12,'FontName',FontName);

% X axes
NumericalMagneticDerivative=text(figs(1,1),mar*3.3,-mar*2.7,'{dB_z}(h,  )/{dx} (T/m)','Units','in','Color',[0 0 0],'FontSize',fontsize,'FontName',FontName);
NumericalMagneticDerivativerbold=text(figs(1,1),0.845,-0.324,'r','Units','in','Color',[0 0 0],'FontSize',fontsize,'FontName',FontName,'FontWeight','bold');
MagneticField=text(figs(1,2),mar*4.5,-mar*2.7,'{\mu_0}{H_z} (mT)','Units','in','Color',[0 0 0],'FontSize',fontsize,'FontName',FontName);
PearlLengths=text(figs(1,3),mar*6,-mar*2.7,'{\Lambda} ({\mum})','Units','in','Color',[0 0 0],'FontSize',fontsize,'FontName',FontName);

% Y axes
TunningForkData=text(figs(1,1),-2*mar,4.3*mar,'{{B^{ac}_z}}(h,  ) ({\muT})','Units','in','Rotation',90,'Color',[0 0 0],'FontSize',fontsize,'FontName',FontName);
TunningForkDatarbold=text(figs(1,1),-0.2756,0.95,'r','Units','in','Rotation',90,'Color',[0 0 0],'FontSize',fontsize,'FontName',FontName,'FontWeight','bold');
TipFidback=text(figs(1,2),-2*mar,5*mar,'{V_{SOT}} (mV)','Units','in','Rotation',90,'Color',[0 0 0],'FontSize',fontsize,'FontName',FontName);
ChiSquared=text(figs(1,3),-2*mar,4*mar,'{{{\chi}_\Lambda}^2} (T/m)','Units','in','Rotation',90,'Color',[0 0 0],'FontSize',fontsize,'FontName',FontName);

% letters
a=text(figs(1,1),mar,Y_size-mar,'a','Units','in','Color','k','FontSize',12,'FontName',FontName);
b=text(figs(1,2),mar,Y_size-mar,'b','Units','in','Color','k','FontSize',12,'FontName',FontName);
c=text(figs(1,3),mar,Y_size-mar,'c','Units','in','Color','k','FontSize',12,'FontName',FontName);
%% loading data

%TF Amplitude
load('Paper Figures\Supplementary\Error_calculation\Error Plot\PlotTFFitData.mat')
TipResponseForTFNormalization=6.586e-5;
DCForTFAmplitudeNumericalDerivative=PlotTFFitData{1}*(1/(TipResponseForTFNormalization*1e6))-mean(PlotTFFitData{1}*(1/(TipResponseForTFNormalization*1e6))); %100 to turn into muT units and 1e6 to turn from nm to mum
TFForTFAmplitudeTFData=PlotTFFitData{2}*(1/TipResponseForTFNormalization)-mean(PlotTFFitData{2}*(1/TipResponseForTFNormalization));
TFAmpliteFit=fit(DCForTFAmplitudeNumericalDerivative(:),TFForTFAmplitudeTFData(:),'poly1');
TFAmpliteFitResiduals=TFForTFAmplitudeTFData(:)-TFAmpliteFit(DCForTFAmplitudeNumericalDerivative(:));
TFAmplitude=TFAmpliteFit.p1;
confidencecoess=confint(TFAmpliteFit);
TFAmplitudeLowerBound=confidencecoess(1);
TFAmplitudeUpperBound=confidencecoess(2);

%Tip Response
load('Paper Figures\Supplementary\Error_calculation\Error Plot\PlotTipResponseData.mat')
TipResponseH=PlotTipResponseData{1}/10; %change units to mT
VFidbackTipResponse=PlotTipResponseData{2}*1e3-mean(PlotTipResponseData{2}*1e3);% 1e3 to change units to mV
TipResponseFit=fit(TipResponseH,VFidbackTipResponse,'poly1');
TipResponseFitResiduals=VFidbackTipResponse-TipResponseFit(TipResponseH);
TipResponse=TipResponseFit.p1;
confidencecoess=confint(TipResponseFit);
TipResponseLowerBound=confidencecoess(1);
TipRsponseUpperBound=confidencecoess(2);

% x^2s of Pearl Lengths
load('Paper Figures\Supplementary\Error_calculation\Error Plot\PlotPearlLengthsChi.mat')
PearlLengths=PlotPearlLengthsChi{1}; %mum
chisquaredPearls=PlotPearlLengthsChi{2}*100;% 100 to change units to muT
minchiindex=find(chisquaredPearls==min(chisquaredPearls));
maxchivalue=2*min(chisquaredPearls);
PearlFit=PearlLengths(minchiindex);
RelevantIndices=find(chisquaredPearls<maxchivalue);
PearlFitUpperBound=PearlLengths(max(RelevantIndices))-PearlFit;
PearlFitLowerBound=PearlFit-PearlLengths(min(RelevantIndices));

%% Plot

% TF Amplitude

axes(figs(1,1))
plot(DCForTFAmplitudeNumericalDerivative,TFForTFAmplitudeTFData,'.','Color',DataColor)
hold on
plot(DCForTFAmplitudeNumericalDerivative(:),TFAmpliteFit(DCForTFAmplitudeNumericalDerivative(:)),'Color',FitColor,'LineWidth',linewidth_curve)
xlim([min(DCForTFAmplitudeNumericalDerivative(:)),max(DCForTFAmplitudeNumericalDerivative(:))])
xticks([round(min(DCForTFAmplitudeNumericalDerivative(:))*0.9) 0 round(max(DCForTFAmplitudeNumericalDerivative(:))*0.9)])
ylim([-3.1 3.1])
yticks([round(min(TFForTFAmplitudeTFData(:))*0.9) 0 round(max(TFForTFAmplitudeTFData(:))*0.9)])
hold off
TFAmplitudetext=text(figs(1,1),4*mar,1*mar,strcat('{x_{ac}}=',num2str(round(TFAmplitude*1000,1)),'{\pm}','1 nm'),'Units','in','Color',FitColor,'FontSize',10,'FontName',FontName);

% Tip Response

axes(figs(1,2))
plot(TipResponseH,VFidbackTipResponse,'.','Color',DataColor,'MarkerSize',11)
hold on
plot(TipResponseH,TipResponseFit(TipResponseH),'Color',FitColor,'LineWidth',linewidth_curve)
xticks([round(min(TipResponseH)*0.9) 0 round(max(TipResponseH)*0.9)])
yticks([round(min(VFidbackTipResponse)*0.9) 0 round(max(VFidbackTipResponse)*0.9)])
hold off
TipResponsetext=text(figs(1,2),2*mar,1*mar,strcat('{SOT_{R}}=',num2str(round(TipResponse,2)),'{\pm}','0.06 V/T'),'Units','in','Color',FitColor,'FontSize',10,'FontName',FontName);

%  Pearl Length Uncertainty
axes(figs(1,3))
plot(PearlLengths,chisquaredPearls,'.','Color',DataColor,'MarkerSize',11)
hold on
plot([50 PearlLengths 170],maxchivalue*ones(1,length(PearlLengths)+2),'Color',FitColor,'LineWidth',linewidth_curve)
xlim([88 153])
xticks([90 120 150])
ylim([0 min(chisquaredPearls)*5+0.2])
yticks([0 3 5])
hold off
PearlLengthstext=text(figs(1,3),7*mar,Y_size-2*mar,strcat('{\Lambda}=','{110^{+17}_{-12}}','{\mum}'),'Units','in','Color',FitColor,'FontSize',10,'FontName',FontName);
