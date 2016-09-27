#!/user/swetalipatel/bin/perl

sub cleaveAndBind($$$$);

use strict;
use warnings;

my (@dna1, @dna2, $seq, $pos, $i, $ok);
$dna1[0][0] = "5p-sequence-PPPPPP-GAATTC-QQQQQQ-sequence-3p";
$dna1[1][0] = "3p-sequence-QQQQQQ-CTTAAG-PPPPPP-sequence-5p";

$dna2[0][0] = "5p-sequence-XXXXXX-GAATTC-YYYYYY-sequence-3p";
$dna2[1][0] = "3p-sequence-YYYYYY-CTTAAG-XXXXXX-sequence-5p";

$seq = "GAATTC";
$pos = 1;

$ok = cleaveAndBind(\@dna1, \@dna2, \$seq, \$pos);
print $dna1[0][0], "\n", $dna1[1][0], "\n", $dna2[0][0], "\n", $dna2[1][0], "\n" if($ok);
exit;

$seq = "GAACTT";
$ok = cleaveAndBind(\@dna1, \@dna2, \$seq, \$pos);
print $dna1[0][0], "\n", $dna1[1][0], "\n", $dna2[0][0], "\n", $dna2[1][0], "\n" if($ok);

exit;

sub cleaveAndBind($$$$) {
	
	

	my $dna1ref = shift(@_);
	my $dna2ref = shift(@_);
	my $refSeq = shift(@_);
	my $refPos = shift(@_);
	my $reverseSeq = reverse($$refSeq);
	my $length = length(${$dna1ref}[0][0]);
	
    
    my ($match1, $match2, $subdna1, $subdna2, $rv1, $rv2, @rv1, @rv2);  



#-------------------------------------------------------------------
	my @dna1 = @{$dna1ref};
    my $dna1top = $dna1[0][0];
    my $dna1bot = $dna1[1][0];

#-----------------------------------------------------------------------------
    my @dna2 = @{$dna2ref};
    my $dna2top = $dna2[0][0];
    my $dna2bot = $dna2[1][0];


#------------------------------------------------------------------------------------
	#the top strand in DNA 1
    $match1 = index($dna1top, $$refSeq);
	$subdna1 = substr ($dna1top, 0, ($match1+$pos));
	$subdna2 = substr ($dna1top, ($match1+$pos));
	$rv1[0][0] = $subdna1;
	$rv1[0][1] = $subdna2;



	#the bottom strand in DNA 1
	$match2 = index($dna1bot, $reverseSeq);
	$subdna1 = substr ($dna1bot, 0, -($match2+$pos));
	$subdna2 = substr ($dna1bot, -($match2+$pos));
	$rv1[1][0] = $subdna1;
	$rv1[1][1] = $subdna2;



	#the top strand in DNA 2
	$match1 = index($dna2top, $$refSeq);
	$subdna1 = substr ($dna2top, 0, ($match1+$pos));
	$subdna2 = substr ($dna2top, ($match1+$pos));
	$rv2[0][0]  = $subdna1;
	$rv2[0][1] = $subdna2;


	#the bottom strand in DNA 2
	$match2 = index(${$dna2ref}[1][0], $reverseSeq);
	$subdna1 = substr ${$dna2ref}[1][0], 0, -($match2+$pos);
	$subdna2 = substr ${$dna2ref}[1][0], -($match2+$pos);
	$rv2[1][0] = $subdna1;
	$rv2[1][1] = $subdna2;


	$rv1[0][0] = $rv1[0][0].$rv2[0][1];
    $rv1[1][0] = $rv1[1][0].$rv2[1][1];
    $rv2[0][0] = $rv2[0][0].$rv1[0][1];
    $rv2[1][0] = $rv2[1][0].$rv1[1][1];

	@{$dna1ref} = @rv1;
	@{$dna2ref} = @rv2;
}


