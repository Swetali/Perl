#!/home/bif712_153a21/software/bin/perl

#OATH
#Student Assignment Submission Form
#==================================
#I declare that the attached assignment is wholly my own work
#in accordance with Seneca Academic Policy.  No part of this
#assignment has been copied manually or electronically from any
#other source (including web sites) or distributed to other students.
#name : Swetali Patel #072650146

#Link to the assignment - http://zenit.senecac.on.ca/~bif712_153a21/

use strict;
use warnings;
use LWP::Simple;
use Shell;
use CGI;
use CGI::Carp "fatalsToBrowser";



my ( $address, $sendmail, $page, $i, @genBankData, $result, $genBankData, $section, $result1, $result2, $result3, $result4, $result5, $result6, $result7, @result8, @result9, @result10, @result11, @result12, $result13, $origin, $BASE_COUNT);
my ($page, @lines, $okToPrint, $stopPrint, $cgi, @genBankData, $virus, $i);

$cgi = new CGI; # process all form elements!

$address = $cgi->param('mailto'); 

@genBankData = $cgi->param('attributes');

$virus = $cgi->param('viruses');

my $url = "ftp://ftp.ncbi.nih.gov/genomes/Viruses/";
$url .= $virus;

my @viruses = split('/', $virus);

$virus = $viruses[1];

#print "selected virus is form split $virus\n";
print "Content-type: text/html\n\n";
print "<html><head><title>...</title></head><body><pre>\n";
print "Successfully downloaded GenBank File...\n<br />";

print "virus: '$virus' url: '$url'\n";
# exit( );

if($virus eq "NC_004777.gbk") {


	if(!(-f "NC_004777.gbk")) {
		$page = get("ftp://ftp.ncbi.nih.gov/genomes/Viruses/Yersinia_pestis_phage_phiA1122_uid14332/$virus/");
		die "Error retrieving GenBank file from NCBI..." unless defined($page);
		open(FD, "> $virus") || die("Error opening file swetali... $!\n");

		print FD "$page";
		close(FD);
}
    else {
	$/ = undef;   # default record separator is undefined
	open(FD, "< $virus") || die("Error opening file: '$virus'\n $!\n");
	$page = <FD>; # file slurp (reads the entire file into a scalar)
	close(FD);
	$/ = "\n";   # resets the default record back to newline

	#print "$page\n";
    }
}

elsif ($virus eq "NC_002549.gbk") {


      if(!(-f "NC_002549.gbk")) {
	     $page = get("ftp://ftp.ncbi.nih.gov/genomes/Viruses/Zaire_ebolavirus_uid14703/$virus/");
	     die "Error retrieving GenBank file from NCBI..." unless defined($page);
	     open(FD, "> $virus") || die("Error opening file... $!\n");

	     print FD "$page";
	     close(FD);
}

    else {
	$/ = undef;   # default record separator is undefined
	open(FD, "< $virus") || die("Error opening file: '$virus'\n $!\n");
	$page = <FD>; # file slurp (reads the entire file into a scalar)
	close(FD);
	$/ = "\n";    # resets the default record back to newline
	
	#print "$page\n";
    }

}

elsif ($virus eq "NC_001781.gbk") {
	

      if(!(-f "NC_001781.gbk")) {
	    $page = get("ftp://ftp.ncbi.nih.gov/genomes/Viruses/Human_respiratory_syncytial_virus_uid15003/$virus/");
	    die "Error retrieving GenBank file from NCBI..." unless defined($page);
	    open(FD, "> $virus") || die("Error opening file... $!\n");

	    print FD "$page";
	    close(FD);
}
    else {
	$/ = undef;   # default record separator is undefined
	open(FD, "< $virus") || die("Error opening file: '$virus'\n $!\n");
	$page = <FD>; # file slurp (reads the entire file into a scalar)
	close(FD);
	$/ = "\n";    # resets the default record back to newline
	#print "$page\n";
    }
}

elsif ($virus eq "NC_004763.gbk") {
	

       if(!(-f "NC_004763.gbk")) {
	     $page = get("ftp://ftp.ncbi.nih.gov/genomes/Viruses/African_green_monkey_polyomavirus_uid15320/$virus/");
	     die "Error retrieving GenBank file from NCBI..." unless defined($page);
	     open(FD, "> $virus") || die("Error opening file... $!\n");

	    print FD "$page";
	    close(FD);
}
    else {
	$/ = undef;   # default record separator is undefined
	open(FD, "< $virus") || die("Error opening file: '$virus'\n $!\n");
	$page = <FD>; # file slurp (reads the entire file into a scalar)
	close(FD);
	$/ = "\n";    # resets the default record back to newline
	#print "$page\n";
    }
}

