# Number-recognition-system
  System is developed using neural network on matlab


Summary of the code:-

1 Train the system by giving numbers 0-9 as voice inputs and then test it using a new sample.
2 Each user should give 30 samples(which can be increased in the code) i.e each number having 3 samples in any order they want.
3 Each sample is of 2 seconds(which can also be changed depending on the RAM).
4 If more accuracy needed then update the fs from 8000 to 16000.
5 Neural Net is also flexible as number of nodes in hidden layers can be changed easily.

Steps to run the code.
1 Run normalizedlpc.m to collect samples which can be used to train the network.
2 Run lpcnuralnet.m to train the system using the voice samples collected.
3 Run voicepredict.m and give a new sample and get the expected output.


Neural networks code was developed using Andrew Ng lectures. 
To understand the assignments in detail
1 Complete andrew ng machine learning course for better understanding of the code
2 Learn lpc via youtube.
3 Read Speech Recognition using Neural Networks by Joe Tebelskis.




