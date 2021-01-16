% *question 1 -> generating the main function
t = linspace(-4, 4, 8*1000);
y = exp(-1*abs(t)./5).*(heaviside(t+1) - heaviside(t-3));
%generating y1
y1 = exp(-1*abs(3*t)./5).*(heaviside(3*t+1) - heaviside(3*t-3));
%generating y2
y2 = exp(-1*abs(t+2)./5).*(heaviside(t+2+1) - heaviside(t+2-3));
%generating y3
y3 = exp(-1*abs(4-2*t)./5).*(heaviside((4-2*t)+1) - heaviside((4-2*t)-3));
figure;
hold on;
% subplotting the outputs
subplot(2,2,1), plot(t,y), title('y(x)'), grid on, box off;
subplot(2,2,2), plot(t, y1), title('y1(x)'), grid on, box off;
subplot(2,2,3), plot(t, y2), title('y2(x)'), grid on, box off;
subplot(2,2,4), plot(t,y3), title('y3(x)'), grid on, box off;

% *question 2 -> fourier transform
% a)
fs = 12000   ;
t1 = linspace(-0.02, 0.02, 0.04*fs); 
m = sinc(10^(-3) * t1).^2; 
n = length(m); 
Fvec = (-n/2:n/2-1)*(fs/n);  

m_fourier = fftshift(fft(m)); 
m_powershift = abs(m_fourier).^2 / n; 
figure;
hold on
plot(Fvec /fs, m_powershift);
grid on
box off
title('fourier transform of m(x)')

% b)
c = cos(2*pi*10.^5 *t1);
r = m.*c;
n = length(r);
Fvec = (-n/2:n/2-1)*(fs/n);
r_fourier = fftshift(fft(r));
r_powershift = abs(r_fourier).^2 / length(r);
figure;
hold off
subplot(2,1,1)
plot(t1, r);
grid on
box off
title('r(x)')
subplot(2,1,2)
plot(Fvec / fs, r_powershift);
grid on
box off
title('fourier transform of r(x)')

% *question 3 -> fourier series
nneg = -10: 1;
npos =  1:10;
Fnneg = -1.*(exp(-pi) - 1) ./ (pi*(1+j*2*nneg));
Fnpos = -1.*(exp(-pi) - 1) ./ (pi*(1+j*2*npos));
F0 = 1/pi *(1 - exp(-pi));

n = [nneg 0 npos];
Fn = [Fnneg F0 Fnpos];
figure
subplot(2,1,1)
stem(n, abs(Fn))
grid on
box off
title("amplitude spectrum")
subplot(2,1,2)
stem(n, angle(Fn))
grid on
box off
title("angle spectrum")