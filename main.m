% Import two spectra which are metameric for the reference observer at a
% 10° fieldsize
spectra =importdata('spectra.txt');
s_daylight = spectra.data(:,2);
s_led = spectra.data(:,3);

fieldsize = 10; % 10 degree
interpolate = 1; % interpolate deviate observer to 380nm:1nm:780nm
deltaOM = getObserverMetamerismError(s_daylight,s_led, fieldsize, interpolate); 
disp(['Average chromaticity difference due to observer metamerism  Delta_u''v'' = ' num2str(deltaOM)]);
