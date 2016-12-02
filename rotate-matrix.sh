#!/bin/bash
export LC_ALL=C

## This script rotates a matrix
## 
## You can use this script, for example, like this:
##  cat matrix.log | ./rotate-matrix.sh
##

awk '{
	if (max_nf < NF) {
		max_nf = NF;
	}

	max_nr = NR;

	for (x = 1; x <= NF; x++) {
		vector[x, NR] = $x;
	}
} END {
	for (x = 1; x <= max_nf; x++) {
		for (y = max_nr; y >= 1; --y) {
			printf("%s ", vector[x, y]);
		}

		print("\n");
	}
}' $1
