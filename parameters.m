function[m_opt,s_opt]= parameters(A)
    p_max=8;
    m_max=55;
    theta = [ 2.22045e-16  2.58096e-8  1.38635e-5  0.000339717  0.00240088  0.00906566  0.0238446  0.0499123  0.0895776  0.144183  0.214236  0.299616  0.399778  0.513915  0.641084  0.780287  0.930533  1.09086  1.26038  1.43825  1.62372  1.81608  2.01471  2.21905  2.42858  2.64285  2.86145  3.084  3.31017  3.53967  3.77221  4.00756  4.2455  4.48582  4.72835  4.97292  5.21938  5.46759  5.71744  5.9688  6.22158  6.47568  6.73102  6.9875  7.24507  7.50365  7.76317  8.02359  8.28485  8.5469  8.80969  9.07319  9.33734  9.60212  9.8675  10.1334  10.3999  10.6669  10.9343  11.2022  11.4705  11.7392  12.0084  12.2778  12.5477  12.8178  13.0883  13.3591  13.6302  13.9016  14.1732  14.4451  14.7172  14.9896  15.2622  15.535  15.808  16.0812  16.3546  16.6281  16.9019  17.1758  17.4498  17.724  17.9984  18.2729  18.5476  18.8223  19.0972  19.3723  19.6474  19.9227  20.198  20.4735  20.7491  21.0248  21.3005  21.5764  21.8523  22.1284];
    A1=norm(A,1);
    if A1<=4*theta(m_max)*p_max*(p_max+3)
        m_intermediate=zeros(m_max,1);
        for i=1:m_max
           m_intermediate(i)=i*ceil(A1/theta(i));
        end
        [m_value,m_index] =min(m_intermediate);
        sz=size(m_intermediate);
        m_opt=m_index;
        s_opt=ceil(norm(A,1)/theta(m_max));
    else
        p_intermediate=zeros(p_max-1,1);
        for i=2:p_max
            p_intermediate(i-1,1)=normAm(A,i);
        end
         M = zeros(m_max,p_max-1);
        for p=2:p_max
            for m=p*(p-1)-1:m_max
                M(m,p-1)=m*ceil(p_intermediate(p-1,1)/theta(m));
            end
        end
        M (M == 0) = inf;
        sz=size(M);
        [c_star,m_star] = min(min(M'));
        m_opt=m_star;
        s_opt=max(c_star/m_opt,1)
    end
end 