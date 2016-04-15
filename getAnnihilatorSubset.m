function [An_f, An_non_f] = getAnnihilatorSubset(Fun)  %�����������㷨1ʵ��
%     load('Info.mat'); %����ʱʹ��
    len = length(Fun);
    An_f = An(Fun{1});
    An_non_f = {An_non(Fun{1})};
    for i = 2:len
        temp_f = An(Fun{i});
        temp_non_f = {An_non(Fun{i})};
        An_f = addAndCaculateAn(An_f, An_non_f, temp_f, temp_non_f);
        An_non_f = addAndCaculateAn(An_non_f, An_f, temp_f, temp_non_f);% ѭ����������
    end
end

function answer = addAndCaculateAn(fs, fs_non, fi, fi_non)
     temp_1 = plus(fs, fi_non);  %���мӲ���
     temp_2 = plus(fs_non, fi);
     answer = intersectPart(temp_1, temp_2);  %ȡ��������
end

function F = An(f)  %���ݶ���2�����㻯�Ӽ�
    F = cell(1, length(f));
    for i = 1:length(f)
        F{i} = [0 f(i)];
    end
end

function F = An_non(f)%���ݶ���2�����㻯�Ӽ�
    F = f;
end

function F = plus(fs, fi)
    fs_str = getStr(fs);
    fi_str = getStr(fi);
    [~, ia, ib] = union(fs_str, fi_str);
    F = [fs(ia) fi(ib)];
end

function F = intersectPart(t1, t2)
    t1_str = getStr(t1);
    t2_str = getStr(t2);
    [~, ia, ~] = intersect(t1_str, t2_str);
    F = t1(ia);
end

function F = getStr(fs) %ת�����ַ����Ա���жԱȲ���
    F = cell(1, length(fs));
    for i = 1:length(fs)
        F{i} = num2str(fs{i});
    end
end
