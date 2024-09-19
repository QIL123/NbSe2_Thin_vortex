function diff1 = pearl_min_functionACDistanceFromSampleDataDifferentiation(Data,X,Y,pixsize,xc,yc,coefs,phi_0,sel,Kernel,z)
pearl_length=coefs(1);
if numel(coefs)==2
    z=coefs(2);
end
   


%we add a line to Y to diff it later
Y(end+1,:)=((Y(2,1)-Y(1,1))+Y(end,1))+X(1,:)*0;
Y(:,end+1)=Y(:,1);
X(:,end+1)=((X(1,2)-X(1,1))+X(1,end))+X(1,:)*0;
X(end+1,:)=X(1,:);
[Model, Conv_Model]=pearlgen_no_mag(X,Y,xc,yc,pearl_length,z,phi_0,Kernel);
% Model=Model-(min(Model(:)));
% Conv_Model=Conv_Model-(min(Conv_Model(:)));

Conv_Model_diff=diff(Conv_Model(:,1:end-1))/pixsize;
Model_diff=diff(Model(:,1:end-1))/pixsize;

Model=Model(:,1:end-1);
Model=Model(1:end-1,:);

[a,b]=find(Model==max(Model(:))); %checks where we get max value a is row and b is col

%assuming we may have several points with the same max the canter of vortex is the center of the area
a=mean(a); 
b=mean(b); 
[aa,~]=find(round(Y,6)==round(yc,6),1); % finds y critical
[~,bb]=find(round(X,6)==round(xc,6),1); % finds x critical
%[aa-a,bb-b];
%Shifting to maximum location

Model_diff=circshift(Model_diff,[aa-a,bb-b]);
Conv_Model_diff=circshift(Conv_Model_diff,[aa-a,bb-b]);


if ~isempty(Kernel)
    diff1=sum(sum((((Data-(Conv_Model_diff)).^2).*sel)));
else
    
    diff1=sum(sum(((Data-(Model_diff)).^2).*sel));
end