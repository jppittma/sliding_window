classdef (Abstract) Window
	%Interface for implementing new windows for sliding window analysis.
	%Window number zero should represent the center of the time series, and
	%the length of the window should represent the distance from the center of the 
	%window to either edge.
	properties
		%WFUBMC mri machines have a TR of 2 seconds
		TR=2;
		%This was given by Mokhtari as the minimum frequency for brain activity
		OMEGA_C = 0.01;
	end
	methods (Abstract)
		%In this instance length represents the distance from the center of the series
		%to either edge.
		length(obj)
		single_window(obj, time_series, window_number)
	end
end
