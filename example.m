import sliding_window.*

time_series = [[-125:125] ; cumsum(randn(1,251))];

window = Mrect();
step_size = 1;
analysis = @(matrix) corr(matrix');
output = sliding_window_analysis(time_series, window, step_size, analysis);

save("output.mat");
