%% ploting EDS analysis

%% EDS figure Format
% Figure - Fits and deferent images
clear
close all


% set figure
len=2.7; %cm
width=4.2; %cm

newfig=figure('NumberTitle', 'off', 'Name', 'Fit');
Position=[0.5 0.5 width len];
clf
set(newfig,'Units','in')
set(newfig,'Position',Position,'Color',[1 1 1])
fontcolor='k';
linewidth=1;
linewidth_curve=1.25;
fontsize=12;
FontName='Arial';
Multiplyer3Layer=6;
%Multiplyer6Layer=2;

[r,g,b]=Analyze_Support.Get_Gold();


% plot a
Xnum=1; %axis in X
Ynum=2; %axis in Y
% spaceX=(width-Xnum*X_size)/(Xnum+1);
% spaceY=(len-Ynum*Y_size)/(Ynum+1);
spaceX=0.15;
spaceY=0.09;
X_size=(width-0.12)/Ynum-spaceX-0.2;
factor=1;
Y_size=X_size*factor;
X0=0.4; %general offset
Y0=0.6;%general offset
% posfig=[spaceX spaceY X_size  Y_size];

for i=1:Xnum
    for j=1:Ynum
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
            'XColor','none',...
            'YColor','none',...
            'Position',posfig{i,j});
        box(figs(i,j),'on');    
        hold(figs(i,j),'all');
    end
end

% for i=2:Ynum
%     for j=1:Xnum
%         x0=X0+spaceX*j+X_size*(j-1);
%         y0=Y0+spaceY*i+Y_size*(i-1);
%         posfig(i,j)={[x0 y0 X_size Y_size]};
%         figs(i,j)=axes('Parent',newfig,...
%             'ZColor',fontcolor,'YColor',fontcolor,'XColor',fontcolor,...
%             'LineWidth',linewidth,...
%             'FontSize',fontsize,...
%             'FontName',FontName,...
%             'Color','none',...
%             'Units','in',...
%             'xticklabel',{''},...
%             'xtick',[],...
%             'colormap',[r g b],...            
%             'yticklabel',{''},...
%             'ytick',[],...
%             'XColor','none',...
%             'YColor','none',...
%             'YAxisLocation','right',...
%             'Position',posfig{i,j});
%         box(figs(i,j),'off');    
%         hold(figs(i,j),'all');
%     end
% end

%% loading data
% Sample 5 layers lammela 1
% Haadf
Path5_1_Image='C:\Users\Owner\Dropbox\QIL projects\NbSe2_thin vortex\TEM\5 layes\1003\SI_HAADF-DF4-DF2-BF_1003 - Spectrum Profile 0003 HAADF.tif';
Image5_1 = Tiff(Path5_1_Image,'r');
imageData5_1=read(Image5_1);

%Oxygen
Path5_1_O='C:\Users\Owner\Dropbox\QIL projects\NbSe2_thin vortex\TEM\5 layes\1003\SI_HAADF-DF4-DF2-BF_1003 - Spectrum Profile 0003-O.txt';
OSpectraData5_1 = readtable(Path5_1_O);
xO5_1=OSpectraData5_1.Var1;
OSpectra5_1=OSpectraData5_1.Var2;
%plot(xO5_1,OSpectra5_1)

%Nb
Path5_1_Nb='C:\Users\Owner\Dropbox\QIL projects\NbSe2_thin vortex\TEM\5 layes\1003\SI_HAADF-DF4-DF2-BF_1003 - Spectrum Profile 0003-Nb.txt';
NbSpectraData5_1 = readtable(Path5_1_Nb);
xNb5_1=NbSpectraData5_1.Var1;
NbSpectra5_1=NbSpectraData5_1.Var2;
%plot(xNb5_1,NbSpectra5_1)

%Se
Path5_1_Se='C:\Users\Owner\Dropbox\QIL projects\NbSe2_thin vortex\TEM\5 layes\1003\SI_HAADF-DF4-DF2-BF_1003 - Spectrum Profile 0003-Se.txt';
SeSpectraData5_1 = readtable(Path5_1_Se);
xSe5_1=SeSpectraData5_1.Var1;
SeSpectra5_1=SeSpectraData5_1.Var2;
%plot(xSe5_1,SeSpectra5_1)

%Nitrogen
Path5_1_N='C:\Users\Owner\Dropbox\QIL projects\NbSe2_thin vortex\TEM\5 layes\1003\SI_HAADF-DF4-DF2-BF_1003 - Spectrum Profile 0003-N.txt';
NSpectraData5_1 = readtable(Path5_1_N);
xN5_1=NSpectraData5_1.Var1;
NSpectra5_1=NSpectraData5_1.Var2;
%plot(xN5_1,NSpectra5_1)

%Silicon
Path5_1_Si='C:\Users\Owner\Dropbox\QIL projects\NbSe2_thin vortex\TEM\5 layes\1003\SI_HAADF-DF4-DF2-BF_1003 - Spectrum Profile 0003-Si.txt';
SiSpectraData5_1 = readtable(Path5_1_Si);
xSi5_1=SiSpectraData5_1.Var1;
SiSpectra5_1=SiSpectraData5_1.Var2;
%plot(xSi5_1,SiSpectra5_1)


