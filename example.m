import sliding_window.*

time_series = [-125:125 ; cumsum(randn(1,251))];

window = Mrect();
step_size = 1;
analysis = @(matrix) corr(matrix');
output = sliding_window_analysis(time_series, window, step_size, analysis);

window = Rect();
window.set_half_width(1);
time_series = -10:10;

basic = window.index_from_center(time_series, 0);


save("output.mat");
