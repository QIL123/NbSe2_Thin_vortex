function Kernel= MaskGen(tipradious,X,flag)%%X is the line of pixels up to scale in a matrix of the size of frame
PxSize=(X(1,2)-X(1,1));%%calculate pixel size
numPixel=round(2*tipradious/PxSize); %tip diameter in units of pixels
G=zeros(numPixel+1); %creates a matrix of zeros of the size of tip diameter in units of pixels + 1
R=numPixel; %tip diameter in units of pixels
ii=ceil(max(size(G))/2);%tip radios in pixel units 
G(ii,ii)=1;%make the middle of the tip diameter matrix value 1
%bwdist takes the G matrix to a mat
Kernel=bwdist(G) <tipradious/PxSize;%creates a matrix of size G with radios of the tip in units of pixels
if flag %flag defined by user as 0
    figure
    imagesc(Kernel) %plots image that should be a circle of the size of the radios of the tip in units of pixels
end
Kernel=Kernel./sum(Kernel(:)); %normalizes kernel to 1
end