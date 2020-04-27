classdef SlidingWindow

	properties (Constant=false)
		phi = 5 / 12 * pi;
		TR = 2;
		alpha = 0.5;
	end

	properties (Private=true)
		base_length;
		actual_length;
	end

	methods

		function obj=SlidingWindow()
			obj.base_length = obj.default_base_length();
		end

		function [window, window_index]=single_rect(obj,time_series, window_num, base_length)
			if nargin < 4
				base_length = obj.base_length;
			end
			
			window_start = window_num - base_length;
			window_end = window_num + base_length;
			mid_point = ceil( length(time_series) / 2);
			window_index = [window_start:window_end] + mid_point;
			window = time_series(:,window_index);
			obj.actual_length=length(window);
		end

		function mrect_window=single_mrect(obj, time_series, window_num)

			if nargin < 3
				window_num = 0;
			end

			[long_window,~] = obj.single_rect(time_series, window_num, 2 * obj.base_length);
			[short_window,short_index] = obj.single_rect(long_window, window_num, obj.base_length);
			time_points= linspace(-obj.base_length,obj.base_length,length(long_window));
			cos_window = arrayfun(@(time_point) cos(pi * (time_point + obj.phi) / (2 * obj.base_length) ), time_points);
			long_window = obj.alpha * long_window .* cos_window;
			long_window(short_index) = long_window(short_index) + short_window(short_index);
			mrect_window =  (long_window) / (1 + obj.alpha);
			obj.actual_length=length(window);
		end

		%%Used for the base length (distance taken from center to end) of the rectangular window
		%%The mrect window uses 4 base lengths from end to end 
		%%This is taken from Mokhtari et al 2019. 
		function ret=default_base_length(obj)
		end

	end
end 
