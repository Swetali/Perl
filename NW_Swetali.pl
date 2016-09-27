#!/user/swetalipatel/bin/perl

##The following Perl code is the algorithm for Needleman and Wunsch 


use strict;
use warnings;

my $s1 = "ACTGATTCA";
my $s2 = "ACGCATCA";


my $gap = -2;
my $match = 1;
my $mismatch = -1;

#length of seq for matrix
my $n = (length($s1) + 1);  
my $m = (length($s2) + 1);  

#putting seq into array
my @seq1 = split(//, $s1);
my @seq2 = split(//, $s2);


#sub NEEDLEMAN-WUNSCH($$$) {    # using sub routine gave no output

#my $seq1 = shift(@_);
#my $seq2 = shift(@_);


#NEEDLEMAN-WUNSCH matrix
my @NW;

my ($x, $y, $array, $i);  

#for top row 
for ($x = 0; $x < $m; $x++){
	if ($x == 0){
		
		for ($i = 0; $i < $n; $i++){
			if ($i == 0){
				$NW[$x][$i] = 0;
			}
			else{
				$NW[$x][$i] = (($NW[$x][($i-1)]) + $gap);
			}
		}
	}
	
	else{
		for ($y = 0; $y < $n; $y++){
			if ($y == 0){
				$NW[$x][$y] = (($NW[$x-1][$y]) + $gap);
			}
			else{
				
				my @maxV;  
				
				#for upper row values
				
				my $up = $NW[$x-1][$y] + $gap;
				push (@maxV, $up);
				

                #for left column values

                my $leftcolumn = ($NW[$x][($y-1)] + $gap);
				push (@maxV, $leftcolumn);
				


				if ($seq1[($y-1)] eq $seq2[($x-1)]){

					my $boxval = $NW[$x-1][$y-1];
					push (@maxV, (($match + $boxval )));
				}
				else{
					my $boxval = $NW[$x-1][$y-1];
					push (@maxV, (($mismatch + $boxval )));
				}
				#find max val of the 3 and enter that 
				@maxV = sort { $a <=> $b } @maxV;
				$NW[$x][$y] = (splice(@maxV, -1));
			}
		}
	}
}

foreach $array(@NW){
	print "@{$array}\n";
	
}
print $NW[($m-1)][$n-1];
print"\n";