% Sample 5 layers lammela 1 Second image
% Haadf
Path5_2_Image='C:\Users\Owner\Dropbox\QIL projects\NbSe2_thin vortex\TEM\5 layes\1019\SI_HAADF-DF4-DF2-BF_1019 - Spectrum Profile 0002 HAADF.tif';
Image5_2 = Tiff(Path5_2_Image,'r');
imageData5_2=read(Image5_2);

%Oxygen
Path5_2_O='C:\Users\Owner\Dropbox\QIL projects\NbSe2_thin vortex\TEM\5 layes\1019\SI_HAADF-DF4-DF2-BF_1019 - Spectrum Profile 0002-O.txt';
OSpectraData5_2 = readtable(Path5_2_O);
xO5_2=OSpectraData5_2.Var1;
OSpectra5_2=OSpectraData5_2.Var2;
%plot(xO5_2,OSpectra5_2)

%Nb
Path5_2_Nb='C:\Users\Owner\Dropbox\QIL projects\NbSe2_thin vortex\TEM\5 layes\1019\SI_HAADF-DF4-DF2-BF_1019 - Spectrum Profile 0002-Nb.txt';
NbSpectraData5_2 = readtable(Path5_2_Nb);
xNb5_2=NbSpectraData5_2.Var1;
NbSpectra5_2=NbSpectraData5_2.Var2;
%plot(xNb5_2,NbSpectra5_2)

%Se
Path5_2_Se='C:\Users\Owner\Dropbox\QIL projects\NbSe2_thin vortex\TEM\5 layes\1019\SI_HAADF-DF4-DF2-BF_1019 - Spectrum Profile 0002-Se.txt';
SeSpectraData5_2 = readtable(Path5_2_Se);
xSe5_2=SeSpectraData5_2.Var1;
SeSpectra5_2=SeSpectraData5_2.Var2;
%plot(xSe5_2,SeSpectra5_2)

%Nitrogen
Path5_2_N='C:\Users\Owner\Dropbox\QIL projects\NbSe2_thin vortex\TEM\5 layes\1019\SI_HAADF-DF4-DF2-BF_1019 - Spectrum Profile 0002-N.txt';
NSpectraData5_2 = readtable(Path5_2_N);
xN5_2=NSpectraData5_2.Var1;
NSpectra5_2=NSpectraData5_2.Var2;
%plot(xN5_2,NSpectra5_2)

%Silicon
Path5_2_Si='C:\Users\Owner\Dropbox\QIL projects\NbSe2_thin vortex\TEM\5 layes\1019\SI_HAADF-DF4-DF2-BF_1019 - Spectrum Profile 0002-Si.txt';
SiSpectraData5_2 = readtable(Path5_2_Si);
xSi5_2=SiSpectraData5_2.Var1;
SiSpectra5_2=SiSpectraData5_2.Var2;
%plot(xSi5_2,SiSpectra5_2)

% % Sample 1 lammela 2
% %image
% Path1_2_Image='C:\Users\Owner\Desktop\Nofar\NbSe2\NbSe2\TEM\Sample 1\A2.Sp1-45\A2.Sp1-45\Data\SI HAADF 1348 HAADF.tif';
% Image = Tiff(Path1_2_Image,'r');
% imageData1_2=read(Image);
% 
% %Oxygen
% Path1_2_Oxigen='C:\Users\Owner\Desktop\Nofar\NbSe2\NbSe2\TEM\Sample 1\A2.Sp1-45\A2.Sp1-45\Data\SI HAADF 1348 O-net.tif';
% Oxygen_Image = Tiff(Path1_2_Oxigen,'r');
% Oxygen_Image_Data1_2=read(Oxygen_Image);
% 
% %Nb
% Path1_2_Nb='C:\Users\Owner\Desktop\Nofar\NbSe2\NbSe2\TEM\Sample 1\A2.Sp1-45\A2.Sp1-45\Data\SI HAADF 1348 Nb-net.tif';
% Nb_Image = Tiff(Path1_2_Nb,'r');
% Nb_Image_Data1_2=read(Nb_Image);
% 
% %Se
% Path1_2_Se='C:\Users\Owner\Desktop\Nofar\NbSe2\NbSe2\TEM\Sample 1\A2.Sp1-45\A2.Sp1-45\Data\SI HAADF 1348 Se-net.tif';
% Se_Image = Tiff(Path1_2_Se,'r');
% Se_Image_Data1_2=read(Se_Image);
% 
% %Nitrogen
% Path1_2_Nitrogen='C:\Users\Owner\Desktop\Nofar\NbSe2\NbSe2\TEM\Sample 1\A2.Sp1-45\A2.Sp1-45\Data\SI HAADF 1348 N-net.tif';
% Nitrogen_Image = Tiff(Path1_2_Nitrogen,'r');
% Nitrogen_Image_Data1_2=read(Nitrogen_Image);

