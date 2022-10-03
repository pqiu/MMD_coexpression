function [testStat] = mmdTestBoot(X,Y,params);
    
m=size(X,1);
%Set kernel size to median distance between points in aggregate sample
if params.sig == -1
  Z = [X;Y];  %aggregate the sample
  size1=size(Z,1);
    if size1>100
      Zmed = Z(1:100,:);
      size1 = 100;
    else
      Zmed = Z;
    end
    G = sum((Zmed.*Zmed),2);
    Q = repmat(G,1,size1);
    R = repmat(G',size1,1);
    dists = Q + R - 2*Zmed*Zmed';
    dists = dists-tril(dists);
    dists=reshape(dists,size1^2,1);
    params.sig = sqrt(0.5*median(dists(dists>0)));  %rbf_dot has factor two in kernel
end

K = rbf_dot(X,X,params.sig);
L = rbf_dot(Y,Y,params.sig);
KL = rbf_dot(X,Y,params.sig);

[mk, nk] = size(K);
[ml, nl] = size(L);

testStat = sum(sum(K))/(mk^2);
testStat = testStat + sum(sum(L))/(ml^2);
testStat = testStat - 2*sum(sum(KL))/(mk*ml);
end
