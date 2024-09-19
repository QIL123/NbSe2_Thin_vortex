%%
clear
clc
%% Load data, creates a table just the same as excel but in Matlab format

%Index=readtable('../Data/Data_index_Sample2YA.xlsx'); % for sample 2
Index=readtable('../../Data/Data/Data_index_Sample2YA.xlsx'); % for sample 3

%% Parl fit
ind=find(strcmp(Index.IsolatedVortex,'yes')); %%returns vector index of isolated vortices
%ind=find(strcmp(Index.IsolatedVortex,'yes')& Index.capped==1);
%ind = [5];
scan_dist=ind*0; %%zeros vector of the length of number of isolatad votices
pearl_length=ind*0; %%zeros vector of the length of number of isolatad votices
% z(1:34)=0.208;
% z(34)=0.208-.05;
% z(33)=0.208-.02;
% z(32)=0.208-.02;
% z(31)=0.208+0.05;

for j=1:length(ind) %%%runing over number of isolated vortices
   ii=ind(j)
   DialationFactor=1;
   
   
   [coef,err]=pearl_fit_index(Index,ii,1,[],DialationFactor); 
   %%pearl_fit_index(Index,ii,flag (Plots),z,DialationFactor)
   pearl_length(j)=coef(1);
   scan_dist(j)=coef(2);
   thickness(j)=Index.Z(ii)*1e-3;
   lambda(j)=sqrt(pearl_length(j)*thickness(j)/2); %calculate the lambda
%    thic_err(j)=Index.sigZ(ii)*1e-3;
%    lam_err_d(j)=(1/(2*sqrt(2))) * sqrt(pearl_length(j)/thickness(j)) * thic_err(j);
%    pl_err(j)=lam_err_pl(j)=0.05*pearl_length(j);
%    lam_err_pl(j)=(1/(2*sqrt(2))) * sqrt(thickness(j)/pearl_length(j)) * pl_err(j);
%    
%    lam_err(j)=sqrt(lam_err_d(j)^2 + lam_err_pl(j)^2);
%    
   if 0 % Save in Index
       if 0
%            fig = get(groot,'CurrentFigure');
           fig = figure(ii);
           fig2= figure(77);
           fn=sprintf('C:\\Users\\tomer\\Desktop\\NbSe2\\PearlFits\\Sample3\\Dialation%s\\%s%s.jpg',num2str(DialationFactor),num2str(Index.Day(ii)),char(Index.Name(ii)));
           exportgraphics(fig,fn,'Resolution',300)

%            fig.WindowState = 'maximized';
%            pause(1)
%            Index.Perc(ii)=input('Perc?');
           if ~isempty(fig2)
               fn=sprintf('C:\\Users\\tomer\\Desktop\\NbSe2\\PearlFits\\Sample3\\Dialation%s\\err\\%s%sErr.jpg',num2str(DialationFactor),num2str(Index.Day(ii)),char(Index.Name(ii)));
               exportgraphics(fig2,fn,'Resolution',300)
               
               
           end
              close(fig2)
              close(fig)
       end

%        Index.GoodFit(ii)=input('is the fit good?');
%    pl_err(j)=perc(j)/100*pearl_length(j);
%    lam_err_pl(j)=(1/(2*sqrt(2))) * sqrt(thickness(j)/pearl_length(j)) * pl_err(j);
%    lam_err(j)=sqrt(lam_err_d(j)^2 + lam_err_pl(j)^2);
          
       Index.PearlLengthFit(ii)=pearl_length(j);
       Index.ScanDistFit(ii)=scan_dist(j);
       Index.Lambda_PearlFit(ii)=lambda(j);
%        Index.LambdaErrFit(ii)=lam_err(j);
   end
end

%%
figure(345)
% rel=find(lambda<0.8);
rel=1:length(lambda);
loglog(thickness(rel),2*lambda(rel).^2./thickness(rel),'o')
% errorbar(thickness,lambda,-thic_err,thic_err,-lam_err,lam_err,'.')
%errorbar(thickness(rel),lambda(rel),lam_err(rel),'.','vertical')

xlabel('Thickness [um]','FontSize',14,'FontWeight','bold')
ylabel('\Lambda [um]','FontSize',14,'FontWeight','bold')
title('Lambda vs Thickness Sample #2 Device #1 Region A','FontSize',14)
ax = gca
ax.XAxis.FontSize = 15;
ax.YAxis.FontSize = 15;
grid on
hold off

%% Parl fit
day=27;
ind=find(Index.Day==day & strcmp(Index.IsolatedVortex,'yes'));
% ind=find(strcmp(Index.IsolatedVortex,'yes'));
% % ind = [11,12];
scan_dist=ind*0;
pearl_length=ind*0;
figure(43)
for j=1:length(ind)
   ii=ind(j);
   [coef,err]=pearl_fit_index(Index,ii,0);
   pearl_length(j)=coef(1);
   scan_dist(j)=coef(2);
   if scan_dist(j)>0.1 & pearl_length(j)<80
   plot(pearl_length(j),scan_dist(j)*1e3,'ok')
   hold on
   end