% % Sample 2 lammela 1
% %image
% Path2_1_Image='C:\Users\Owner\Desktop\Nofar\NbSe2\NbSe2\TEM\5 Layer Sample 1\TEM\A.NbSe-1\A.NbSe-1\Data\SI_HAADF-DF4-DF2-BF_1003 HAADF.tif';
% Image = Tiff(Path2_1_Image,'r');
% imageData2_1=read(Image);
% 
% %Oxygen
% Path2_1_Oxigen='C:\Users\Owner\Desktop\Nofar\NbSe2\NbSe2\TEM\5 Layer Sample 1\TEM\A.NbSe-1\A.NbSe-1\Data\SI_HAADF-DF4-DF2-BF_1003 O-net.tif';
% Oxygen_Image = Tiff(Path2_1_Oxigen,'r');
% Oxygen_Image_Data2_1=read(Oxygen_Image);
% 
% %Nb
% Path2_1_Nb='C:\Users\Owner\Desktop\Nofar\NbSe2\NbSe2\TEM\5 Layer Sample 1\TEM\A.NbSe-1\A.NbSe-1\Data\SI_HAADF-DF4-DF2-BF_1003 Nb-net.tif';
% Nb_Image = Tiff(Path2_1_Nb,'r');
% Nb_Image_Data2_1=read(Nb_Image);
% 
% %Se
% Path2_1_Se='C:\Users\Owner\Desktop\Nofar\NbSe2\NbSe2\TEM\5 Layer Sample 1\TEM\A.NbSe-1\A.NbSe-1\Data\SI_HAADF-DF4-DF2-BF_1003 Se-net.tif';
% Se_Image = Tiff(Path2_1_Se,'r');
% Se_Image_Data2_1=read(Se_Image);
% 
% %Nitrogen
% Path2_1_Nitrogen='C:\Users\Owner\Desktop\Nofar\NbSe2\NbSe2\TEM\5 Layer Sample 1\TEM\A.NbSe-1\A.NbSe-1\Data\SI_HAADF-DF4-DF2-BF_1003 N-net.tif';
% Nitrogen_Image = Tiff(Path2_1_Nitrogen,'r');
% Nitrogen_Image_Data2_1=read(Nitrogen_Image);

% Sample 1 lammela 1
% Haadf
Path1_1_Image='C:\Users\Owner\Dropbox\QIL projects\NbSe2_thin vortex\TEM\Sample1\1348\SI HAADF 1348 - Spectrum Profile 0001 HAADF.tif';
Image1_1 = Tiff(Path1_1_Image,'r');
imageData1_1=read(Image1_1);

%Oxygen
Path1_1_O='C:\Users\Owner\Dropbox\QIL projects\NbSe2_thin vortex\TEM\Sample1\1348\SI HAADF 1348 - Spectrum Profile 0001-O.txt';
OSpectraData1_1 = readtable(Path1_1_O);
xO1_1=OSpectraData1_1.Var1;
OSpectra1_1=OSpectraData1_1.Var2;
%plot(xO1_1,OSpectra1_1)

%Nb
Path1_1_Nb='C:\Users\Owner\Dropbox\QIL projects\NbSe2_thin vortex\TEM\Sample1\1348\SI HAADF 1348 - Spectrum Profile 0001-Nb.txt';
NbSpectraData1_1 = readtable(Path1_1_Nb);
xNb1_1=NbSpectraData1_1.Var1;
NbSpectra1_1=NbSpectraData1_1.Var2;
%plot(xNb1_1,NbSpectra1_1)

%Se
Path1_1_Se='C:\Users\Owner\Dropbox\QIL projects\NbSe2_thin vortex\TEM\Sample1\1348\SI HAADF 1348 - Spectrum Profile 0001-Se.txt';
SeSpectraData1_1 = readtable(Path1_1_Se);
xSe1_1=SeSpectraData1_1.Var1;
SeSpectra1_1=SeSpectraData1_1.Var2;
%plot(xSe1_1,SeSpectra1_1)

%Nitrogen
Path1_1_N='C:\Users\Owner\Dropbox\QIL projects\NbSe2_thin vortex\TEM\Sample1\1348\SI HAADF 1348 - Spectrum Profile 0001-N.txt';
NSpectraData1_1 = readtable(Path1_1_N);
xN1_1=NSpectraData1_1.Var1;
NSpectra1_1=NSpectraData1_1.Var2;
%plot(xN1_1,NSpectra1_1)

%Silicon
Path1_1_Si='C:\Users\Owner\Dropbox\QIL projects\NbSe2_thin vortex\TEM\Sample1\1348\SI HAADF 1348 - Spectrum Profile 0001-Si.txt';
SiSpectraData1_1 = readtable(Path1_1_Si);
xSi1_1=SiSpectraData1_1.Var1;
SiSpectra1_1=SiSpectraData1_1.Var2;
%plot(xSi1_1,SiSpectra1_1)

