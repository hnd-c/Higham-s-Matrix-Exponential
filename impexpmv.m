
function[F]=impexpmv(A,B)
    tol=2^(-53);
    n=size(A,1);
    o=size(A,2);
    mu=trace(A)/n;
    A=A-mu*eye(n,o);
    if norm(A,1)==0
        m_opt=0;
        s_opt=1;
    else
       [m_opt,s_opt]=parameters(A);
    end
    F=B;
    eta=exp(mu/s_opt);
    for i=1:s_opt
        c1=norm(B,Inf);
        for j=1:m_opt
            B=A*B/(s_opt*j);
            c2=norm(B,Inf);
            F=F+B;
            if c1+c2<=tol*norm(F,Inf);
                break
            end
            c1=c2;
        end
        F=eta*F;
        B=F;
    end
end