end
ylabel('Z [nm]')
xlabel('Pearl length [um]')
legend(['23.7 - Blue, 26.7 - Red, 27.7 - Black'])
grid on
%% Plot distances 
relevant=find(scan_dist>0.1 & pearl_length<80);
% figure
% histogram(scan_dist(relevant)*1e3,15)
% xlabel('Z [nm]')
figure
plot(pearl_length(relevant),scan_dist(relevant)*1e3,'ob')
ylabel('Z [nm]')
xlabel('Pearl_length [um]')
grid on
%% plot data
% close all
% ind=find(~isnan(Index.Lambda_PearlFit));
ind=find(~isnan(Index.Z) & Index.GoodFit==1 & ~isnan(Index.sameVortex));

Z=Index.Z(ind); %thickness in nm
Lambda=Index.Lambda_PearlFit(ind)*1e3; %Lambda in nm
thic_err=Index.sigZ(ind); 
lambda_err=Index.LambdaErrFit(ind)*1e3;

% taking care of vortex repetitions
A=Index.sameVortex(ind);
[C,ia,ic]=unique(A);
Z=C*0;
Lambda=C*0;
thic_err=C*0;
lambda_err=C*0;
tag=C*0;
for i=1:length(C)
    k=C(i);
    if ~isnan(k)
        ind2=find(Index.sameVortex==k);
        Z(i)=Index.Z(ind2(1));
        Lambda(i)=mean(Index.Lambda_PearlFit(ind2)*1e3);
        thic_err(i)=Index.sigZ(ind2(1));
        lambda_err(i)=mean(Index.LambdaErrFit(ind2)*1e3);
        tag(i)=k;

    else
        
    end
end

% Add the ultra thin
LUT=500;
ZUT=7.4;
ETUT=1.2;
LEUT=(1/(2*sqrt(2))) * sqrt(LUT/ZUT) * ETUT;
LEUT=50;

Lambda=[Lambda; LUT];
Z=[Z; ZUT];
thic_err=[thic_err; ETUT];
lambda_err=[lambda_err; LEUT];
tag=[tag; 24];

bulk=212;
% 
% NFig = figure('Name','THE PLOT');
% NFig.WindowState = 'maximized';

hold on
plot(Z,Lambda,'o','Color','#4DBEEE','MarkerFaceColor','#4DBEEE')
grid on

e=errorbar(Z,Lambda,thic_err,'.k','horizontal');
e.Color = [0.7,0.7,0.7];
e=errorbar(Z,Lambda,lambda_err,'.k','vertical');
e.Color = [0.7,0.7,0.7];
hline = refline([0 bulk]);
hline.Color = [0.6 0.4 0.3];
hline.LineWidth=1;
hline.LineStyle='-.';
xlabel('Thickness [nm]','FontSize',14,'FontWeight','bold')
ylabel('\lambda [nm]','FontSize',14,'FontWeight','bold')
% title('Lambda vs Thickness Sample #2 Device #1 Region A','FontSize',14)
ax = gca;
ax.XAxis.FontSize = 15;
ax.YAxis.FontSize = 15;
for jj=1:length(Z)
    text(Z(jj),Lambda(jj),['\leftarrow',num2str(tag(jj))])
end
hold off
% ax1_pos = ax.Position;
% ax.XLim=[5 45];
% xlims=ax.XLim;
% ax2 = axes('Position',ax1_pos,...
%     'XAxisLocation','top',...
%     'YAxisLocation','right',...
%     'Color','none');
% ax2.YAxis.Visible=0;
% ax2.XAxis.FontSize = 15;
% xlabel('Layer Number','FontSize',14,'FontWeight','bold')
% Cconst=1.254;
% LayerN=Z/Cconst;
% y2=LayerN*0;
% line(LayerN,Lambda,'LineStyle','-','Parent',ax2)
% ax2.XLim=xlims/Cconst;
% ax2.YLim=[150 550];
% ax.YLim=[150 550];
% 
% NFiglog = figure('Name','THE PLOT - log scale');
% NFiglog.WindowState = 'maximized';
% 
% hold on
% plot(Z,Lambda,'o','Color','#4DBEEE','MarkerFaceColor','#4DBEEE')
% grid on
% 
% e=errorbar(Z,Lambda,thic_err,'.k','horizontal');
% e.Color = [0.7,0.7,0.7];
% e=errorbar(Z,Lambda,lambda_err,'.k','vertical');
% e.Color = [0.7,0.7,0.7];
% hline = refline([0 bulk]);
% hline.Color = [0.6 0.4 0.3];
% hline.LineWidth=1;
% hline.LineStyle='-.';
% xlabel('Thickness [nm]','FontSize',14,'FontWeight','bold')
% ylabel('\lambda [nm]','FontSize',14,'FontWeight','bold')
% % title('Lambda vs Thickness Sample #2 Device #1 Region A - log scale','FontSize',14)
% ax = gca;
% ax.XAxis.FontSize = 15;
% ax.YAxis.FontSize = 15;
% ax.XScale = 'log';
% ax.YScale = 'log';
% for jj=1:length(Z)
%     text(Z(jj),Lambda(jj),['\leftarrow',num2str(tag(jj))])
% end
% hold off
% pause(8)
% exportgraphics(NFig,'ThePlot125.pdf','ContentType','vector')
% exportgraphics(NFiglog,'ThePlot-Log125.pdf','ContentType','vector')
%% PLOT #2
close all
hold on
ind=find(~isnan(Index.Lambda_PearlFit) & Index.Plot==1);
% ind=find(~isnan(Index.Z) & Index.GoodFit==1 & ~isnan(Index.sameVortex));

