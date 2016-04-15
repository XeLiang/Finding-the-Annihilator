function findAnnihilator(n)
printFlag = 1;  %�Ƿ������ʾ
%%   
% while(1)  %��дwhile ��Ҫ��Ϊ��������ɺ����ҵͽ��㻯��  ����30��һ��ȡ��ע������ ��Ҫ������ɽϵͽ��㻯���뿴��24��
    try

%�������LFSR�����Լ�����
    n = 30;
    initialState = round(rand([1,n]));  %��ʼ������
    H = creatLFSR(n);  %LFSR�����ɶ���ʽ���� n����LFSRλ��
    Fun = creatRandomFun(n); %��������ĺ���f��ʱ����Ϊ����part����Ϊn  
    save('Info.mat', 'initialState', 'H', 'Fun');
    
%%    
%     load('Info.mat');  %��ʹ�ö�ȡ����mat�ļ�����ע��֮ǰ���ɲ��ִ���

    num = 9999; %�����������������{z}����
    
    sequence = generateSequence(initialState, H, num);  %�����㹻�������
    result = caculateFun(sequence, Fun); %�����Ѿ��е����У���������   
    [lowestAn, multiPart] = findLowestAnnihilator(Fun);  %Ѱ�ҵͽ��㻯��
    checkResult = checkAnnihilator(sequence, result, lowestAn, multiPart);  %�Ե�ǰ���ɵ����д�����ֵ���㻯�ӽ�����֤
    flag = verifyFun(Fun, lowestAn, multiPart);   %�Ե�ǰ���ɵ��㻯�Ӵ��뷽��չ��������֤   %ע��multiPart��1������
%      if(checkResult == 0 && checkPower(multiPart) < 4 )
%             a = 4;break;
%      end  %�ⲿ����Ҫ����ǿ�ƶ���Զ����ɺ���Ѱ�ҵͽ��㻯��
    catch
        fprintf('��Ǹ���޷��ҵ���ǰ�����㻯�ӣ����������ɺ�����\n');
    end
% end
    if(printFlag)
        if(checkResult == 0 && flag == 1)
            fprintf('�ѳɹ��ҵ���ǰ�������㻯�ӣ������Ϣ�Ѵ���Info.mat�У�\n');
        else
            fprintf('δ�ܳɹ��ҵ���ǰ�����㻯�ӣ����ٴ����к���\n');
        end
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

function len = checkPower(An_f) %�����ڲ�����߽���
  len = -Inf;temp = [];
  if ~iscell(An_f)
      An_f = {An_f};
  end
  if ~isempty(An_f)
     for i = 1:length(An_f)
         if(len < length(An_f{i}))
              len = length(An_f{i});
              temp = An_f{i};
         end
     end
     if strfind(num2str(temp), '0')
         len = len - 1;
     end
  end
end