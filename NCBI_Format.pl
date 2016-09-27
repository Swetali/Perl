#!/users/swetalipatel/software/bin/perl

# The purpose of this code is to grab user input, filterout everything except A,C,G and T and dispaly it in the form of NCBI format and calculate the Molec Wt of the string



use strict;
use warnings;

my ($rawDNA, $ucDNA, $RD, $AA, $codonKey, $lenAA, $chunk60, $chunk10, $break10, $join6long, $join6, $Mw, $molecweight, %molec_key, $decMw, $weights);                        #1st we manke a scalar variable for junk/ raw DNA 

#$rawDNA = "akjsdbfiwhguijewr489y547y57835y43oqbhrfqohbjdv c9281y3498yuhri4br445q3443543543tgfvfcvbajlbuyvbouevfakjshdfgkjavgoauwryvf akjclLJlyvppPuAATTCCCCGCGCGGCGCCGTATGACTGATCGATCGATAGTCGACCTAGCAACGTCAGCAGCGCGAGAGAGGAGGAGAAGAGAAGAGGAGATCGATAGATCGCATTCAGCATCAGTACGCATGGACGACTGGGAGAGGAGAGAGATCGACTAGTAGCAGCAGAGGGAAGAGGACATCGATGATCGAGAGAGAGAGGAGAGAGGAGAGGAGCTAGCAAGAACCGCGCGCGCGCGCGGAGAGGGGAGAGACTAGCTAGCATGCATCGTCGATGCAGCGCTAGCAGCGGAGAGAGAGAGGAAGAGAAGGAAGGAGAGAGAGGAGACTAGCATGCATCGGACGAGAGGAGAGAGAGTCATCGACGAGGCGCGGAGGGCGCGCGCGCGCGCGCGATAGACTAGCACTGAGCTCAGTAGACGTCGACGACAGCAGAGCAGCAGGGAGGAGGAGAGAGAGAG";
$rawDNA = $ARGV[0];

$ucDNA = uc$rawDNA;                              #to convert all the alphabets into UC

#print "$ucDNA\n";                                #this prints all the alphabets in UC

 my $i;   

for($i=0; $i < length($ucDNA); $i++) {            #to loop for ATCG extraction 
	if(substr($ucDNA, $i, 1) eq 'A' ||
		substr($ucDNA, $i, 1) eq 'T' ||
		substr($ucDNA, $i, 1) eq 'G' ||
		substr($ucDNA, $i, 1) eq 'C') {
		$RD.= substr($ucDNA, $i, 1)
	}
}

#print "$RD\n";                                  #this prints onlt the ATGC's, Refined DNA = RD 

#Now, a scalar variable for that has all the string values of $RD 

my $RDw = $RD;                                    #$RDw = is going to be used to calculate molec weight of DNA 

#print "$RDw\n";

$RD =~ tr/ATGC/UACG/;

#print "$RD\n";                                    #here DNA is translated into RNA using the transliterate syntax 

my %RNA_Codon = (
	AAA => 'K', AAG => 'K', GAA => 'E', GAG => 'E',
	AAC => 'N', AAU => 'N', GAC => 'D', GAU => 'D',
	ACA => 'T', ACC => 'T', ACG => 'T', ACU => 'T',
	GCA => 'A', GCC => 'A', GCG => 'A', GCU => 'A',
	GGA => 'G', GGC => 'G', GGG => 'G', GGU => 'G',
	GUA => 'V', GUC => 'V', GUG => 'V', GUU => 'V',
	AUA => 'M', AUG => 'M', UAA => '*', UAG => '*', 
	UGA => '*', AUC => 'I', AUU => 'I', UAC => 'Y', 
	UAU => 'Y', CAA => 'Q', CAG => 'Q', AGC => 'S', 
	AGU => 'S', UCA => 'S', UCC => 'S', UCG => 'S', 
	UCU => 'S', CAC => 'H', CAU => 'H', UGC => 'C',
	UGU => 'C', CCA => 'P', CCC => 'P', CCG => 'P',
	CCU => 'P', UGG => 'W', AGA => 'R', AGG => 'R',
	CGA => 'R', CGC => 'R', CGG => 'R', CGU => 'R',
	UUA => 'L', UUG => 'L', CUA => 'L', CUC => 'L', 
	CUG => 'L', CUU => 'L', UUC => 'F', UUU => 'F'
	);

#Now, I will loop for Amino Acid substituion from hash table into the RNA seq i.e. $RD (transliterated earlier above)

my $numofcodon = int(length($RD)/3);


#$AA = "";
for($i=0; $i < $numofcodon; $i++) {
	$codonKey = substr($RD, $i * 3, 3);
	$AA.= $RNA_Codon{$codonKey};
}
#print "$AA\n";                                   #this gives a string of Amino Acid seq

#print "\n";

#substr($AA, 0, 60);


#print $chunk60, "\n";                          




 $break10=(length($AA)/10);

 for ($i=0; $i <= $break10; $i++) {
 	if(substr($AA, $i * 10, 10)) {
		$chunk10.=" ".substr($AA, ($i * 10), 10),"\n";
	}
}

#print "$chunk10\n";                                   #this gives us chunks of 10 AA with space 

my $long = length(65);      

for($i=0; $i <= $long; $i++) {
	if(substr($chunk10, $i * 1000, 1000)) {
		$join6=$join6.substr($chunk10, ($i * 1000), 1000);                 #chunks of 65 AA 
}
}
#print "$join6\n";  

 $join6long = int(length($join6));
my $x;
my $z;
$x=1;
for($z=0; $z <= $join6long; $z+=66) {                             #breaks the AA into 6 columns of 10 and numbers it (formatting)
	printf("%10d", $x);
	print substr($join6, $z, 66);
	print"\n";
    $x+=60;
    $z+=0;
	}

#Following syntax to give the molec weight of the DNA 
 %molec_key = (
	'A' => '135.13', 'T' => '126.10', 'G' => '150.12', 'C' => '111.10');

$weights = int(length($RDw)/1);

for($i=0; $i < $weights; $i++) {
	$molecweight = substr($RDw, $i, 1);
	$Mw+= $molec_key{$molecweight};
}
$decMw = sprintf "%.4f", $Mw; 
print "$decMw\n";










