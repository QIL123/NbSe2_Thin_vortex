function [Bz,ConvBz] = pearlgen_no_mag(X,Y,xc,yc,pearl_length,z,phi_0,Kernel)

% X
dx = X(1,2) - X(1,1); %um per pixel. pixel size
Wkx = 1/dx; %pixels per micron
Nx = size(X,2); %Number of data points in X
dFx = Wkx/Nx; % cycles per um. frequency increment
Fx = (-Wkx/2:dFx:Wkx/2-dFx); % from negative nyquist to positive nyquist in jumps of dF
kx = 2*pi*Fx; % in K-space 

% Y
dy = Y(2,1) - Y(1,1); %um per pixel. pixel size
Wky = 1/dy; %pixels per micron
Ny = size(Y,1); %Number of data points in Y
dFy = Wky/Ny; % cycles per um. frequency increment
Fy = (-Wky/2:dFy:Wky/2-dFy); % from negative nyquist to positive nyquist in jumps of dF
ky = 2*pi*Fy; % in K-space 

[Kx,Ky] = meshgrid(kx,ky);

ShiftFactor=1;
K=(Kx.^2 + Ky.^2).^0.5; % norm of k at each point
Bz_Kspace = phi_0*ShiftFactor * (exp(-K * z)) ./ (1 + K*pearl_length);

Bz = abs(fftshift(ifft2(ifftshift(Bz_Kspace))))/(dx*dy);% forier transforms to real field

Bz=Bz-min(Bz(:)); %takes off the offset
[a,b]=find(Bz==max(Bz(:))); %checks where we get max value a is row and b is col

%assuming we may have several points with the same max the canter of vortex is the center of the area
a=mean(a); 
b=mean(b); 
% [aa,~]=find(Y==yc,1); % finds y critical
% [~,bb]=find(X==xc,1); % finds x critical
%[aa-a,bb-b];
[aa,~]=find(round(Y,4)==round(yc,4),1); % finds y critical
[~,bb]=find(round(X,4)==round(xc,4),1); % finds x critical

%Shifting to maximum location
Bz=circshift(Bz,[aa-a,bb-b]); 

if ~isempty(Kernel)
    ConvBz=conv2(Bz,Kernel,'same');
    %figure;surf(X,Y,M)
    %hold on
    %figure;surf(X,Y,ConvBz)
    %hold off
else
    ConvBz=[];
end
end