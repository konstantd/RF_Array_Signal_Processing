# RF Array Signal Processing



This repository contains the assignments for the Academic Course “Special Antennas-Antenna Synthesis" taught in the Spring of 2018-2019 in Aristotle University of Thessaloniki - Electrical & Computer Engineering. The project is related to **BeamForming** and **Direction of Arrival** (**DoA**) algorithms and aims at the understanding of such techniques. More specifically, **NSB** beamformer with Diagonal Loading was analysed for varying SNR and minimum angle difference for incoming signals. The project also analyzes the performance of block-data weight adaptation achieved, using the **Sample Matrix Inversion (SMI)** algorithm. Finally, the limit angle difference for two signals in order to be separately identified for the **CAPON** DoA algorithm, is considered.



## Null Steering Beamformer (NSB) with diagonal loading 



This beamformer uses 8 (M=8) isotropic antenna elements as an array in z-axis. The antenna element spacing is half the wavelength (d=λ/2, βd=π). One desired signal by angle θo comes to the beamformer while we have N=2 interference signals at θ1, θ2. The measure of the angle is with respect to the z-axis (elevation angles). The minimum distance between 2 angles is Δθmin. All the above signals are zero-mean signals, 1 W power and uncorellated to one another as well as to the noise signals. The noise signals are zero-mean, uncorellated and the power is defined by the SNR.

1000 sets of angles θo, θ1 and θ2 are created, uniform distributed in [30, 150] degrees, where the distance between any two adjacent angles will not be less than Δθmin (i.e., any set with angles less than Δθmin are discarded). 

For every set of the angles θo, θ1, θ2:

NSB-DL algorithm is executed and the complex weights are calculated. Based on the weights,  Signal to Interference plus Noise Ratio (SINR) is estimated and the radiation pattern is created. After that, the radiaton pattern is used in order to calculate the deviation of the estimations of the main lobe and the 2 zeros (for the interference signals), (i.e., Δθο, Δθ1, Δθ2 are calculated). The code was executed for SNR = 0dB, 5dB, 10dB and20 dB and Δθmin = 2 , 4, 6, 8 and 10 degrees.

The statistic results of the above experiments can be seen in the below image.

<p allign = "center">
     <img src="/photos/NSB.png"width = "70%">
</p>

#### Conclusions

Regarding the deviation of the main lobe from the direction of the desired signal, ignoring some extreme maximum values and judging by the average value each time we observe that on average for all results the deviation is not greater than 3.2 degrees. There is also no significant improvement even for higher SNRs. However it is something we expected as the main goal of the NSB-method is to cancel the interference signals. For large Δθ however, as is logical we have smaller deviations from the true angle θο and a more "condensed sample" based on the standard deviation.

For the deviations of the zeros from the directions of the interference signals we observe much more satisfactory results in relation to the deviation of the main lobe. Also here the statistics seem to be improving as the Δθ increases but also as the SNR increases. The averages of the deviations are very satisfactory and in fact, judging by the standard deviation, all the samples are very close to the average. As we have said, this is the goal of NSB method.

The formula that calculates the values of SINR, uses the maximization of it.  We notice that for almost all cases we have a very good SINR. Obviously it increases as the SNR increases but also as the angle between the incoming signals increases. For large Δθ the interference signals are further away from the desired signal and therefore they do not have a large impact on it.



## Sample Matrix Inversion Beamformer (SMI)



The sample matrix is a time average estimate of the array correlation matrix using K-time samples. The SMI algorithm has a faster convergence rate since it employs direct inversion of the correlation matrix. The sample matrix is a time average estimate of the array correlation, matrix using K-time samples. In this algorithm, the input samples are divided into “k” number of blocks and each number of blocks is of length K. Since we use a K-length block of data, this method is called a block-adaptive approach. The weight are adapted block-by-block. 

The beamformer operates at f=800Mhz and uses 8 isotropic antenna elements  (M=8) as an array in z-axis. The antenna element spacing is half the wavelength (d=λ/2). <ins> One desired incoming signal at θo=50 degrees and there are 5 interference signals (N=5) at          θ1=70, θ2=100, θ3=110. θ4=130 and θ5=160 degrees elevation angles </ins>.  These signals are sampled with sampling freq. fs=10f.  The samples of all incoming signals follow a normal distribution with zero mean value and 1W power. The noise signals follow a normal distribution with zero average value and power of 10mW. The reference signal ρ(k) is the same as the modulation function of the desired signal, that is ρ(k)= go(k). The block length is K=100.

