#!/Users/swetalipatel/software/bin/perl

#Performing sequence alignment of two different species and calculating the percent Identity

use strict;
use warnings;


my ($rawhomo, $rawmacaca, $i, $x, $t, $s, $j, $h, $f, $matrix, $finehomo, $finemacaca, $numcodonhomo, $AAhomo, $amino, $RNA, $RNAm, $AAmacaca, $forx);

$rawhomo = <<"_END_";
        1 acatttgctt ctgacacaac tgtgttcact agcaacctca aacagacacc atggtgcatc
       61 tgactcctga ggagaagtct gccgttactg ccctgtgggg caaggtgaac gtggatgaag
      121 ttggtggtga ggccctgggc aggctgctgg tggtctaccc ttggacccag aggttctttg
      181 agtcctttgg ggatctgtcc actcctgatg ctgttatggg caaccctaag gtgaaggctc
      241 atggcaagaa agtgctcggt gcctttagtg atggcctggc tcacctggac aacctcaagg
      301 gcacctttgc cacactgagt gagctgcact gtgacaagct gcacgtggat cctgagaact
      361 tcaggctcct gggcaacgtg ctggtctgtg tgctggccca tcactttggc aaagaattca
      421 ccccaccagt gcaggctgcc tatcagaaag tggtggctgg tgtggctaat gccctggccc
      481 acaagtatca ctaagctcgc tttcttgctg tccaatttct attaaaggtt cctttgttcc
      541 ctaagtccaa ctactaaact gggggatatt atgaagggcc ttgagcatct ggattctgcc
      601 taataaaaaa catttatttt cattgc
//
_END_


for($i=0; $i < length($rawhomo); $i++) {            #to loop for ATCG extraction 
	if(substr($rawhomo, $i, 1) eq 'a' ||
		substr($rawhomo, $i, 1) eq 't' ||
		substr($rawhomo, $i, 1) eq 'g' ||
		substr($rawhomo, $i, 1) eq 'c') {
		$finehomo.= substr($rawhomo, $i, 1)
	}
}


# $rawhomo =~ s/[^acgt]//g;

#print "$finehomo\n";

$rawmacaca = <<"_END_";
        1 acacttgctt ctgacacaac tgtgttcacg agcaacctca aacagacacc atggtgcatc
       61 tgactcctga ggagaagaat gccgtcacca ccctgtgggg caaggtgaac gtggatgaag
      121 ttggtggtga ggccctgggc aggctgctgg tggtctaccc ttggacccag aggttctttg
      181 agtcctttgg ggatctgtcc tctcctgatg ctgttatggg caaccctaag gtgaaggctc
      241 atggcaagaa agtgcttggt gcctttagtg atggcctgaa tcacctggac aacctcaagg
      301 gtacctttgc ccagctcagt gagctgcact gtgacaagct gcatgtggat cctgagaact
      361 tcaagctcct gggcaacgtg ctggtgtgtg tgctggccca tcactttggc aaagaattca
      421 ccccgcaagt gcaggctgcc tatcagaaag tggtggctgg tgtggctaat gccctggccc
      481 acaagtacca ctaagctcac tttcttgctg tccaatttct accaaaggtt cctttgttcc
      541 caaagtccaa ctactgaact gggggatatt atgaagggcc ttgaggatct ggattctgcc
      601 taat
     
//
_END_

for($x=0; $x < length($rawmacaca); $x++) {            #to loop for ATCG extraction 
	if(substr($rawmacaca, $x, 1) eq 'a' ||
		substr($rawmacaca, $x, 1) eq 't' ||
		substr($rawmacaca, $x, 1) eq 'g' ||
		substr($rawmacaca, $x, 1) eq 'c') {
		$finemacaca.= substr($rawmacaca, $x, 1)
	}
}
#print "$finemacaca\n";

$finehomo =~ tr/atgc/uacg/;

#print "$finehomo\n";
 
$finemacaca =~ tr/atgc/uacg/;

#print "\n";
#print "$finemacaca\n";


my %RNA_Codon = 
( aaa=>"K", aag=>"K",
  gaa=>"E", gag=>"E",
  aac=>"N", aau=>"N",
  gac=>"D", gau=>"D",
  aca=>"T", acc=>"T", acg=>"T", acu=>"T", 
  gca=>"A", gcc=>"A", gcg=>"A", gcu=>"A",
  gga=>"G", ggc=>"G", ggg=>"G", ggu=>"G",
  gua=>"V", guc=>"V", gug=>"V", guu=>"V",
  aug=>"M",
  uaa=>"*", uag=>"*", uga=>"*",
  auc=>"I", auu=>"I", aua=>"I",
  uac=>"Y", uau=>"Y",
  caa=>"Q", cag=>"Q",
  agc=>"S", agu=>"S",
  uca=>"S", ucc=>"S", ucg=>"S", ucu=>"S",
  cac=>"H", cau=>"H",
  ugc=>"C", ugu=>"C",
  cca=>"P", ccc=>"P", ccg=>"P", ccu=>"P",
  ugg=>"W",
  aga=>"R", agg=>"R",
  cga=>"R", cgc=>"R", cgg=>"R", cgu=>"R",
  uua=>"L", uug=>"L", cua=>"L", cuc=>"L", cug=>"L", cuu=>"L",
  uuc=>"F", uuu=>"F"
);

my $numcodonhomo = int(length($finehomo)/3);

##$AAhomo = "";
for($t=0; $t<$numcodonhomo; $t++) {
	$RNA=substr($finehomo, ($t * 3), 3);
	$AAhomo.=$RNA_Codon{$RNA};
}
#print "$AAhomo\n";  

#print "\n";

my $numcodonmacaca = int(length($finemacaca)/3);

##$AAhomo = "";
for($s=0; $s<$numcodonmacaca; $s++) {
	$RNAm=substr($finemacaca, ($s * 3), 3);
	$AAmacaca.=$RNA_Codon{$RNAm};
}
#print "$AAmacaca\n";  

#print "\n";

#x axis AA
my @xAA = split(//,$AAhomo);

print" $AAhomo\n";

#print "\n";

# Y aixs AA
my @yAA = split(//, $AAmacaca);
#@yAA=join("\n", @yAA);
 #print "$_\n" for @yAA;


#increase by j number od spaces 

#print "\n";

for ($j=0; $j<scalar(@xAA); $j++) {
     print"$yAA[$j]";
     print " "x$j;
  if ($xAA[$j] eq $yAA[$j]) { 
     print "X";
   }
   else 
   {
    print " ";
   }
   print "\n";
  }
#percent identity 
my $lengthfinehomo = length($finehomo);
my $lengthfinemacaca = length($finemacaca);
my ($highscore, $matchscore, $countscore, @countscore, $score);
for ($f=0; $f<($lengthfinehomo); $f++) {
     $score=0;
  for($x=0; $x<$lengthfinemacaca; $x++) {
     if (substr($finehomo, $x, 1) eq substr($finemacaca, $x, 1)) {
         $score = $score + 1;
         }
      }
    }
my $percent = ($score/$lengthfinehomo) * 100;
my $percentidentityfour = sprintf "%.4f", $percent;
print "percent identity: $percentidentityfour%\n";







