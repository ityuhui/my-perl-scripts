#! /usr/bin/perl

use strict;
use warnings;

my $comm_param_number=@ARGV;

if( 1 != $comm_param_number ){
    print "\nUsage:\n\n";
    print "assamble_apn.pl global_apn_file_name\n\n";
    exit 0;
}

my $source_file_name=$ARGV[0];

open FH_OP,"<$source_file_name" or die ("Can not open the file: $source_file_name");
open FH_WR,">$source_file_name.to" or die ("Can not open the file: $source_file_name.to");

my @bufferline;
my $mcc;
my $mnc;
my $dial_number;
my $apn;
my $username;
my $password;
my $profile_name;
my $auth_type;
my $pdp_type;
my $oneentry;

my $save_user_name= "0";
my $obtain_apn= "1";
my $use_apn= "0";
my $pap_mode= "1";
my $chap_mode= "0";
my $plmn;

while(<FH_OP>){
    @bufferline  = split(/,/,$_);
    $mcc         = $bufferline[0];
    $mnc         = $bufferline[1];
    $dial_number = $bufferline[2];
    $apn         = $bufferline[3];
    $username    = $bufferline[4];
    $password    = $bufferline[5];
    $profile_name= $bufferline[6];
    $auth_type   = $bufferline[7];
    $pdp_type    = $bufferline[8];

    if( "" ne $username ){
        $save_user_name="1";
    }
    else{
        $save_user_name="0";
    }

    if( "" ne $apn ){
        $obtain_apn = "0";
        $use_apn = "1";
    }
    else{
        $obtain_apn = "1";
        $use_apn = "0";
    }

    if( ( "chap" eq $auth_type) or ( "CHAP" eq $auth_type ) ){
        $pap_mode="0";
        $chap_mode="1";
    }
    else{
        $pap_mode="1";
        $chap_mode="0";
    }

    if( $mnc > 99 ){
        $plmn=sprintf "%d%d",$mcc,$mnc;
    }
    else{
        $plmn=sprintf "%d%02d",$mcc,$mnc;
    }

    $oneentry="[ the record of <$profile_name> ]\nconfig file name = $profile_name-|-Phone = $dial_number-|-Username = $username-|-Password = $password-|-save user name = $save_user_name-|-ask user name = 0-|-obtain APN = $obtain_apn-|-use APN = $use_apn-|-APN = $apn-|-IP modal = 1-|-PPP modal = 0-|-PAP modal = $pap_mode-|-CHAP modal = $chap_mode-|-obtain DNS = 1-|-use DNS = 0-|-preNameserver -|-altNameserver -|-obtain PDP = 1-|-user PDP = 0-|-PDP = -|-delete Enable = can&edit-|-IMSI = $plmn-|-defaultOpenURL =\n\n"; 

    print $oneentry;
    print FH_WR $oneentry;
}

close(FH_WR);
close(FH_OP);

exit 0;