% % Sample 3 lammela 2
% %image
% Path3_2_Image='C:\Users\Owner\Desktop\Nofar\NbSe2\NbSe2\TEM\Sample 2\C1.Sp2.9\C1.Sp2.9\Data\SI HAADF 1542 HAADF.tif';
% Image = Tiff(Path3_2_Image,'r');
% imageData3_2=read(Image);
% 
% %Oxygen
% Path3_2_Oxigen='C:\Users\Owner\Desktop\Nofar\NbSe2\NbSe2\TEM\Sample 2\C1.Sp2.9\C1.Sp2.9\Data\SI HAADF 1542 O-net.tif';
% Oxygen_Image = Tiff(Path3_2_Oxigen,'r');
% Oxygen_Image_Data3_2=read(Oxygen_Image);
% 
% %Nb
% Path3_2_Nb='C:\Users\Owner\Desktop\Nofar\NbSe2\NbSe2\TEM\Sample 2\C1.Sp2.9\C1.Sp2.9\Data\SI HAADF 1542 Nb-net.tif';
% Nb_Image = Tiff(Path3_2_Nb,'r');
% Nb_Image_Data3_2=read(Nb_Image);
% 
% %Se
% Path3_2_Se='C:\Users\Owner\Desktop\Nofar\NbSe2\NbSe2\TEM\Sample 2\C1.Sp2.9\C1.Sp2.9\Data\SI HAADF 1542 Se-net.tif';
% Se_Image = Tiff(Path3_2_Se,'r');
% Se_Image_Data3_2=read(Se_Image);
% 
% %Nitrogen
% Path3_2_Nitrogen='C:\Users\Owner\Desktop\Nofar\NbSe2\NbSe2\TEM\Sample 2\C1.Sp2.9\C1.Sp2.9\Data\SI HAADF 1542 N-net.tif';
% Nitrogen_Image = Tiff(Path3_2_Nitrogen,'r');
% Nitrogen_Image_Data3_2=read(Nitrogen_Image);

% % Sample 4 lammela 1
% %image
% Path4_1_Image='C:\Users\Owner\Dropbox\QIL projects\NbSe2_thin vortex\TEM\Tomer\SI HAADF.tif';
% Image = Tiff(Path4_1_Image,'r');
% imageData4_1=read(Image);
% 
% %Oxygen
% Path4_1_Oxigen='C:\Users\Owner\Dropbox\QIL projects\NbSe2_thin vortex\TEM\Tomer\SI HAADF O.tif';
% Oxygen_Image = Tiff(Path4_1_Oxigen,'r');
% Oxygen_Image_Data4_1=read(Oxygen_Image);
% 
% %Nb
% Path4_1_Nb='C:\Users\Owner\Dropbox\QIL projects\NbSe2_thin vortex\TEM\Tomer\SI HAADF Nb.tif';
% Nb_Image = Tiff(Path4_1_Nb,'r');
% Nb_Image_Data4_1=read(Nb_Image);
% 
% %Se
% Path4_1_Se='C:\Users\Owner\Dropbox\QIL projects\NbSe2_thin vortex\TEM\Tomer\SI HAADF Se.tif';
% Se_Image = Tiff(Path4_1_Se,'r');
% Se_Image_Data4_1=read(Se_Image);
% 
% %Nitrogen
% Path4_1_Nitrogen='C:\Users\Owner\Dropbox\QIL projects\NbSe2_thin vortex\TEM\Tomer\SI HAADF N.tif';
% Nitrogen_Image = Tiff(Path4_1_Nitrogen,'r');
% Nitrogen_Image_Data4_1=read(Nitrogen_Image);
% 

%%  ploting surfaces
axes(figs(1,1))
surf(rot90(imageData1_1(1+92:1+308,1+92:1+308))) %%size
view(2)
shading flat
colormap('gray');
axis square
ylim([1 217])
xlim([1 217])


axes(figs(1,2))
surf(rot90(imageData5_2(49:49+128,250:378))) %%size
view(2)
shading flat
colormap('gray');
axis square
ylim([1 1+128])
xlim([1 1+128])

%% ploting graphs

%% EDS figure Format
% Figure - Fits and deferent images
clear
close all


% set figure
len=2.7; %cm
width=4.2; %cm

newfig=figure('NumberTitle', 'off', 'Name', 'Fit');
Position=[0.5 0.5 width len];
clf
set(newfig,'Units','in')
set(newfig,'Position',Position,'Color',[1 1 1])
fontcolor='k';
linewidth=1.2;
linewidth_curve=1.25;
fontsize=10;
FontName='Arial';
Multiplyer3Layer=6;
%Multiplyer6Layer=2;

[r,g,b]=Analyze_Support.Get_Gold();


% plot a
Xnum=1; %axis in X
Ynum=2; %axis in Y
% spaceX=(width-Xnum*X_size)/(Xnum+1);
% spaceY=(len-Ynum*Y_size)/(Ynum+1);
spaceX=0.15;
spaceY=0.09;
X_size=(width-0.12)/Ynum-spaceX-0.2;
factor=1;
Y_size=X_size*factor;
X0=0.4; %general offset
Y0=0.6;%general offset
% posfig=[spaceX spaceY X_size  Y_size];

for i=1:Xnum
    for j=1:Ynum
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
            'Position',posfig{i,j});
        box(figs(i,j),'off');    
        hold(figs(i,j),'all');
    end
