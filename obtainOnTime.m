function [inputRawData] = obtainOnTime( inputRawData )
%删除被统计的列表项
disp(size(inputRawData,1) - sum(inputRawData(:,12)));
for i=1: size(inputRawData,1)-sum(inputRawData(:,12));
    while(inputRawData(i,12)==1)
        inputRawData(i,:)=[];
    end
end
end

