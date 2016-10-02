data{
        int<lower=1> N;
        real<lower=0,upper=100> pi[N];//wage rate
        real<lower=0,upper=100> c[N];//cpi rate
        real<lower=0,upper=100> u[N];//unemployment
}

parameters{
    real delta;
    real gamma;
    real phi;
    
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
      cn[i]~normal(cc[1]+cc[2]*cn[i-1]+cc[3]*cn[i-2],sc);
      uu[i]~normal(cu[1]+cu[2]*uu[i-1]+cu[3]*uu[i-2],su);      
    }
    
    for(i in 1:(N)){
        c[i]~normal(cn[i],sco);
        u[i]~normal(uu[i],suo);
    }
    
    for(i in 2:(N)){        
        p[i]~normal(delta+gamma*cn[i-1]+phi*uu[i],spo);
    }    
}  
 