end

% for i=2:Ynum
%     for j=1:Xnum
%         x0=X0+spaceX*j+X_size*(j-1);
%         y0=Y0+spaceY*i+Y_size*(i-1);
%         posfig(i,j)={[x0 y0 X_size Y_size]};
%         figs(i,j)=axes('Parent',newfig,...
%             'ZColor',fontcolor,'YColor',fontcolor,'XColor',fontcolor,...
%             'LineWidth',linewidth,...
%             'FontSize',fontsize,...
%             'FontName',FontName,...
%             'Color','none',...
%             'Units','in',...
%             'xticklabel',{''},...
%             'xtick',[],...
%             'colormap',[r g b],...            
%             'yticklabel',{''},...
%             'ytick',[],...
%             'XColor','none',...
%             'YColor','none',...
%             'YAxisLocation','right',...
%             'Position',posfig{i,j});
%         box(figs(i,j),'off');    
%         hold(figs(i,j),'all');
%     end
% end
%% loading data
% Sample 5 layers lammela 1
% Haadf
Path5_1_Image='C:\Users\Owner\Dropbox\QIL projects\NbSe2_thin vortex\TEM\5 layes\1003\SI_HAADF-DF4-DF2-BF_1003 - Spectrum Profile 0003 HAADF.tif';
Image5_1 = Tiff(Path5_1_Image,'r');
imageData5_1=read(Image5_1);

%Oxygen
Path5_1_O='C:\Users\Owner\Dropbox\QIL projects\NbSe2_thin vortex\TEM\5 layes\1003\SI_HAADF-DF4-DF2-BF_1003 - Spectrum Profile 0003-O.txt';
OSpectraData5_1 = readtable(Path5_1_O);
xO5_1=OSpectraData5_1.Var1;
OSpectra5_1=OSpectraData5_1.Var2;
%plot(xO5_1,OSpectra5_1)

%Nb
Path5_1_Nb='C:\Users\Owner\Dropbox\QIL projects\NbSe2_thin vortex\TEM\5 layes\1003\SI_HAADF-DF4-DF2-BF_1003 - Spectrum Profile 0003-Nb.txt';
NbSpectraData5_1 = readtable(Path5_1_Nb);
xNb5_1=NbSpectraData5_1.Var1;
NbSpectra5_1=NbSpectraData5_1.Var2;
%plot(xNb5_1,NbSpectra5_1)

%Se
Path5_1_Se='C:\Users\Owner\Dropbox\QIL projects\NbSe2_thin vortex\TEM\5 layes\1003\SI_HAADF-DF4-DF2-BF_1003 - Spectrum Profile 0003-Se.txt';
SeSpectraData5_1 = readtable(Path5_1_Se);
xSe5_1=SeSpectraData5_1.Var1;
SeSpectra5_1=SeSpectraData5_1.Var2;
%plot(xSe5_1,SeSpectra5_1)

%Nitrogen
Path5_1_N='C:\Users\Owner\Dropbox\QIL projects\NbSe2_thin vortex\TEM\5 layes\1003\SI_HAADF-DF4-DF2-BF_1003 - Spectrum Profile 0003-N.txt';
NSpectraData5_1 = readtable(Path5_1_N);
xN5_1=NSpectraData5_1.Var1;
NSpectra5_1=NSpectraData5_1.Var2;
%plot(xN5_1,NSpectra5_1)

%Silicon
Path5_1_Si='C:\Users\Owner\Dropbox\QIL projects\NbSe2_thin vortex\TEM\5 layes\1003\SI_HAADF-DF4-DF2-BF_1003 - Spectrum Profile 0003-Si.txt';
SiSpectraData5_1 = readtable(Path5_1_Si);
xSi5_1=SiSpectraData5_1.Var1;
SiSpectra5_1=SiSpectraData5_1.Var2;
%plot(xSi5_1,SiSpectra5_1)


% Sample 5 layers lammela 1 Second image
% Haadf
Path5_2_Image='C:\Users\Owner\Dropbox\QIL projects\NbSe2_thin vortex\TEM\5 layes\1019\SI_HAADF-DF4-DF2-BF_1019 - Spectrum Profile 0002 HAADF.tif';
Image5_2 = Tiff(Path5_2_Image,'r');
imageData5_2=read(Image5_2);

%Oxygen
Path5_2_O='C:\Users\Owner\Dropbox\QIL projects\NbSe2_thin vortex\TEM\5 layes\1019\SI_HAADF-DF4-DF2-BF_1019 - Spectrum Profile 0002-O.txt';
OSpectraData5_2 = readtable(Path5_2_O);
xO5_2=OSpectraData5_2.Var1;
OSpectra5_2=OSpectraData5_2.Var2;
%plot(xO5_2,OSpectra5_2)

%Nb
Path5_2_Nb='C:\Users\Owner\Dropbox\QIL projects\NbSe2_thin vortex\TEM\5 layes\1019\SI_HAADF-DF4-DF2-BF_1019 - Spectrum Profile 0002-Nb.txt';
NbSpectraData5_2 = readtable(Path5_2_Nb);
xNb5_2=NbSpectraData5_2.Var1;
NbSpectra5_2=NbSpectraData5_2.Var2;
%plot(xNb5_2,NbSpectra5_2)

