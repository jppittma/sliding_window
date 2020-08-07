classdef Mrect < sliding_window.Window

	properties
		alpha = 0.5;
		phi = 5 / 12 * pi;
		len;
	end
	
	methods

		function ret=length(obj)
			if isempty(obj.len)
				obj.len = 2 / (obj.OMEGA_C * obj.TR);
			end
			ret = obj.len;
		end

		function mrect_window = single_window(obj, time_series, window_num)
			import sliding_window.Rect;

			if nargin < 3
				window_num = 0;
			end

			short_rect = Rect();
			long_rect = Rect();
			
			long_rect.len = obj.length();
			
			[long_window,~] = long_rect.single_window(time_series, window_num);
			
			[~, short_index] = short_rect.single_window(long_window);
			%This is so the long window and the short window are the same length

			short_window = zeros(size(long_window));
			short_window(short_index)= long_window(short_index);
			time_points= [-obj.length:obj.length];

			cos_window = arrayfun(@(time_point) cos(obj.OMEGA_C * pi * time_point  ) + obj.phi, time_points);

			long_window = obj.alpha * long_window .* cos_window;
			mrect_window =  (short_window + long_window) / (1 + obj.alpha);
		end
	end
end
