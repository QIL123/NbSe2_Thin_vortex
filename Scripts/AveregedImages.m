function [DataDC,DataACX,DataACY,x,y,X,Y,Scan_Pixels,Scan_Range,pixsize]=AveregedImages(Year,Day,mounth,NameStart,nums,numsrot,TF_y_channel,TF_x_channel,DC_channel)
    DataACY=zeros(64);
    DataACX=zeros(64);
    DataDC=zeros(64);
    
    for i=1:length(nums)
        directory=cd;
        cutoff_i=regexp(directory,'Scripts');
        Path=sprintf('Imaging_Data\\%s\\%s\\%s\\SXM\\%s%s.sxm',Year,mounth,Day,NameStart,convertStringsToChars(nums(i)));

        correctdir=strcat(directory(1:cutoff_i-1),Path);

        sxmFile = sxm.load.loadProcessedSxM(correctdir);
        header=sxmFile.header;
    
        Scan_Pixels=sxmFile.header.scan_pixels;
    
        Scan_Range=sxmFile.header.scan_range;
    
        x=linspace(0,Scan_Range(1)*10^6,Scan_Pixels(1));
        y=linspace(0,Scan_Range(2)*10^6,Scan_Pixels(2));
        [X,Y]=meshgrid(x,y);            
        pixsize=x(2)-x(1);

        DataACYt=sxmFile.channels(TF_y_channel).rawData; %tunning fork channel Y backward
    
        DataACXt=sxmFile.channels(TF_x_channel).rawData; %tunning fork channel Y backward
    
        DataDCt=sxmFile.channels(DC_channel).rawData; %tunning fork channel Y backward

        if numsrot(i)
            DataACYt=rot90(DataACYt,3);
            DataACXt=rot90(DataACXt,3);
            DataDCt=rot90(DataDCt,3);
        end

    
        DataACY=DataACY+DataACYt;
        DataACX=DataACX+DataACXt;
        DataDC=DataDC+DataDCt;
    end
    DataACY=DataACY./length(nums);
    DataACX=DataACX./length(nums);
    DataDC=DataDC./length(nums);
end
