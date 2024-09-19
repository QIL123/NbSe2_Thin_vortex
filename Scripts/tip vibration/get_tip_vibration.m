function [dx,dy,Min,Mout,dDCdy,C1,phase]=get_tip_vibration(MDC,MTFx,MTFy,x,y)
%given DC and Tunning fork data this function will give the
%real space oscillation of the tunning fork in x and in y, it will also
%give the tunning fork data roatated to one channel and the phase rotation


%transfer the tunning fork data into one channel the Min is that channel
%and the phase in the rotation needed to through all the data into that
%channel
Mx=MTFx;
My=MTFy;

[Min,Mout,phase]=phase_rotation_func(Mx,My);
xvect=x.*1e-6;
yvect=y.*1e-6;
NX=length(xvect);
NY=length(yvect);
DC=MDC;
dDCdx=zeros(size(DC));
dDCdy=zeros(size(DC));

warning('off','MATLAB:polyfit:RepeatedPointsOrRescale');
K=5;
for j=1:NY
    j1=max([1,j-K]);
    j2=min([NY,j+K]);

    for i=1:NX
        i1=max([1,i-K]);
        i2=min([NX,i+K]);
% a*sumx+b*n=sumDC
% a*sumx2+b*sumx=sumxDC
        n=i2-i1+1; 
        sumx=sum(xvect(i1:i2)); 
        sumx2=sum(xvect(i1:i2).^2); 
        sumDC=sum(DC(j,i1:i2)); 
        sumxDC=sum(xvect(i1:i2).*DC(j,i1:i2));
        dDCdx(j,i)=1/(n*sumx2-sumx^2)*(n*sumxDC-sumx*sumDC);

        n=j2-j1+1; 
        sumy=sum(yvect(j1:j2)); 
        sumy2=sum(yvect(j1:j2).^2); 
        sumDC=sum(DC(j1:j2,i)); 
        sumyDC=sum(yvect(j1:j2).*DC(j1:j2,i)');
        dDCdy(j,i)=1/(n*sumy2-sumy^2)*(n*sumyDC-sumy*sumDC);
    end
end
warning('on','MATLAB:polyfit:RepeatedPointsOrRescale');

N=NX*NY;
x=reshape(dDCdx,1,N);
y=reshape(dDCdy,1,N);
z=reshape(Min,1,N);

sumx=sum(x)/N;
sumy=sum(y)/N;
sumz=sum(z)/N;
sumx2=sum(x.^2)/N;
sumy2=sum(y.^2)/N;
sumxy=sum(x.*y)/N;
sumxz=sum(x.*z)/N;
sumyz=sum(y.*z)/N;

M=[sumx2,sumxy,sumx;sumxy,sumy2,sumy;sumx,sumy,1]; R=[sumxz;sumyz;sumz];
v=M\R;
dx=v(1); dy=v(2); C=v(3);

    figure(5);
    tiledlayout('flow','Padding', 'none', 'TileSpacing', 'compact');
    set(gcf, 'Position', [2811 654 1102 878],'Color','w')
    
    nexttile;
    surf(xvect*1e6,yvect*1e6,flip(DC,1)*1e3);
%     surf(xvect*1e6,yvect*1e6,log(abs(DC*1e3)));
    view(2);
    shading('flat');
    xlabel('X[\mum]');
    ylabel('Y[\mum]');
 
    title('V_{DC}')
    
    colorbar;
    axis equal tight;
    
    nexttile;
    surf(xvect*1e6,yvect*1e6,1e-6*flip(dDCdx,1));
    shading('flat');
    view(2);
    xlabel('X[\mum]');
    ylabel('Y[\mum]');
    title(['dV_{DC}/dx[mV/nm]']);
    colorbar;
    axis equal tight;

   nexttile;
    surf(xvect*1e6,yvect*1e6,1e-6*flip(dDCdy,1));
    shading('flat');
    view(2);
    xlabel('X');
    ylabel('Y');
    title(['dV_{DC}/dy[mV/nm]']);
    colorbar;
    axis equal tight;
    
    nexttile;
    surf(xvect*1e6,yvect*1e6,1e3*flip((dDCdx*dx+dDCdy*dy+C),1));
    shading('flat');
    view(2);
    xlabel('X[\mum]');
    ylabel('Y[\mum]');
    title(['v*grad(V_{DC}): dx=' num2str(1e9*dx) 'nm; dy=' num2str(1e9*dy) 'nm']);
%     caxis(CAC);
    colorbar;
    axis equal tight;

    nexttile;
    surf(xvect*1e6,yvect*1e6,flip(Min,1)*1e3);
    view(2);
    shading('flat');
    xlabel('X[\mum]');
    ylabel('Y[\mum]');
    title(['V_{TF} in phase[mV] rotated by \phi=' num2str(phase/pi*180)]);
    colorbar;
    axis equal tight;

    nexttile;
    surf(xvect*1e6,yvect*1e6,flip(Mout,1)*1e3);
    view(2);
    shading('flat');
    xlabel('X[\mum]');
    ylabel('Y[\mum]');
    title('V_{TF} offphase[mV]');
    colorbar;
    axis equal tight;
    
    nexttile;
    surf(xvect*1e6,yvect*1e6,flip(Min,1)*1e3-1e3*flip((dDCdx*dx+dDCdy*dy+C),1));
    view(2);
    shading('flat');
    xlabel('X[\mum]');
    ylabel('Y[\mum]');
    title('Error');
    colorbar;
    axis equal tight;
    
    disp(['rotated TF by phase=' num2str(180/pi*phase)]);
    disp(['dx,dy[nm]=' num2str(1e9*[dx,dy])]);
    phase=180/pi*phase;
    C1=dDCdx*dx+C;
copygraphics(gcf);
