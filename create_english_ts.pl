#! /usr/bin/perl

use strict;
use warnings;

my $source_file_name=$ARGV[0];
my $target_file_name=$source_file_name . ".e.ts";

open FH_OP,"<$source_file_name" or die("Can not open the file: $source_file_name");
open FH_WR,">$target_file_name" or die("Can not open the file: $target_file_name");

my $previous_wordings;
my $current_line;
while(<FH_OP>){
    $current_line=$_;
    if(/<source>/g){
        print "$_\n";
        my $str_begin=index($current_line,">") + 1;
        my $str_end = index($current_line,"</") - 1;
	$previous_wordings=substr($current_line,$str_begin,( $str_end - $str_begin + 1 ));
    }
    if(/<\/translation>/g){
        print "$_\n";
        $current_line= "        <translation>" . $previous_wordings . "</translation>\n" ; 
    }
    print FH_WR $current_line;
}

close(FH_WR);
close(FH_OP);

exit 0;
