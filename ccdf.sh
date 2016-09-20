#!/bin/bash

##
## It is ineffective to plot cdf (Cumulative Distribution Function) or CCDF
## (Complementary Cumulative Distribution Function) from several hundreds of
## thousands data points.
##
## This script effectively extracts cdf, ccdf, as well as pdf data from bulks
## of data points.
## 
## You can use this script, for example, like this:
##
##      for i in `seq 100000`; do while :; do ran=$RANDOM; ((ran < 32760)) && echo $(((ran%100)+1)) && break; done; done | ./ccdf.sh 
##
##
sort -n | \
uniq -c | \
awk '	{
		printf("%d %0.9f\n", $1, $2); 
		sum += $1; 
	} END {
		printf("%0.9f TOTAL\n", sum); 
	}' | \
sort -k 1 -rn | \
awk '	{ 
		if ($2 == "TOTAL")
		{ 
			sum = $1; 
		} 
		else 
		{ 
			printf("%0.9f %d %0.9f\n", $2,$1,$1/sum);
		} 
	}' | \
sort -k 1 -n | \
awk '	{ 
		cdf = prev + $3; 
        if (cdf > 1)
        {
            cdf = 1;
        }
		ccdf = 1 - cdf; 
		printf("%0.2f %d %0.9f %0.9f %0.9f\n", $1, $2, $3, cdf, ccdf); 
		prev = cdf; 
	}'
