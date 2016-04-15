function [lowestAn, multiPart] = findLowestAnnihilator(Fun)
%     load('Info.mat');  %����ʱʹ��
    [lenGroupe, order] = sort(getLen(Fun));
    diffLen = unique(lenGroupe);
    Fun = Fun(order);
    f = Fun(lenGroupe == lenGroupe(end));
    
    [An_f, An_non_f] = getAnnihilatorSubset(f);
    [AI_f, I] = getLowPower(An_f, An_non_f, lenGroupe,length(lenGroupe) - 1);%�����㷨���ٲ���
    
    for i = length(diffLen) - 1:-1:1
        f = [f Fun(lenGroupe == diffLen(i))];%�����㷨���ڲ���
        [temp_f, temp_non_f] = getAnnihilatorSubset(f);
        [temp_AI_f, I] = getLowPower(temp_f, temp_non_f, diffLen,i - 1);
        if temp_AI_f < AI_f  %�ж���Ѱ��͵Ĵ������㻯��
            [An_f, An_non_f] = deal(temp_f, temp_non_f);
            AI_f = temp_AI_f;
        else
            break;
        end
    end
    
    multiPart = [];
    for j = i:-1:1
        multiPart = [multiPart Fun(lenGroupe == diffLen(j))];  %�������
    end
    if I == 1   %�ж�ʹ���ĸ�
        lowestAn = An_f;
    else
        lowestAn = An_non_f;
    end
end

function F = getLen(Fun)    %��Ҫ�����������ɺ����Ľ״Σ�������������F������
    for i = 1:length(Fun)
        F(i) = length(Fun{i});
    end
end

function [F, I] = getLowPower(An_f, An_non_f, lenGroup, i) %�������������Ǹ������Ƚϵͣ�ͬʱ��Ҫ�����������ᵽ��AI���ļ���
    [F, I] = min([checkPower(An_f), checkPower(An_non_f)]);
    if (i > 1)
        F = F + lenGroup(i);
    end 
end

function len = checkPower(An_f) %�˺����������е���С����
  len = Inf;temp = [];
  if ~isempty(An_f)
     for i = 1:length(An_f)
         if(len > length(An_f{i}))
              len = length(An_f{i});
              temp = An_f{i};
         end
     end
     if strfind(num2str(temp), '0')
         len = len - 1;
     end
  end
end