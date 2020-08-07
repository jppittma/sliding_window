function output=sliding_window_analysis (time_series, window, step_size, analysis)
	arguments 
		time_series single = [-150:150 ; ones(1,301)];
		window Window = Rect();
		step_size = 1;
		%Default analysis is no op
		analysis function_handle = @(x) x;
	end 

	import sliding_window.*

	%Because the "L" variable doesn't represent the
	%Actual length of the window in terms of number of time points
	window_size = 2 * window.length() + 1;

	%If the length of the time series is not a multiple of the step size, we'll cut time points off at the end.
	base_num_windows = length(time_series) - window_size + 1;
	num_windows = floor( base_num_windows / step_size ) - 1;
	first_window_index = -floor(length(time_series) / 2 - length(window)) + 1;
	first_window = analysis(window.single_window(time_series, first_window_index));
	output = zeros( [size(first_window) num_windows] );
	output(:,:,1) = first_window;
	for i = 2:num_windows 
		current_window_index = first_window_index + step_size * i;
		output(:,:,i) = analysis(window.single_window(time_series, current_window_index)); 
	end
end