%Se
Path5_2_Se='C:\Users\Owner\Dropbox\QIL projects\NbSe2_thin vortex\TEM\5 layes\1019\SI_HAADF-DF4-DF2-BF_1019 - Spectrum Profile 0002-Se.txt';
SeSpectraData5_2 = readtable(Path5_2_Se);
xSe5_2=SeSpectraData5_2.Var1;
SeSpectra5_2=SeSpectraData5_2.Var2;
%plot(xSe5_2,SeSpectra5_2)

%Nitrogen
Path5_2_N='C:\Users\Owner\Dropbox\QIL projects\NbSe2_thin vortex\TEM\5 layes\1019\SI_HAADF-DF4-DF2-BF_1019 - Spectrum Profile 0002-N.txt';
NSpectraData5_2 = readtable(Path5_2_N);
xN5_2=NSpectraData5_2.Var1;
NSpectra5_2=NSpectraData5_2.Var2;
%plot(xN5_2,NSpectra5_2)

%Silicon
Path5_2_Si='C:\Users\Owner\Dropbox\QIL projects\NbSe2_thin vortex\TEM\5 layes\1019\SI_HAADF-DF4-DF2-BF_1019 - Spectrum Profile 0002-Si.txt';
SiSpectraData5_2 = readtable(Path5_2_Si);
xSi5_2=SiSpectraData5_2.Var1;
SiSpectra5_2=SiSpectraData5_2.Var2;
%plot(xSi5_2,SiSpectra5_2)

% % Sample 1 lammela 2
% %image
% Path1_2_Image='C:\Users\Owner\Desktop\Nofar\NbSe2\NbSe2\TEM\Sample 1\A2.Sp1-45\A2.Sp1-45\Data\SI HAADF 1348 HAADF.tif';
% Image = Tiff(Path1_2_Image,'r');
% imageData1_2=read(Image);
% 
% %Oxygen
% Path1_2_Oxigen='C:\Users\Owner\Desktop\Nofar\NbSe2\NbSe2\TEM\Sample 1\A2.Sp1-45\A2.Sp1-45\Data\SI HAADF 1348 O-net.tif';
% Oxygen_Image = Tiff(Path1_2_Oxigen,'r');
% Oxygen_Image_Data1_2=read(Oxygen_Image);
% 
% %Nb
% Path1_2_Nb='C:\Users\Owner\Desktop\Nofar\NbSe2\NbSe2\TEM\Sample 1\A2.Sp1-45\A2.Sp1-45\Data\SI HAADF 1348 Nb-net.tif';
% Nb_Image = Tiff(Path1_2_Nb,'r');
% Nb_Image_Data1_2=read(Nb_Image);
% 
% %Se
% Path1_2_Se='C:\Users\Owner\Desktop\Nofar\NbSe2\NbSe2\TEM\Sample 1\A2.Sp1-45\A2.Sp1-45\Data\SI HAADF 1348 Se-net.tif';
% Se_Image = Tiff(Path1_2_Se,'r');
% Se_Image_Data1_2=read(Se_Image);
% 
% %Nitrogen
% Path1_2_Nitrogen='C:\Users\Owner\Desktop\Nofar\NbSe2\NbSe2\TEM\Sample 1\A2.Sp1-45\A2.Sp1-45\Data\SI HAADF 1348 N-net.tif';
% Nitrogen_Image = Tiff(Path1_2_Nitrogen,'r');
% Nitrogen_Image_Data1_2=read(Nitrogen_Image);

% % Sample 2 lammela 1
% %image
% Path2_1_Image='C:\Users\Owner\Desktop\Nofar\NbSe2\NbSe2\TEM\5 Layer Sample 1\TEM\A.NbSe-1\A.NbSe-1\Data\SI_HAADF-DF4-DF2-BF_1003 HAADF.tif';
% Image = Tiff(Path2_1_Image,'r');
% imageData2_1=read(Image);
% 
% %Oxygen
% Path2_1_Oxigen='C:\Users\Owner\Desktop\Nofar\NbSe2\NbSe2\TEM\5 Layer Sample 1\TEM\A.NbSe-1\A.NbSe-1\Data\SI_HAADF-DF4-DF2-BF_1003 O-net.tif';
% Oxygen_Image = Tiff(Path2_1_Oxigen,'r');
% Oxygen_Image_Data2_1=read(Oxygen_Image);
% 
% %Nb
% Path2_1_Nb='C:\Users\Owner\Desktop\Nofar\NbSe2\NbSe2\TEM\5 Layer Sample 1\TEM\A.NbSe-1\A.NbSe-1\Data\SI_HAADF-DF4-DF2-BF_1003 Nb-net.tif';
% Nb_Image = Tiff(Path2_1_Nb,'r');
% Nb_Image_Data2_1=read(Nb_Image);
% 
% %Se
% Path2_1_Se='C:\Users\Owner\Desktop\Nofar\NbSe2\NbSe2\TEM\5 Layer Sample 1\TEM\A.NbSe-1\A.NbSe-1\Data\SI_HAADF-DF4-DF2-BF_1003 Se-net.tif';
% Se_Image = Tiff(Path2_1_Se,'r');
% Se_Image_Data2_1=read(Se_Image);
% 
% %Nitrogen
% Path2_1_Nitrogen='C:\Users\Owner\Desktop\Nofar\NbSe2\NbSe2\TEM\5 Layer Sample 1\TEM\A.NbSe-1\A.NbSe-1\Data\SI_HAADF-DF4-DF2-BF_1003 N-net.tif';
% Nitrogen_Image = Tiff(Path2_1_Nitrogen,'r');
% Nitrogen_Image_Data2_1=read(Nitrogen_Image);

