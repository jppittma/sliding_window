classdef Rect<sliding_window.Window

	properties
		%Configurable length of the rectangular window. If none is set, the default
		%from Mokhtari 2018 is used
		half_width int32;
	end

	methods

		function ret=get_half_width(obj)
			if isempty(obj.half_width)
				obj.half_width = 1 / (obj.OMEGA_C * obj.TR);
			end
			ret = obj.half_width;
        end
        
        function ret = length(obj)
            ret = 2 * obj.get_half_width + 1;
        end
		
		function [window, window_index]=index_from_center(obj,time_series, window_num )
            if nargin < 3
				window_num = 0;
            end
            
            if length(obj) > length(time_series)
                error('Window of length %d is longer than time series of length %d',...
                    length(obj), length(time_series) );
            end
            
			window_start = window_num - obj.get_half_width();
			window_end = window_num + obj.get_half_width();
			mid_point = ceil( size(time_series, 2) / 2);
			window_index = (window_start:window_end) + mid_point;
			window = time_series(:,window_index);
        end
        
        function [window] = index_from_beginning(obj, time_series, window_num)
            if (nargin < 3)
                window_num = 1;
            end
            
            window = time_series(:,window_num: window_num + obj.length() - 1);
        end

	end	
end
