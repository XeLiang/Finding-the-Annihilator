function generateLatex()
load('Info.mat');
f = fopen('latex.txt', 'wt');
count = 0;
fprintf(f,'f&=');
[~, order] = sort(getLen(Fun));
Fun = Fun(order);
for i = 1:length(Fun)
    for j = 1:length(Fun{i})
        temp = Fun{i};
        fprintf(f,'x_{%d}',temp(j));
        count = count+1;
        if(count >= 20)
          fprintf(f,'\\\\');
          count = 0;
        end
    end
    if(i ~= length(Fun))
        fprintf(f, '+');
    end
    count = count + 1;
end
fclose(f);
end

function F = getLen(Fun)    %��Ҫ�����������ɺ����Ľ״Σ�������������F������
    for i = 1:length(Fun)
        F(i) = length(Fun{i});
    end
end