% Sample 1 lammela 1
% Haadf
Path1_1_Image='C:\Users\Owner\Dropbox\QIL projects\NbSe2_thin vortex\TEM\Sample1\1348\SI HAADF 1348 - Spectrum Profile 0001 HAADF.tif';
Image1_1 = Tiff(Path1_1_Image,'r');
imageData1_1=read(Image1_1);

%Oxygen
Path1_1_O='C:\Users\Owner\Dropbox\QIL projects\NbSe2_thin vortex\TEM\Sample1\1348\SI HAADF 1348 - Spectrum Profile 0001-O.txt';
OSpectraData1_1 = readtable(Path1_1_O);
xO1_1=OSpectraData1_1.Var1;
OSpectra1_1=OSpectraData1_1.Var2;
%plot(xO1_1,OSpectra1_1)

%Nb
Path1_1_Nb='C:\Users\Owner\Dropbox\QIL projects\NbSe2_thin vortex\TEM\Sample1\1348\SI HAADF 1348 - Spectrum Profile 0001-Nb.txt';
NbSpectraData1_1 = readtable(Path1_1_Nb);
xNb1_1=NbSpectraData1_1.Var1;
NbSpectra1_1=NbSpectraData1_1.Var2;
%plot(xNb1_1,NbSpectra1_1)

%Se
Path1_1_Se='C:\Users\Owner\Dropbox\QIL projects\NbSe2_thin vortex\TEM\Sample1\1348\SI HAADF 1348 - Spectrum Profile 0001-Se.txt';
SeSpectraData1_1 = readtable(Path1_1_Se);
xSe1_1=SeSpectraData1_1.Var1;
SeSpectra1_1=SeSpectraData1_1.Var2;
%plot(xSe1_1,SeSpectra1_1)

%Nitrogen
Path1_1_N='C:\Users\Owner\Dropbox\QIL projects\NbSe2_thin vortex\TEM\Sample1\1348\SI HAADF 1348 - Spectrum Profile 0001-N.txt';
NSpectraData1_1 = readtable(Path1_1_N);
xN1_1=NSpectraData1_1.Var1;
NSpectra1_1=NSpectraData1_1.Var2;
%plot(xN1_1,NSpectra1_1)

%Silicon
Path1_1_Si='C:\Users\Owner\Dropbox\QIL projects\NbSe2_thin vortex\TEM\Sample1\1348\SI HAADF 1348 - Spectrum Profile 0001-Si.txt';
SiSpectraData1_1 = readtable(Path1_1_Si);
xSi1_1=SiSpectraData1_1.Var1;
SiSpectra1_1=SiSpectraData1_1.Var2;
%plot(xSi1_1,SiSpectra1_1)

% % Sample 3 lammela 2
% %image
% Path3_2_Image='C:\Users\Owner\Desktop\Nofar\NbSe2\NbSe2\TEM\Sample 2\C1.Sp2.9\C1.Sp2.9\Data\SI HAADF 1542 HAADF.tif';
% Image = Tiff(Path3_2_Image,'r');
% imageData3_2=read(Image);
% 
% %Oxygen
% Path3_2_Oxigen='C:\Users\Owner\Desktop\Nofar\NbSe2\NbSe2\TEM\Sample 2\C1.Sp2.9\C1.Sp2.9\Data\SI HAADF 1542 O-net.tif';
% Oxygen_Image = Tiff(Path3_2_Oxigen,'r');
% Oxygen_Image_Data3_2=read(Oxygen_Image);
% 
% %Nb
% Path3_2_Nb='C:\Users\Owner\Desktop\Nofar\NbSe2\NbSe2\TEM\Sample 2\C1.Sp2.9\C1.Sp2.9\Data\SI HAADF 1542 Nb-net.tif';
% Nb_Image = Tiff(Path3_2_Nb,'r');
% Nb_Image_Data3_2=read(Nb_Image);
% 
% %Se
% Path3_2_Se='C:\Users\Owner\Desktop\Nofar\NbSe2\NbSe2\TEM\Sample 2\C1.Sp2.9\C1.Sp2.9\Data\SI HAADF 1542 Se-net.tif';
% Se_Image = Tiff(Path3_2_Se,'r');
% Se_Image_Data3_2=read(Se_Image);
% 
% %Nitrogen
% Path3_2_Nitrogen='C:\Users\Owner\Desktop\Nofar\NbSe2\NbSe2\TEM\Sample 2\C1.Sp2.9\C1.Sp2.9\Data\SI HAADF 1542 N-net.tif';
% Nitrogen_Image = Tiff(Path3_2_Nitrogen,'r');
% Nitrogen_Image_Data3_2=read(Nitrogen_Image);

