#this subroutine does the following:
#1. connects to database and grabs all the data from it.
#2. opens a file on the server (checks if name of file exists, if yes then increments the number of file one up)
#3. writes database line by line to file. 
sub DBBackup {
    my $dbh=DBI->connect ("DBI:mysql:host=ec2-52-201-226-120.compute-1.amazonaws.com;database=nanobase","root", "nanobase") or die "could not connect to DB\n" . DBI-> errstr;
    my $sql = "select * from NANO";
    my $sth = $dbh->prepare($sql) or die "could not prepare query\n" . DBI-> errstr;
    my $rows = $sth-> execute () or die "could not execute query\n" . DBI-> errstr;

    #file name incrementing and file making
    for (my $fileNum=0;$fileNum<6;$fileNum++) {
        #can change this to whatever location eg. my $file = "./whatever/Output$fileNum.csv";
        my $file = "../icons/DBBackup$fileNum.csv";
        #if file doesn't exist..
        unless (-f $file) {
            #print "file $file does not exist therefore it will be created\n";
            #open file for output 
            open my $fh,'>', $file or die "could not open file";
            print "works";
            #fetch each row in the database and print to output file 
            
            print $fh "PARTICLE_TYPE,INORGANIC_MAT,ORGANIC_MAT,TARGET_STRAT,DIAMETER,POTENTIAL,SHAPE,MODEL,CANCER_TYPE,DELIVERY_EFFICIENCY,REFERENCE_ID,PARTICLE_ID,PUBLICATION_YEAR,QUANTIFICATION_METHOD\n";
            while(my @row = $sth->fetchrow_array) {
                my $x=join ",", @row;
                print $fh "$x\n"
            }
            close ($fh);
            #will make sure that only one file is created
            last;
        }
    }  
}
sub DBGetter {
    my $dbh=DBI->connect ("DBI:mysql:host=ec2-52-201-226-120.compute-1.amazonaws.com;database=nanobase","root", "nanobase") or die "could not connect to DB\n" . DBI-> errstr;
    my $sql = "select * from NANO";
    my $sth = $dbh->prepare($sql) or die "could not prepare query\n" . DBI-> errstr;
    my $rows = $sth-> execute () or die "could not execute query\n" . DBI-> errstr;


    my $file = "../icons/nano_data2.csv";
    #if file doesn't exist..

    #open file for output 
    open my $fh,'>', $file or die "could not open file";
    print "works";
    #fetch each row in the database and print to output file 
    print $fh "PARTICLE_TYPE,INORGANIC_MAT,ORGANIC_MAT,TARGET_STRAT,DIAMETER,POTENTIAL,SHAPE,MODEL,CANCER_TYPE,DELIVERY_EFFICIENCY,REFERENCE_ID,PARTICLE_ID,PUBLICATION_YEAR,QUANTIFICATION_METHOD\n";
    while(my @row = $sth->fetchrow_array) {
        my $x=join ",", @row;
        print $fh "$x\n"
    }
    close ($fh);

        
    
}
1

