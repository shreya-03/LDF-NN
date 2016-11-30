[class,tgt2]=readData();
d=64;
nh=8;
o=2;
N=291;
eta=0.01;
y=zeros(1,8);
z=zeros(291,2);
net_y=zeros(1,8);
net_z=zeros(291,2);
w1=repmat(1/sqrt(d)-0.01,8,64);
w2=repmat(1/sqrt(nh)-0.01,2,8);
%{
j=1;
while(j<=nh)
    w1(j,:)=-1/sqrt(d)+(2/sqrt(d)*rand(1,64));
    j=j+1;
end
%disp(w1);
k=1;
while(k<=o)
    w2(k,:)=-1/sqrt(nh)+(2/sqrt(nh)*rand(1,8));
    k=k+1;
end
%}
%disp(w2);
%feed forwarding operation
i=1;
while(i<=N)
    j=1;
    while(j<=nh)
        net_y(j)=1/sqrt(d)-0.01+(w1(j,:)*transpose(class(i,:)));
        y(j)=sigmf(net_y(j),[1 0]);
        j=j+1;
    end
%    disp(net_y);
    k=1;
    while(k<=o)
        net_z(i,k)=(w2(k,:)*transpose(y))+1/sqrt(nh)-0.01;
        z(i,k)=sigmf(net_z(i,k),[1 0]);
        k=k+1;
    end
    i=i+1;
end
%disp(net_z);
disp(z);
%error=0.5*norm(tgt2-z);
%disp(error);
%backpropagation operation
while(1)
    n=1;
    while(n<=N)
        k=1;
        while(k<=o)
            j=1;
            while(j<=nh)
                w2(k,j)=w2(k,j)+eta*(tgt2(n,k)-z(n,k))*sigmf(net_z(n,k),[1 0])*(1-sigmf(net_z(n,k),[1 0]))*y(j);
                j=j+1;
            end
            k=k+1;
        end
        j=1;
        while(j<=nh)
            i=1;
            while(i<=d)
                k=1;
                w=0;
                while(k<=o)
                    delta_z=(tgt2(n,k)-z(n,k))*sigmf(net_z(n,k),[1 0])*(1-sigmf(net_z(n,k),[1 0]));
                    w=w+w2(k,j)*delta_z;
                    k=k+1;
                end
                w1(j,i)=w1(j,i)+eta*w*sigmf(net_y(j),[1 0])*(1-sigmf(net_y(j),[1 0]))*class(n,i);
                i=i+1;
            end
            j=j+1;
        end
        n=n+1;
    end
%    disp(w1);
%    disp(w2);
% feed forwarding operation    
    i=1;
    while(i<=N)
        j=1;
        while(j<=nh)
            net_y(j)=1/sqrt(d)-0.01+(w1(j,:)*transpose(class(i,:)));
            y(j)=sigmf(net_y(j),[1 0]);
            j=j+1;
        end
%       disp(net_y);
        k=1;
        while(k<=o)
            net_z(k)=(w2(k,:)*transpose(y))+1/sqrt(nh)-0.01;
            z(i,k)=sigmf(net_z(k),[1 0]);
            k=k+1;
        end
        i=i+1;
    end
%       disp(z);
    error=0.5*norm(tgt2-z);
    disp(error);
    if(error<1)
        break;
    end
%    disp(tgt2);
%    disp(z);
%    error=0.5*norm(tgt2-z);
%    disp(error);
%    if(error<1)
%        break;
%    end
end
