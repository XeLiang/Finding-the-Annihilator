function Fun = creatRandomFun(n)
    numOfPart = 0;
    while numOfPart == 0
        numOfPart = round(n * rand); %�趨��Ҫ���ٸ������� x1*x2+x1 ������part
    end
    
    Fun = cell(1, numOfPart);
    Fun_str = cell(1, numOfPart);
    for i = 1:numOfPart
        [Fun{i}, Fun_str{i}] = generatePart(n);
    end
    [~, index] = unique(Fun_str);  %ȥ��
    Fun = Fun(index);
end
function [F, F_str] = generatePart(n)    %����ÿ���Ӳ������ɺ���
    power = 0;
    while power == 0
        power = round(n * rand); %�趨�ܹ��Ľ״�
    end 
    randVar = randperm(n);  %�������һ������
    F = sort(randVar(1:power));   %ȡǰ��������Ϊ����
    F_str = num2str(F); %�������ַ������ں���ȥ��
end