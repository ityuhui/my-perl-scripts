#! /usr/bin/perl

use strict;
use warnings;

if(4 != @ARGV){
	print "\nWRONG!\nThe usage is replace.pl old_string new_string file_name file_name_replace\n\n";
	exit 1;
}


my $old_string=$ARGV[0];
my $new_string=$ARGV[1];
my $file_name=$ARGV[2];
my $file_name_replace=$ARGV[3];

open FH_OP,"<$file_name" or die("Can not open $file_name");
open FH_WR,">$file_name_replace" or die("Can not open $file_name_replace");

while(<FH_OP>){
	s/$old_string/$new_string/g;
	print FH_WR $_;

}


close(FH_OP);
close(FH_WR);

exit 0;

