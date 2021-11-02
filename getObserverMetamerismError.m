function [deltaOM] = getObserverMetamerismError(spectrum_1,spectrum_2, fieldsize, interpolate)
%   Calculates the the average chromaticity difference of individual
%   observers, which is caused by observer metamerism.
%
%   #### Input ####
%   spectrum_1, spectrum_2:
%       if interpolate set to 0 (no interpolation of the deviate observer)
%           spectrum_1: 390 to 780 nm, 5 nm interval
%           spectrum_2: 390 to 780 nm, 5 nm interval
%       if interpolate set to 1 (interpolation of the deviate observer) 
%           spectrum_1: 380 to 780 nm, 1 nm interval
%           spectrum_2: 380 to 780 nm, 1 nm interval
% 
%   fieldsize: 
%       2 (degree) or 10 (degree)
% 
%   interpolate:
%       0 - no interpolation of the deviate observer
%       1 - interpolation (and extrapolation) of the deviate observer
%
%   #### Output ####
%   deltaOM: average chromaticity difference CIE 1976 Delta_u'v'

    observer =importdata('observer.txt');
    
    if fieldsize == 2
        % Reference observer
        x_ref = observer.data(:,2);
        y_ref = observer.data(:,3);
        z_ref = observer.data(:,4);

        % Deviation functions
        x_dev = observer.data(:,5);
        y_dev = observer.data(:,6);
        z_dev = observer.data(:,7);
        
        % Fitting coefficients 
        p1 = 0.4416;
        p2 = 1.875e-3;
        
    elseif fieldsize == 10
        % Reference observer
        x_ref = observer.data(:,8);
        y_ref = observer.data(:,9);
        z_ref = observer.data(:,10);

        % Deviation functions
        x_dev = observer.data(:,11);
        y_dev = observer.data(:,12);
        z_dev = observer.data(:,13);
        
        % Fitting coefficients 
        p1 = 0.4610;
        p2 = 9.119e-4;   
        
    else
        error('Invalid fieldsize');
    end
    
    % Create deviate observer
    x_devobs = x_ref + x_dev;
    y_devobs = y_ref + y_dev;
    z_devobs = z_ref + z_dev;        
    
    if interpolate == 1
        % Extrapolate with trailing zeros to a startwavelength of 380 nm
        x_devobs = [0; 0; x_devobs];
        y_devobs = [0; 0; y_devobs];
        z_devobs = [0; 0; z_devobs];
    
        % Interpolate with cubic spline to 1 nm interval
        nm_before = (380:5:780)';    
        nm_after = (380:780)'; 
        
        x_devobs = spline(nm_before,x_devobs,nm_after);
        y_devobs = spline(nm_before,y_devobs,nm_after);
        z_devobs = spline(nm_before,z_devobs,nm_after);        
    end
    
    % Tristimulus values 
    X1 = sum(x_devobs.* spectrum_1);
    Y1 = sum(y_devobs.* spectrum_1);
    Z1 = sum(z_devobs.* spectrum_1);
    
    X2 = sum(x_devobs.* spectrum_2);
    Y2 = sum(y_devobs.* spectrum_2);
    Z2 = sum(z_devobs.* spectrum_2);
    
    % Transformation to CIE 1976 u'v' choordinates
    u1 = 4.*X1./(X1+15.*Y1+3.*Z1);
    v1 = 9.*Y1./(X1+15.*Y1+3.*Z1);
    
    u2 = 4.*X2./(X2+15.*Y2+3.*Z2);
    v2 = 9.*Y2./(X2+15.*Y2+3.*Z2);
    
    % Observer metamerism index M = chromaticity difference of the deviate
    % observer
    M = ((u1-u2)^2 + (v1-v2)^2)^0.5;
    
    % Fitting M to the chromaticity difference of 1000 individual observers    
    deltaOM = p1.*M + p2;
end

