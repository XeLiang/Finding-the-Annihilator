function easySolveEqu()
    n = 30;
    initialState = round(rand([1,n]));  %��ʼ������
    H = creatLFSR(n);  %LFSR�����ɶ���ʽ���� n����LFSRλ��
    Fun = {14,[1 3],[2 14],[1 2 3]}; %����ĺ���Ϊf = x14 + x1x3 + x2x14 + x1x2x3
    num = 9999;
    sequence = generateSequence(initialState, H, num);  %�����㹻�������
    result = caculateFun(sequence, Fun); %�����Ѿ��е����У���������   
    checkResult = checkAnnihilator(sequence, result, {2}, 0); %�㻯��Ϊf = x2
    EquCheck = linearEquSolve(result, [2], H, initialState);%��ʱ����д��ô��ģ2���������Է����麯����ֻ��check
    if(checkResult == 0 && EquCheck == 0)
        fprintf('������У��ɹ���\n');
    else
        fprintf('������У��ʧ�ܣ�\n'); 
    end
end


function H = creatLFSR(n)
    H =[1 round( rand( [1,n - 1]))]; %��֤����Ϊ���˻���
end

function matrix = generateSequence(initialState, H, num) %������Ҫ���ڲ����㹻�������
    n = length(initialState);
    Q = zeros([n, n]);
    temp = eye(n - 1);
    Q(2:end, 1:end - 1) = temp;
    Q(:, end) = H';  %�趨ת�ƺ���Q
    
    matrix = zeros([num, n]);
    matrix(1, :) = initialState;
    for i = 2:num
        matrix(i, :) = mod(matrix(i - 1, :) * Q, 2); %ѭ����������
    end
end