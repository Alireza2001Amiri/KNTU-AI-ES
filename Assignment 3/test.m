errors = zeros(1,30);
for i=1:30

    input = SalaryData.YearsExperience(i);
    predicted = Salary_Estimator(input);
    errors(i) = SalaryData.Salary(i) - predicted;
end
sum(errors)/30