function [Bz,ConvBz] = Abrikosov_Gen(X,Y,Lambda,z,Kernel,phi_0,imagesize)

r=sqrt((X).^2+(Y).^2+z.*(ones(size(X)).^2));
%Bz = -sqrt(Lambda.\r).*exp(-r.\Lambda);

Bz= (phi_0/(2*pi*Lambda^2)).*besselk(0,((r./Lambda)));

Bz=Bz-min(Bz(:)); %takes off the offset

if ~isempty(Kernel)
    ConvBz=conv2(Bz,Kernel,'same');    
else
    ConvBz=[];
end
end