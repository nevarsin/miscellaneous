# How did this work?

## Webpage analysis
I noticed that the map was a whole JS app loaded from another domain
by looking at the map source code I reached the point where the colors were defined,
I understood that the three letters index that was used was a reference to airports IATA codes
As a convenience full color names where also reported as comments :)

## Script
I fetched only the part of the map that was of interest
then I found a website with a legacy cgi script that, given the airport name, was outputting the full city name
some polish with cut and awk and I had all information to output a "city;color" pair


