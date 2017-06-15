clc;clear all;
load('voicetrainfinal.mat');
Fs=8000;
for l=1:20
 clear y1 y2 y3;
display('record voice');
pause();
x=wavrecord(Fs,Fs);
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
w=hamming(blocklen);
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
X1=reshape(lpc,1,228);
a1=sigmoid(Theta1*[1;X1']);
    h=sigmoid(Theta2*[1;a1]);
    m=max(h);
  p1=find(h==m);
  if(p1==10)
      P=0
  else
      P=p1
  end
end