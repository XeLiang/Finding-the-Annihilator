function result = caculateFun(seq, Fun)  %��Ը����ĺ����Լ����н��м���
    [m, ~] = size(seq);
    if(isempty(Fun))
        result = ones([1, m]); return;
    end
    if(~iscell(Fun))
       Fun = {Fun};   %�жϴ��������������ת��
    end 
    result = zeros([1, m]); 
    for i = 1:m
        temp = 0;
        for j = 1:length(Fun)
            tempFun = Fun{j};
            if(~isempty(find(tempFun == 0,1)))  %0����+1������������������г�����
                tempFun(tempFun == 0) = [];
                temp = temp + prod(seq(i, tempFun)) + 1;
            else
                temp = temp + prod(seq(i, tempFun));
            end            
        end
        result(i) =  mod(temp, 2); %�������mod2����
    end
end