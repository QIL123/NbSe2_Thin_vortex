


%%

DCDerive=(dDCdy+C1);
DCDerive=DCDerive(:);
MTF=Min(:);

plot(DCDerive,MTF,'.')
TFAmpliteFit=fit(DCDerive,MTF,'poly1');
hold on
plot(TFAmpliteFit)
hold off
TFAmplitude=TFAmpliteFit.p1;
confidencecoess=confint(TFAmpliteFit);
TFAmplitudeLoweBound=confidencecoess(1);
TFAmplitudeUpperBound=confidencecoess(2);