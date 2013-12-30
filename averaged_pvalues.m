%Find convergent p-value of ANOVA1 test with 5000 random samples...

%vectors of interest
vecs = [10:31, 35:38];
accumulator = zeros(1000,1);

%each column will contain the averaged p-value of each tested vector from
%vecs
results = zeros(1,26);

for i = 1 : 26
    for j = 1 : 1000
        rand_acyc = randsample(double(IBTrACS_acyc(:,vecs(i))),5000);
        rand_cyc = randsample(double(IBTrACS_cyc(:,vecs(i))),5000);
        [p] = anova1([rand_acyc,rand_cyc], [], 'off');
        accumulator(j) = p;
    end
    results(i) = sum(accumulator) / 1000;
    fprintf('P-value of %s : %d \n', char(IBTrACS_acyc.Properties.VarNames(vecs(i))),...
        results(i));
end