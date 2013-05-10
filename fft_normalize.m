%Reconstruct fft-transformed data to desired number of datapoints
%Paramteres:
%	data 						= fft transform of the original signal
%	desiredNumberOfDataPoints	= desired length of the reconstructed signal in data points
function f2 = fft_normalize(data,desiredNumberOfDataPoints) %[f2,u] = fft_normalize(data,kerroin)
    NFFT = 2^nextpow2(length(data)); 
    fftData = fft(data,NFFT);
%     keyboard
    reconstructXValues =linspace(0,1-(NFFT-(length(data)-1))/NFFT,desiredNumberOfDataPoints);% 0:((length(data)/NFFT)/desiredNumberOfDataPoints):(length(data)/NFFT);% linspace(0,length(data)/NFFT+(length(data)/NFFT)/(desiredNumberOfDataPoints),desiredNumberOfDataPoints);
    %reconstructXValues = linspace(0,1,desiredNumberOfDataPoints);
	w0 = 2*pi;
	F = fftData;
	F= F./(length(F)/2+1);
	F(1) = F(1)/2;
	I = 1;
	%Reconstruct the signal
    count = 0;
	for i = 1:desiredNumberOfDataPoints
		f2(I) = real(F(1));
        for l = 2:1:length(F)/2+1 %Modify here to use fewer coefficients for the reconstruction
            f2(I) = f2(I)-imag(F(l))*sin((l-1)*w0*reconstructXValues(i))+real(F(l))*cos((l-1)*w0*reconstructXValues(i));
        end
        I = I+1;
	end
end
