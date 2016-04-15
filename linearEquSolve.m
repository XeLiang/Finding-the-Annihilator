function EquCheck = linearEquSolve(result, Fun, H, initialState)
    %��ʱ���ڴ˴������г�����1�����
    index = find(result == 1);
    Q = getTransferFun(H, max(index));
    coefficientMat = zeros([length(index), length(H)]);
    for i = 1:length(index)
        coefficientMat(i, :) = getEquCoefficient(Fun, Q{index(i) - 1});
    end
    EquCheck = sum(mod(coefficientMat * initialState',2));%��ʱ����д��ô��ģ2���������Է����麯����ֻ��check
end

function F = getTransferFun(H, k)
    n = length(H);
    Q = zeros([n, n]);
    temp = eye(n - 1);
    Q(2:end, 1:end - 1) = temp;
    Q(:, end) = H';  %�趨ת�ƺ���Q
    F = cell(1, k);
    F{1} = Q;
    for i = 2:k
        F{i} = mod(F{i - 1} * Q, 2); 
    end
end

function coefficient = getEquCoefficient(Fun, Q)
    coefficient = mod( sum( Q(:, Fun), 2), 2);
end