Z=Index.Thickness(ind); %thickness in nm
Lambda=Index.Lambda_PearlFit(ind)*1e3; %Lambda in nm
thic_err=Index.sigZ(ind); 
tag=Index.sameVortex(ind);
lambda_err=Index.LambdaErrFit(ind)*1e3;

NFig = figure('Name','THE PLOT');
NFig.WindowState = 'maximized';

hold on
plot(Z,Lambda,'o','Color','r','MarkerFaceColor','r')
grid on

xlabel('Thickness [nm]','FontSize',14,'FontWeight','bold')
ylabel('\lambda [nm]','FontSize',14,'FontWeight','bold')
% title('Lambda vs Thickness Sample #2 Device #1 Region A','FontSize',14)
ax = gca;
ax.XAxis.FontSize = 15;
ax.YAxis.FontSize = 15;

for jj=1:length(Z)
    text(Z(jj),Lambda(jj),['\leftarrow',num2str(tag(jj))])
end
hold off
%% DIST+EXTENSION
try
    close 65
catch
    figure(65)
end
ind=find(Index.ScanDistFit>0 & strcmp(Index.IsolatedVortex,'yes') & Index.GoodFit==1 & ~(Index.Day==27));
Dist=Index.ScanDistFit(ind);
Ext=Index.ZScannerPos(ind);
Thick=Index.Z(ind)*1e-3;
D=Dist(2:end)+Ext(2:end)+Thick(2:end);
D=D-mean(D);
% D2=Dist(2:end)+Ext(2:end)+Thick(2:end);
% t=[];
% str='%s-%s-2020 %s';
% for j=1:length(ind)
% TimeStr=sprintf(str,num2str(Index.Day(ind(j))'),char(Index.Month(ind(j))'),char(Index.Time(ind(j))'));
% t=[t datetime(TimeStr)];
% end
% yyaxis left
% % plot(t,D)
% hold on
% plot(t,Ext)
% ylabel('[um]')
% yyaxis right
% ylabel('Distance Fit [um]')
% plot(t,Dist)
% grid on 
% legend('D=Extension + Scan Height','Extension','Scan Height')
figure(27)
h=histogram(D,6);
h.Normalization = 'probability';
grid on
xlabel('Local Thickness + Fitted Distance [\mum]')
ylabel('Probability')
xlabel('Deviation From the Avarge Distance [\mum]')
edges=h.BinEdges;
h.BinEdges=edges+0.01;
%%
ind=find(Index.ScanDistFit>0 & strcmp(Index.IsolatedVortex,'yes') & Index.GoodFit==1);
re=Index.sigZ(ind)./Index.Z(ind)

%% Update time

for i=1:size(Index,1)
    
   Name=char(Index.Name(i));
   Day=pad(num2str(Index.Day(i)),2,'left','0');
   Month=char(Index.Month(i));
   formatSpec= 'C:\\Users\\tomer\\Desktop\\NbSe2\\%s\\%s\\SXM\\%s.sxm';
   FileName=sprintf(formatSpec,Month,Day,Name);
   
   sxmFile = sxm.load.loadProcessedSxM(FileName);
   Index.Time(i)={sxmFile.header.rec_time};
end
%% Calculate lambda+d
% Index.FitError=zeros(1,size(Index,1))';
ind=find(strcmp(Index.IsolatedVortex,'yes'));
[coefs,~]=lambdafit(0.5,23,116,0.016);
a=[];
ind=4;
% mag=[];
mag=coefs(2);
for j=1:length(ind)
   i=ind(j);
   Name=char(Index.Name(i));
   FileNum=Name(end-2:end);
   r=0.5;

   [coefs,err,xc,yc]=lambdafit(r,Index.Day(i),FileNum,Index.calib(i),mag);
%    input('Is it ok? ');
   
%    Index.lambda_d(i)=coefs(1);
%    Index.magnitude(i)=coefs(2);
%    Index.magnitude(i)=mag;
%    Index.FitError(i)=err;
   Index.xc(i)=xc;
   Index.yc(i)=yc;
end
%% Calculate error vs lambda
ind=find(Index.Day==23 & strcmp(Index.IsolatedVortex,'yes'));
for j=1:length(ind)
   i=ind(j);
   i
   Name=char(Index.Name(i));
   FileNum=Name(end-2:end);
   r=0.5;
   mag=Index.magnitude(i);
       figure(124)
    subplot(3,3,j)
    figure(1515)
    subplot(3,3,j)
%     [lambdas,errors]=lambdashifterr(r,Day,FileNum,lambda,mag,range,n,calib,0);
   [~,~,~,~,lambdas,errors]=lambdafit(r,Index.Day(i),FileNum,Index.calib(i),mag,1);
   figure(4321)
   hold on
   subplot(3,3,j)
   
   plot((lambdas-lambdas(ceil(end/2)))*1e3,errors,'.')
%    minimum=find(min(abs(errors))==abs(errors));
%    set(gca, 'XTick', unique([lambdas(minimum)-lambdas(ceil(end/2)), get(gca, 'XTick')]));
   grid on
   title(Name)
   hold off
   sgtitle('abs(model(\lambda) - data) vs. Lambda shift in nm')
%    xlabel('Lambda shift in nm')
%    ylabel('Sum of differences between model and data')
       figure(124)
    subplot(3,3,j)
    title(Name)
    figure(1515)
    subplot(3,3,j)
    title(Name)

end

%% Error vs lambda

i=4;

Name=char(Index.Name(i))
FileNum=Name(end-2:end);
r=0.5;
Day=Index.Day(i)
lambda=Index.lambda_d(i)
mag=Index.magnitude(i)
calib=Index.calib(i);


range=100; %in nm
n=31;
[lambdas,errors]=lambdashifterr(r,Day,FileNum,lambda,mag,range,n,calib,1);

figure(666)
plot((lambdas-lambdas(ceil(end/2)))*1e3,errors,'.')
grid on 
box on
title(['sqrt((model(\lambda) - data)^2) vs. Lambda shift in nm of',Name])
       figure(111)
          sgtitle(Name)
%% Error vs lambda vs magnitude

i=7;

Name=char(Index.Name(i));
FileNum=Name(end-2:end);
r=0.5;
Day=Index.Day(i);
lambda=Index.lambda_d(i);
mag=Index.magnitude(i);
calib=Index.calib(i);


range=100; %in nm
n=31;
mags=linspace(mag-range*1e-3,mag+range*1e-3,n+10);
for k=1:n+10
    
    [lambdas(k,:),errors(k,:)]=lambdashifterr(r,Day,FileNum,lambda,mags(k),range,n,calib,0);
end
[a,b]=find(min(min(errors))==errors');
figure(str2num(FileNum))

[MAGS,LAMBDAS] = meshgrid((mags-mag),(lambdas(1,:)-lambda)*1e3);
surf(MAGS,LAMBDAS,errors')
xlabel('Magnitude shift')
ylabel('Lambda shift')
zlabel('Error')
hold on
% plot3(zeros(1,31),LAMBDAS(:,1)',errors(21,:),'r','LineWidth',3)
% plot3(MAGS(a,b),LAMBDAS(a,b),errors(a,b),'*')
% plot((lambdas-lambdas(ceil(end/2)))*1e3,errors,'.')
grid on 
box on
% title(['(model(\lambda,mag) - data)^2 vs. Lambda and mag shift of',Name])
hold off
%% lambda vs r

i=7; %Choose a vortex

Name=char(Index.Name(i))
FileNum=Name(end-2:end);

Day=Index.Day(i);
mag=Index.magnitude(i);
calib=Index.calib(i);

rs=linspace(0.1,1.2,9);
LambdaSave=[];
    figure(124)
    j=1
    subplot(3,3,j)
    figure(1515)
    subplot(3,3,j)
for r=rs
    r
[lambda_d,~]=lambdafit(r,Day,FileNum,calib,mag,0);
LambdaSave=[LambdaSave, lambda_d];
j=j+1    
figure(124)
    try
    subplot(3,3,j)
    title(Name)
    figure(1515)
    subplot(3,3,j)
    title(Name)
    catch
    end
end
figure(675675)
plot(rs,LambdaSave,'o')
grid on 
box on
title(['\lambda +d vs. r of ',Name])
xlabel('r')
ylabel('\lambda +d')
%% Save?
% writetable(Index,'Data_index_updated2.xlsx')
writetable(Index,'Data_index_Sample3.xlsx')

