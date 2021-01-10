% taking input from the user
sampling_frequency = input('Enter the sampling frequency: ');
start_of_time_scale = input('Enter the start of the time scale: ');
end_of_time_scale = input('Enter the end of the time scale: ');
number_of_breakpoints = input('Enter the number of breakpoints: ');
positions = zeros(1, number_of_breakpoints + 2);
for i=1:number_of_breakpoints
    positions(i + 1) = input(['Enter position of breakpoint ' num2str(i) ': ']);
end

positions(1) = start_of_time_scale;
positions(end) = end_of_time_scale;

t = linspace(start_of_time_scale, end_of_time_scale, (end_of_time_scale - start_of_time_scale)*sampling_frequency);
y = zeros(1, (end_of_time_scale - start_of_time_scale) * sampling_frequency);
actual_positions = positions - start_of_time_scale + 1;

for i=1:length(positions) -1
    x = linspace(positions(i), positions(i + 1), (positions(i+1) - positions(i))*sampling_frequency);
    fprintf('\nAvailable Specifications:\n1. DC Signal\n2. Ramp Signal \n3. General order polynomial\n4. Exponential Signal\n5. Sinusoidal Signal\n\n');
    specification = input(['Enter the specifications of the region between ' num2str(positions(i)) ' and ' num2str(positions(i+1)) ': ']);
    switch specification
        case 1
            amplitude = input('Enter the amplitude of the DC signal: ');
            z = amplitude*ones(1, (actual_positions(i + 1) - actual_positions(i))*sampling_frequency);
        case 2
            slope = input('Enter the slope of the ramp signal: ');
            intercept= input('Enter the intercept of the ramp signal: ');
            z = slope*x + intercept;
        case 3
            string_function = input('Enter the function in terms of x: ', 's');
            z = eval(string_function);
        case 4
            amplitude = input('Enter the amplitude of the signal: ');
            exponent = input('Enter the exponent of the signal: ');
            z = amplitude*exp(exponent* x);
        case 5
            amplitude = input('Enter the amplitude of the signal: ');
            frequency = input('Enter the frequency of the signal: ');
            phase = input('Enter the phase of the signal in degress: ');
            z = amplitude*sin(2*pi*frequency*x + phase.*pi ./ 180);
    end
     y(1, actual_positions(i)*sampling_frequency: actual_positions(i+1)*sampling_frequency - 1) = z;
end
y = y(sampling_frequency: end);

%plotting the output
figure;
hold on;
plot(t, y);
xL = xlim;
yL = ylim;
line([0 0], yL, 'Color', 'black');
line(xL, [0 0], 'Color', 'black');
grid on;
box off;

% asking the user for changes
while 1
fprintf('\n Available operarions to perform on the signal: \n1. Amplitude Scaling\n2. Time Reversal\n3. Time shift\n4. Expanding the signal\n5. Compressing the signal\n6. None\n\n');
change = input('Enter the change you want to perform: ');

switch change 
    case 1
        scale = input('Enter the scale value: ');
        y = scale*y;
    case 2
        t = (-1)*t;
    case 3
        shift = input('Enter the time shift value: ');
        t = t - shift;
    case 4
        expand = input('Enter the expanding value: ');
        t = t*expand ;
    case 5
        compress = input('Enter the compressing value: ');
        t = t/compress;
    case 6
        return;
end

% plotting the changed figure
figure;
hold on;
plot(t, y);
xL = xlim;
yL = ylim;
line([0 0], yL, 'Color', 'black');
line(xL, [0 0], 'Color', 'black');
grid on;
box off;
end