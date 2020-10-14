function score=search_threshold(threshold,P0,P_sim0)
P_sim0(P_sim0<threshold)=0;
P_sim0(P_sim0>=threshold)=1;
score=abs(sum(P_sim0-P0));
end