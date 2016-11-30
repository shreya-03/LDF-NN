function[class,tgt2] =  readData()
    file = fopen('output.txt');
    class=[];
    tgt2 = [];
    line = fgetl(file);
    while ischar(line)
        arr = regexp(line, ',', 'split');
        feature = arr(1:64);
        feature = str2double(arr(1:64));
%        class = cell2mat(class);
        class = [class;feature];
        tgt2 = [tgt2;str2double(arr(64:65))];
        line = fgetl(file);
    end

end