n = 1;
q = 1;

samples = 4;

coefs = [1,2,2,3;56,34,4,6;5,3,43,5;4,2,3,45;56,56,3,23;4,23,5,67;55,23,34,5;45,6,7,67;45,645,6,78;76,4,4,5;2,1,56,90;2,8,5,643;17,89,21,5;7,5,7,99];
coef_total = zeros(1,length(coefs)*samples);

for i = 1:length(coefs)
   coef_total(1,q:q+samples-1) = coefs(i,:)
   
   q = q+samples
   
   i
end