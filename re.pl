#! /usr/bin/perl

use strict;
use warnings;

my $source_file_name=$ARGV[0];

open FH_OP,"<$source_file_name" or die ("Can not open the file: $source_file_name");
open FH_WR,">$source_file_name.to" or die ("Can not open the file: $source_file_name.to");

while(<FH_OP>){
	print $_;
	print FH_WR substr($_,1);
}

close(FH_WR);
close(FH_OP);

exit 0;
