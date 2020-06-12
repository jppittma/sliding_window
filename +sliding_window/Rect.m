classdef Rect<sliding_window.Window

	properties
		%Configurable length of the rectangular window. If none is set, the default
		%from Mokhtari 2018 is used
		len;
	end

	methods

		function ret=length(obj)
			if isempty(obj.len)
				obj.len = 1 / (obj.OMEGA_C * obj.TR);
			end
			ret = obj.len;
		end
		
		function [window, window_index]=single_window(obj,time_series, window_num )
			if nargin < 3
				window_num = 0;
			end
			window_start = window_num - obj.length();
			window_end = window_num + obj.length();
			mid_point = ceil( length(time_series) / 2);
			window_index = [window_start:window_end] + mid_point + 1;
			window = time_series(:,window_index);
		end

	end	
end
