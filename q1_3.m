X=zeros(14,3);
X=[1 2 7;1 8 1;1 7 5;1 6 3;1 7 8;1 5 9;1 4 5;-1 -4 -2;-1 1 1;-1 -1 -3;-1 -3 2;-1 -5 -3.25;-1 -2 -4;-1 -7 -1];
original_X=[1 2 7;1 8 1;1 7 5;1 6 3;1 7 8;1 5 9;1 4 5;1 4 2;1 -1 -1;1 1 3;1 3 -2;1 5 3.25;1 2 4;1 7 1];
a=[1 0.3 0.7];
temp=zeros(1,3);
%disp(temp)
count=1;
flag=0;
while(flag==0)
    temp(1)=X(count);
    temp(2)=X(count+14);
    temp(3)=X(count+28);
    disp(temp);
    if dot(transpose(a),temp)<0.002
        a=a-1.2*((dot(transpose(a),temp)-0.002)/(1+temp(2)*temp(2)+temp(3)*temp(3)))*temp;
        count=1;
    elseif dot(transpose(a),temp)>=0.002
        count=count+1;
        if count==15
            flag=1;
        end
    end
%    disp(a)
end
figure;
x1=[2 8 7 6 7 5 4];
y1=[7 1 5 3 8 9 5];
scatter(x1,y1,'red');
hold on;
x2=[4 -1 1 3 5 2 7];
y2=[2 -1 3 -2 3.25 4 1];
scatter(x2,y2,'blue');
x=-1:9;
y=(-1*a(1)-(a(2)*x))/a(3);
plot(x,y);
count=1;
while(count<=14)
    temp(1)=original_X(count);
    temp(2)=original_X(count+14);
    temp(3)=original_X(count+28);
%    disp(temp)
    if dot(transpose(a),temp)>0
        scatter(temp(2),temp(3),'red','filled');
        hold on;
    else
        scatter(temp(2),temp(3),'blue','filled');
        hold on;
    end
    count=count+1;
end
title('relaxation procedure with no margin');