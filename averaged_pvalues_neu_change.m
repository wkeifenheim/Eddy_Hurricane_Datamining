%pull values from neu_change_result into sets by associated eddy, then pull
%samples for one-way ANOVA tests.\

acyc = neu_change_result(double(IBTrACS_acyc(:,2)),:);
the_rest = neu_change_result(double(IBTrACS_cyc(:,2)),:);
%the_rest = [the_rest; neu_change_result(double(IBTrACS_miss(:,2)),:)];

accumulator = zeros(1000,1);
results = zeros(6,1);

bar_h = waitbar(0,'progress..');

for i = 1 : 6
    
    prec_i = (i-1) / 6;
    
    for j = 1 : 1000
        rand_acyc = randsample(double(acyc(:,i)),5000);
        rand_rest = randsample(double(the_rest(:,i)),5000);
        [p] = anova1([rand_acyc,rand_rest], [], 'off');
        accumulator(j) = p;
        
        prec_done = j/(6000) + prec_i;
        waitbar(prec_done)
    end
    results(i) = sum(accumulator) / 1000;
    fprintf('P-value of %s : %d \n', char(acyc.Properties.VarNames(i)),...
        results(i));
end
close(bar_h)