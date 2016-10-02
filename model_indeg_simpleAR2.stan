data{
        int<lower=1> N;
        real<lower=0,upper=100> pi[N];//wage rate
        real<lower=0,upper=100> c[N];//cpi rate
        real<lower=0,upper=100> u[N];//unemployment
}

parameters{
    real delta[N];
    real gamma[N];
    real phi[N];
    
    real<lower=0> sdel;
    real<lower=0> sphi;
    real<lower=0> sg;

    real cdel[3];
    real cphi[3];
    real cg[3];
    
    real cn[N];
    real uu[N];
    
    real cc[3];
    real cu[3];

    real<lower=0> sp;
    real<lower=0> spo;
    real<lower=0> sc;
    real<lower=0> sco;
    real<lower=0> su;
    real<lower=0> suo;
    
    real p[N-1];
}

model{  
    for(i in 3:(N)){
      delta[i]~normal(cdel[1]+cdel[2]*delta[i-1]+cdel[3]*delta[i-2],sdel);
      phi[i]  ~normal(cphi[1]+cphi[2]*phi[i-1]+cphi[3]*phi[i-2],sphi);
      gamma[i]~normal(cg[1]+cg[2]*gamma[i-1]+cg[3]*gamma[i-2],sg);
      
      cn[i]~normal(cc[1]+cc[2]*cn[i-1]+cc[3]*cn[i-2],sc);
      uu[i]~normal(cu[1]+cu[2]*uu[i-1]+cu[3]*uu[i-2],su);      
    }
    
    for(i in 1:(N)){
        c[i]~normal(cn[i],sco);
        u[i]~normal(uu[i],suo);
    }
    
    for(i in 2:(N)){        
        p[i]~normal(delta[i]+gamma[i]*cn[i-1]+phi[i]*uu[i],spo);
    }
}  