data{
        int<lower=1> N;
        real<lower=0,upper=100> pi[N];
        real<lower=0,upper=100> u[N];
}

parameters{
    real L; //lambda*phi    
    real<lower=0> un; //natural unemployment rate
    real<lower=-20,upper=20> beta;    
    real uc[3];
    real<lower=0> su;
    real<lower=0> s;
}

model{
    real p[N-1];
    
    for(i in 3:(N)){
        u[i]~normal(uc[1]+uc[2]*u[i-1]+uc[3]*u[i-2],su);
    }    

    for(i in 1:(N-1))
        p[i]<-beta*pi[i+1]-L*(u[i]-un);
        
    for(i in 1:(N-1))
        pi[i]~normal(p[i],s);
} 