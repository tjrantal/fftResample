%Reconstruct fft-transformed data to desired number of datapoints
%Paramteres:
%	data 						= fft transform of the original signal
%	desiredNumberOfDataPoints	= desired length of the reconstructed signal in data points
function f2 = fft_normalize(data,desiredNumberOfDataPoints) %[f2,u] = fft_normalize(data,kerroin)
    NFFT = 2^nextpow2(length(data)); 
    fftData = fft(data,NFFT);
%     keyboard
    reconstructXValues =linspace(0,1-(NFFT-(length(data)-1))/NFFT,desiredNumberOfDataPoints)';% 0:((length(data)/NFFT)/desiredNumberOfDataPoints):(length(data)/NFFT);% linspace(0,length(data)/NFFT+(length(data)/NFFT)/(desiredNumberOfDataPoints),desiredNumberOfDataPoints);
    %reconstructXValues = linspace(0,1,desiredNumberOfDataPoints);
	w0 = 2*pi;
	F = fftData;
	F= F./(length(F)/2+1);
	F(1) = F(1)/2;
	F = F(1:(length(F)/2+1));	%Discard the second half of coefficients (mirror the first part)
	
	if 1	%Swap this to 0 if you want to use the loop through version
		%Reconstruct the signal with matrix algebra (quicker than looping through but requires more memory)
	  	A = ones(length(reconstructXValues),1); 
	  	for f = 2:(length(F)) %Assume that first freq = 0 and skip it
			A = [A, -sin(w0*(f-1).*reconstructXValues), cos(w0*(f-1).*reconstructXValues)];
	  	end
	  	coefficients = zeros((length(F)-1)*2+1,1); %Coeffs 1 is the DC offset, 2:2:end sine, 3:2:end cos
	  	coefficients(1) = real(F(1));
	  	coefficients(3:2:end) = real(F(2:end));	%Cos coefficients
	  	coefficients(2:2:end) = imag(F(2:end));	%Sine coefficients
	  	f2 = A*coefficients;
	else
		%Reconstruction by looping through. Low but has minimal memory requirements
		I = 1;
		for i = 1:desiredNumberOfDataPoints
			f2(I) = real(F(1));
		     for l = 2:1:length(F) %Modify here to use fewer coefficients for the reconstruction
		         f2(I) = f2(I)-imag(F(l))*sin((l-1)*w0*reconstructXValues(i))+real(F(l))*cos((l-1)*w0*reconstructXValues(i));
		     end
		     I = I+1;
		end
	end
end
