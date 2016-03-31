function [inputRawData] = obtainYearMonth( inputRawData )
%删除被统计的列表项
disp(size(inputRawData,1) - sum(inputRawData(:,13)));
for i=1: size(inputRawData,1)-sum(inputRawData(:,13));
    while(inputRawData(i,13)==1)
        inputRawData(i,:)=[];
    end
end
end