% % Sample 4 lammela 1
% %image
% Path4_1_Image='C:\Users\Owner\Dropbox\QIL projects\NbSe2_thin vortex\TEM\Tomer\SI HAADF.tif';
% Image = Tiff(Path4_1_Image,'r');
% imageData4_1=read(Image);
% 
% %Oxygen
% Path4_1_Oxigen='C:\Users\Owner\Dropbox\QIL projects\NbSe2_thin vortex\TEM\Tomer\SI HAADF O.tif';
% Oxygen_Image = Tiff(Path4_1_Oxigen,'r');
% Oxygen_Image_Data4_1=read(Oxygen_Image);
% 
% %Nb
% Path4_1_Nb='C:\Users\Owner\Dropbox\QIL projects\NbSe2_thin vortex\TEM\Tomer\SI HAADF Nb.tif';
% Nb_Image = Tiff(Path4_1_Nb,'r');
% Nb_Image_Data4_1=read(Nb_Image);
% 
% %Se
% Path4_1_Se='C:\Users\Owner\Dropbox\QIL projects\NbSe2_thin vortex\TEM\Tomer\SI HAADF Se.tif';
% Se_Image = Tiff(Path4_1_Se,'r');
% Se_Image_Data4_1=read(Se_Image);
% 
% %Nitrogen
% Path4_1_Nitrogen='C:\Users\Owner\Dropbox\QIL projects\NbSe2_thin vortex\TEM\Tomer\SI HAADF N.tif';
% Nitrogen_Image = Tiff(Path4_1_Nitrogen,'r');
% Nitrogen_Image_Data4_1=read(Nitrogen_Image);
% 
%%

axes(figs(1,1))
plot(xO1_1(1:217).*1e9,flip(OSpectra1_1(end-308:end-92))*100,'c') %%size
hold on
plot(xNb1_1(1:217).*1e9,flip(NbSpectra1_1(end-308:end-92))*100,'m') %%size
plot(xSe1_1(1:217).*1e9,flip(SeSpectra1_1(end-308:end-92))*100,'g') %%size
plot(xN1_1(1:217).*1e9,flip(NSpectra1_1(end-308:end-92))*100,'r') %%size
plot(xSi1_1(1:217).*1e9,flip(SiSpectra1_1(end-308:end-92))*100,'y') %%size
ylim([0 100])
xlim([0 xN1_1(217)*1e9])


axes(figs(1,2))
set(gca,'YColor','none')
plot(xO5_2(1:129).*1e9,flip(OSpectra5_2(end-50-126:end-48))*100,'c') %%size
hold on
plot(xNb5_2(1:129).*1e9,flip(NbSpectra5_2(end-50-126:end-48))*100,'m') %%size
plot(xSe5_2(1:129).*1e9,flip(SeSpectra5_2(end-50-126:end-48))*100,'g') %%size
plot(xN5_2(1:129).*1e9,flip(NSpectra5_2(end-50-126:end-48))*100,'r') %%size
plot(xSi5_2(1:129).*1e9,flip(SiSpectra5_2(end-50-126:end-48))*100,'y') %%size
ylim([0 100])
xlim([0 xSi5_2(129)*1e9])


mar=0.02;
a=text(figs(1,1),mar,Y_size+5*mar,'a','Units','in','Color','k','FontSize',12,'FontName',FontName);
b=text(figs(1,2),mar,Y_size+5*mar,'b','Units','in','Color','k','FontSize',12,'FontName',FontName);
XLabelePanelea=text(figs(1,1),0.65,-0.3,'x (nm)','Units','in','Color','k','FontSize',12,'FontName',FontName);
XLabelePaneleb=text(figs(1,2),0.65,-0.3,'x (nm)','Units','in','Color','k','FontSize',12,'FontName',FontName);
YLabelePanelea=text(figs(1,1),-0.4,0.4,'Atomic %','Units','in','Rotation',90,'Color','k','FontSize',12,'FontName',FontName);

Oxigen=text(figs(1,2),X_size-10*mar,Y_size-21*mar,'O','Units','in','Color','c','FontSize',10,'FontName',FontName);
Nb=text(figs(1,2),X_size-10*mar,Y_size-28*mar,'Nb','Units','in','Color','m','FontSize',10,'FontName',FontName);
Se=text(figs(1,2),X_size-10*mar,Y_size-35*mar,'Se','Units','in','Color','g','FontSize',10,'FontName',FontName);
N=text(figs(1,2),X_size-10*mar,Y_size-42*mar,'N','Units','in','Color','r','FontSize',10,'FontName',FontName);
Si=text(figs(1,2),X_size-10*mar,Y_size-49*mar,'Si','Units','in','Color','y','FontSize',10,'FontName',FontName);