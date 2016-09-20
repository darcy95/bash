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
