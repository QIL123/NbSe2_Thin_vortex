clear all
close all
clc
%%

load('Paper Figures\Supplementary\Multy_Vortex_Sim\SimulationSingleVortex100Distance360.mat')

M=MagneticSignal;
r=2.6;
DistanceFromSample=0.36;
tipradious=0.270/2;
mag=1;
phi_0=20.7;
TipResponse=1;
Magnetic_offset=0;
peak=[X(1,640) Y(640,1)];



%%
if isempty(peak)
    figure;surf(X,Y,M)
    m=mean(M(:));
    s=std(M(:));
    caxis([m-s m+s])
    caxis
    view(2);shading flat;
    [xx,yy] = ginput(1);
else
    xx=peak(1);
    yy=peak(2);
end
[~,xcut]=min(abs(X(1,:)-xx));
% xcut=X(1,ix);
[~,ycut]=min(abs(Y(:,1)-yy));
% ycut=Y(iy,1);
D=61;
er=1
while er & D>0
try
X=X(ycut-D:ycut+D,xcut-D:xcut+D);
Y=Y(ycut-D:ycut+D,xcut-D:xcut+D);
M=M(ycut-D:ycut+D,xcut-D:xcut+D);
er=0
catch
    D=D-1;
end
end


% factor=3;
% % Find peak automaticaly
% thresh=max(max(M))-(max(max(M))-min(min(M)))/factor;
% 
% 
% [xEx,yEx,zEx,c]=imextrema(tvFilter(M));
% xEx=X(1,xEx(zEx>thresh & c==1));
% yEx=Y(yEx(zEx>thresh & c==1),1);
% zEx=zEx(zEx>thresh & c==1);

%find peak manually

if isempty(peak)
    figure;surf(X,Y,M)
    view(2);shading flat;
    axis square
    [xx,yy] = ginput(1);
end
[~,ix]=min(abs(X(1,:)-xx));
xEx=X(1,ix);
[~,iy]=min(abs(Y(:,1)-yy));
yEx=Y(iy,1);

%Exclusion area
R=r+0.005; %[um]
R2=r-0.05; %[um]
sel=X*0;

for i=1:length(xEx)
    sel=sel+((xEx(i)-X).^2+(yEx(i)-Y).^2<R^2);
end
% substract plane

back=fit([X(sel==0),Y(sel==0)],M(sel==0),'poly11');
M=M-back(X,Y);

figure;surf(X,Y,M)
view(2);shading flat;
axis image

xc=xEx;
yc=yEx;
hold on
plot3(xc,yc,(xc./xc)*(max(M(:)+1)),'o')
hold off

Kernel= MaskGen(tipradious,X,0);
% Kernel=[];
[coef,Err] = Pearlfit_DC_AllOptions(M,X,Y,xc,yc,phi_0,DistanceFromSample,TipResponse,Magnetic_offset,sel,Kernel);

%Setting coefs from the fit
PearlLength=coef(1)
if numel(coef)==3
    DistanceFromSample=coef(2);
    Magnetic_offset=coef(3);
    M=M-Magnetic_offset;
elseif numel(coef)==2
    if isempty(TipResponse)
        TipResponse=coef(2);
        M=M./TipResponse;   %%normalizing the data
    elseif isempty(DistanceFromSample)
        DistanceFromSample=coef(2);
    elseif isempty(Magnetic_offset)
        Magnetic_offset=coef(2);
        M=M-Magnetic_offset;
    end
end


% thick=0.01;
figure(1515)
subplot(1,3,1)
hold off
% surf(X(aa-l:aa+l,bb-l:bb+l),Y(aa-l:aa+l,bb-l:bb+l),M(aa-l:aa+l,bb-l:bb+l));
surf(X,Y,M)
view(2);
shading flat 
hold on
% 
t=[0:pi/20:2*pi];

for i=1:length(xEx)
    plot3(xEx(i)+R*cos(t),yEx(i)+R*sin(t),R*cos(t)*0+abs(max(max(M)))*1.1,'k')
    plot3(xEx(i)+R2*cos(t),yEx(i)+R2*sin(t),R2*cos(t)*0+abs(max(max(M)))*1.1,'k')
    
    plot3(xEx(i)+r*cos(t),yEx(i)+r*sin(t),r*cos(t)*0+abs(max(max(M)))*1.1,'r')
    
    text(xEx(i),yEx(i),abs(max(max(M))),num2str(i))
    %plot3(xEx(i),yEx(i),abs(max(max(M))),'.','markersize',10,'color',[1 1 1]*0)
end
[Bz,ConvBz] = pearlgen_no_mag(X,Y,xc,yc,PearlLength,DistanceFromSample,phi_0,Kernel)
axis square
hold off
% axis off
% figure(124)
figure(1515)
subplot(1,3,2)
% surf(X(aa-l:aa+l,bb-l:bb+l),Y(aa-l:aa+l,bb-l:bb+l),M(aa-l:aa+l,bb-l:bb+l)-Bz(aa-l:aa+l,bb-l:bb+l))
surf(X,Y,M-ConvBz)
view(2);
shading flat;
caxis([min(min(M)) max(max(M))])
axis square

hold off

fig=figure(1515);
subplot(1,3,3)
% surf(X(aa-l:aa+l,bb-l:bb+l),Y(aa-l:aa+l,bb-l:bb+l),Bz(aa-l:aa+l,bb-l:bb+l))
surf(X,Y,ConvBz)
view(2);
shading flat;
fig.WindowState = 'maximized';

caxis([min(min(M)) max(max(M))])
axis square
hold off
sgtitle(['Pearl fit for ultra-thin simulation. PL = ',num2str(PearlLength),' Dist = ',num2str(DistanceFromSample)])
% while isfile(fn)
%     fn=[fn(1:55),'_',num2str(add),'.jpg'];
%     add=add+1;
% end
% pause(6)
% exportgraphics(fig,fn)

% [Bz,ConvBz] = pearlgen(X,Y,xc,yc,coef(1),coef(2),phi_0,mag,Kernel);

figure(555)
subplot(4,4,[1 2 5 6])
surf(X,Y,M)
shading interp
title('Data')
axis equal
subplot(4,4,[3 4 7 8])
surf(X,Y,ConvBz)
shading interp
title('Model')
caxis([min(M(:)),max(M(:))])
axis equal
subplot(4,4,[9 10 13 14])
surf(X,Y,M-ConvBz)
shading interp
title('Residuals')
axis equal
caxis([min(M(:)),max(M(:))])
subplot(4,4,[11 12])
title('Cross-Section')
[~,bb]=find(X==xc,1);
plot(X(1,:),M(:,bb))
xlabel('y [\mum]')
ylabel('B [G]')
grid on
axis([X(1,1) X(1,end) min(M(:)),max(M(:))+(max(M(:))/10)])
hold on
plot(X(1,:),ConvBz(:,bb))
hold off
legend('Data','Model')
subplot(4,4,[15 16])
title('Cross-Section')
[aa,~]=find(Y==yc,1);
plot(Y(:,1),M(aa,:))
xlabel('x [\mum]')
ylabel('B [G]')
grid on
axis([Y(1,1) Y(end,1) min(M(:)),max(M(:))+(max(M(:))/10)])
hold on
plot(Y(:,1),ConvBz(aa,:))
legend('Data','Model')
hold off
sgtitle([' Pearl Length=',num2str(PearlLength),' scan dist=',num2str(DistanceFromSample)])

