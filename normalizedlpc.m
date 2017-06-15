clc;
clear all;
Fs=8000;
 % create the recorder
recorder=audiorecorder(Fs,8,1)
for k=1:30
    clear y1 y2 y3;
    display('record voice');
    pause();
    
     % record two second of data
     recordblocking(recorder,2);
     % get the samples
     x = getaudiodata(recorder);
    t=0.04;
    j=1;
    for i=1:8000
        if(abs(x(i))>t)
            y1(j)=x(i);
            j=j+1;
    end
end
y2=y1/(max(abs(y1)));
y3=[y2,zeros(1,3120-length(y2))];
y=filter([1 -0.9],1,y3');%high pass filter to boost the high frequency components


%%frame blocking
blocklen=240;%30ms block
overlap=80;
block(1,:)=y(1:240);
for i=1:18
    block(i+1,:)=y(i*160:(i*160+blocklen-1));
end



%it takes double broo
w = hamming(blocklen);


for i=1:19
    a=xcorr((block(i,:).*w'),12);%finding auto correlation from lag -12 to 12
    for j=1:12
        auto(j,:)=fliplr(a(j+1:j+12));%forming autocorrelation matrix from lag 0 to 11
    end
    z=fliplr(a(1:12));%forming a column matrix of autocorrelations for lags 1 to 12
    alpha=pinv(auto)*z';
    lpc(:,i)=alpha;
end
wavplay(x,Fs);
X(k,:)=reshape(lpc,1,228);
Y(k,:)=input('enter the number ');
end
save('lpcdata.mat','X','Y');