The code prints the complex weights array and illustrates the radiation pattern. 

|      weights      |
| :---------------: |
| 0.1115 + 0.0465i  |
| -0.0585 + 0.0727i |
| -0.0741 - 0.0881i |
| 0.1632 - 0.0190i  |
| -0.0106 + 0.1617i |
| -0.0863 - 0.0706i |
| 0.0888 - 0.0730i  |
| 0.0387 + 0.1168i  |



Below we can see the radiation pattern of the antenna-array. 

<p allign = "center">
     <img src="/photos/SMI.png"width = "70%">
</p>

From the above figure we can observe that the main lobe is directed towards the desired signal, and null is pointed towards the interferences. Given the Array Factor, we are confident that the beamformer operates desirably. We can see that we have zeros close to the interference signals and maximum at the desired source. Below we estimate the divergence for a more in depth analysis of the beamformer. 

| Angle Divergence | Degrees |
| :--------------: | :-----: |
|       Δθo        |  -2.2   |
|       Δθ1        |   0.1   |
|       Δθ2        |  -0.2   |
|       Δθ3        |  -0.5   |
|       Δθ4        |  -0.7   |
|       Δθ5        |  -1.1   |



The Simulation results show that SMI is capable of nullifying the interference sources with a fast convergence. The null depth performance of the SMI algorithm is very good. The biggest absolute Δθ is only 0.7 degrees. 



## CAPON Direction of Arrival

The Capon algorithm, also called Minimum Variance Distortionless Response (MVDR), maintains a constant gain for the input signals from a specific direction and gives a smaller weight to the noise. This optimization problem maintains the gain of a specific direction at 1 and minimizes the noise to increase the signal-to-noise ratio (SNR). The estimator uses 8 isotropic antenna elements  (M=8) as an array in z-axis. The antenna element spacing is half the wavelength (d=λ/2). <ins> There are 7 incoming signals with elevation angles:  θ1=40, θ2=60, θ3=80. θ4=100, θ5=120, θ6=130 and θ7=130 degrees elevation angles. </ins> These signals are of 1W power and the noise signals have a zero average value, uncorellated to one another as well as to the incoming signals with SNR=10dB. The samples of all incoming signals follow a normal distribution with zero mean value and 1W power. 

Below we can see the spatial spectrum that is produced. 

<p allign = "center">
     <img src="/photos/CAPON.png"width = "70%">
</p>

We can observe that close to all incoming signals the estimator tries to maintain 0 dB power and nullify all the other degrees in order to minimize the interferences and noise. The "resonances" are quite thin, yet close to θ5 and θ6 angles, the attenuation is not quite big due to the fact that the incoming signals are quite close to one another. So, near these angles noises and interferences may play a significant role. 

Proceeding, we would like to examine the resolution of the estimator, in order to separate 2 close-to one another signals. Considering only two incoming 1W power signals with arrival directions symmetrical arranged to the perpendicular direction of the axis of the antenna (θ2 = 180 – θ1), we will calculate the minimum angular distance between the two arrival directions so that the two signals can be separated from each other by the estimator, i.e. in the power spectrum two distinct local maximum. Again, consider zero-mean noise signals, uncorrelated to each other and uncorrelated to the incoming signals, with SNR = 10dB. We consider that 1dB attenuation is enough in order to separate the two local maximum in the power spectrum.

Running the script <ins>capon_b.m</ins> we get:

```
The minimum degree-distance of the 2 signals in order to be recognized is u2-u1= 5.400
```



#### Conclusions

CAPON approach  identifies the angles of arrival. All directions of sources are correctly estimated, and there are observed maxima on the curve at the positions of the angles. Though, the lobes are quite wide and may cover two closely spaced sources. As shown above, for 1dB attenuation, the incoming signal should differ more that 5.4 degrees in order to be recognized, which is quite a poor performance. There are some correspondent modified versions of Capon that can improve the situation.