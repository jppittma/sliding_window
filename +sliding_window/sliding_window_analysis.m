function output=sliding_window_analysis (time_series, window, step_size, analysis)
	arguments 
		time_series single = [-150:150;ones(1,301)];
		window Window = Rect();
		step_size = 1;
		%Default analysis is no op
		analysis function_handle = @(x) x;
	end 

	import sliding_window.*

	%Because the "L" variable doesn't represent the
	%Actual length of the window in terms of number of time points
	%If the length of the time series is not a multiple of the step size, we'll cut time points off at the end.
	base_num_windows = size(time_series, 2) - window.length() + 1;
	num_windows = ceil( double (base_num_windows) / step_size );
	first_window = analysis(window.index_from_beginning(time_series));
	output = zeros( [size(first_window) num_windows] );
	output(:,:,1) = first_window;
	for i = 2:num_windows 
		output(:,:,i) = analysis(window.index_from_beginning(time_series, 1 + (i - 1) * (step_size) )); 
	end
end
