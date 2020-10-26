classdef Mrect < sliding_window.Window

	properties
		alpha = 0.5;
		phi = 5 / 12 * pi;
		half_width;
	end
	
	methods
        
        function ret=get_half_width(obj)
			if isempty(obj.half_width)
				obj.half_width = 2 / (obj.OMEGA_C * obj.TR);
			end
			ret = obj.half_width;
        end
        

		function ret=length(obj)
            ret = 2 * obj.get_half_width() + 1;
        end

        
        function mrect_window = index_from_beginning(obj,time_series,window_num)
			import sliding_window.Rect;

			if nargin < 3
				window_num = 1;
			end

			short_rect = Rect();
			long_rect = Rect();
			
			long_rect.half_width = obj.get_half_width();
			
			[long_window] = long_rect.index_from_beginning(time_series, window_num);
            short_rect.set_length(long_rect.get_half_width());
			
			[~, short_index] = short_rect.index_from_center(long_window);
			%This is so the long window and the short window are the same length

			short_window = zeros(size(long_window));
			short_window(short_index)= long_window(short_index);
			time_points= -obj.get_half_width():obj.get_half_width();

			cos_window = arrayfun(@(time_point) cos(obj.OMEGA_C * pi * time_point  ) + obj.phi, double(time_points) );

			long_window = obj.alpha * long_window .* cos_window;
			mrect_window =  (short_window + long_window) / (1 + obj.alpha);
        end
        
        
        
		function mrect_window = index_from_center(obj, time_series, window_num)
			import sliding_window.Rect;

			if nargin < 3
				window_num = 0;
			end

			short_rect = Rect();
			long_rect = Rect();
			
			long_rect.half_width = obj.get_half_width();
			
			[long_window,~] = long_rect.index_from_center(time_series, window_num);
			
			[~, short_index] = short_rect.index_from_center(long_window);
			%This is so the long window and the short window are the same length

			short_window = zeros(size(long_window));
			short_window(short_index)= long_window(short_index);
			time_points= -obj.get_half_width():obj.get_half_width();

			cos_window = arrayfun(@(time_point) cos(obj.OMEGA_C * pi * time_point  ) + obj.phi, time_points);

			long_window = obj.alpha * long_window .* cos_window;
			mrect_window =  (short_window + long_window) / (1 + obj.alpha);
		end
	end
end
