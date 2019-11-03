# How did this work?

## Webpage analysis
I noticed that the map was a whole JS app loaded from another domain.  
By looking at the map source code I reached the lines where the colors were defined,  
I understood that the three chars index in use was a reference to airports IATA codes  
As a convenience full color names where also reported as comments :)

## Script
I fetched only the part of the map that was of interest  
then I found a website hosting a legacy cgi script that, given a GET request with the airport code, 
was returning the full city name.  
Some polish with cut and awk and I had all information to output a "city;color" pair