elsif ($virus eq "NC_004679.gbk") {
    
   
	if(!(-f "NC_004679.gbk")) {
	      $page = get("ftp://ftp.ncbi.nih.gov/genomes/Viruses/Staphylococcus_aureus_phage_P68_uid14269/$virus/");
	      die "Error retrieving GenBank file from NCBI..." unless defined($page);
	      open(FD, "> $virus") || die("Error opening file... $!\n");

	     print FD "$page";
	     close(FD);
}

    else {
	$/ = undef;   # default record separator is undefined
	open(FD, "< $virus") || die("Error opening file: '$virus'\n $!\n");
	$page = <FD>; # file slurp (reads the entire file into a scalar)
	close(FD);
	$/ = "\n";    # resets the default record back to newline
	#print "$page\n";
    }

}




#print "checkboxes selected... @genBankData\n";
#@genBankData = ("LOCUS", "DEFINITION", "ACCESSION", "VERSION", "KEYWORDS", "SOURCE", "ORGANISM", "REFERENCE", "AUTHORS", "TITLE", "JOURNAL", "PUBMED", "FEATURES", "ORIGIN", "BASECOUNT", "ALL");



 foreach (@genBankData)  {
  if ($_ eq "LOCUS") {
       $result = "";
       $result = $1 if($page =~ /($_.*)/);
       print "$result\n";
    }

    elsif ($_ eq "DEFINITION") {
	   $result1 = "";
	   $result1 = $1 if($page =~ /($_.*)/);
	   print"$result1\n";
    }

    elsif ($_ eq "ACCESSION") {
	   $result2 = "";
	   $result2 = $1 if($page =~ /($_.*)/);
    }
    elsif ($_ eq "VERSION") {
	  $result3 = "";
	  $result3 = $1 if($page =~ /($_.*)/);
	  print"$result3\n";
    }
    elsif ($_ eq "KEYWORDS") {
	  $result4 = "";
	  $result4 = $1 if($page =~ /($_.*)/);
	  print"$result4\n";
    }
    elsif ($_ eq "SOURCE") {
	  $result5 = "";
	  $result5 = $1 if($page =~ /($_.*)/);
	  print"$result5\n";
    }
    elsif ($_ eq "ORGANISM") {
	  $result6 = "";
	  $result6 = $1 if($page =~ /($_.*?)REFERENCE/s);
	  print"$result6\n";
    }
    elsif ($_ eq "AUTHORS") {
	  $result7 = "";
	  $result7 = $1 if($page =~ /($_.*)/);
	  print"$result7\n";
    }
    elsif ($_ eq "TITLE") {
	  @result8 = "";
	  @result8 = ($page =~ m/(  \Q$_\E.*?)  JOURNAL/gs);
	  print"@result8\n";
    }

    elsif ($_ eq "JOURNAL") {
	  @result9 = "";
	  @result9 = ($page =~ m/(\Q$_\E.*?)(?=PUBMED|REFERENCE|REMARK|COMMENT)/gs);
	  print"@result9\n";
    }

    elsif ($_ eq "PUBMED") {
	  @result10 = "";
	  @result10 = ($page =~ m/(   \Q$_\E.*?)REFERENCE/gs);
	  print"@result10\n";
    }
    elsif ($_ eq "FEATURES") {
	  @result11 = "";
	  @result11 = ($page =~ m/(\Q$_\E.*?)ORIGIN/gs);
	  print"@result11\n";
    }
    elsif ($_ eq "ORIGIN") {
	  @result12 = "";
	  @result12 = ($page =~ /($_.*)/s);
	  print"@result12\n";
    }
    elsif ($_ eq "BASECOUNT"){
    my $origin = "";
       $origin = $1 if ($page =~ /ORIGIN(.*)/s);
    my $counta= ($origin =~ tr/a//);
    my $countc= ($origin =~ tr/c//);
    my $countt= ($origin =~ tr/t//);
    my $countg= ($origin =~ tr/g//);
    #print "$origin\n";
    $BASE_COUNT = "BASE COUNT  $counta A  , $countc C , $countt T, $countg G\n";
    print "$BASE_COUNT\n";
   }

   elsif ($_ eq "ALL") {
	  $result13 = "";
	  $result13 = "$page";
	  print"$result13\n";
    }

}


my $filetosend = "$result\n$result1\n$result2\n$result3\n$result4\n$result5\n$result6\n$result7\n@result8\n@result9\n@result10\n@result11\n@result12\n$result13\n$BASE_COUNT\n";

#print "$filetosend\n";

open(FD, "> emailTest.dat");
print FD $filetosend;
close(FD);

print $address;

if ($address =~ m/(^[^@]+(@[-\w]+\.)+[a-z]{2,4}$)/) {                  
     $sendmail = $address;
}  
#print "Address: $address\nsendmail: $sendmail\n";
system("cat emailTest.dat | mail -s \"GenBank Request Results\" $sendmail");

#system(mail -s \"test\" $sendmail < $filetosend);

print "</pre></body></html>\n";

