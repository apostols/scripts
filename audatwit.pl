#!/usr/bin/perl -w
# Copyright 2010 Juan Angulo Moreno <apostols@gmail.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.

use strict;
use warnings;
use Net::Twitter::Lite;

my $username = "";
my $password = "";

my $bot = Net::Twitter::Lite->new(
        source => "Blackbird",
        username => $username,
        password => $password
);

if (($username eq "") && ($password eq "")) {
    die "Username or password is not defined!.\n";
}

my ($input) = @ARGV;

# dirty hack string: FIXME
if (!$input) { $input = "nothing"; }


if (`ps -C audacious` =~ /audacious/) {
        my $artist;
        my $songtitle;

        $artist  = `audtool --current-song-tuple-data artist`;
        $songtitle = `audtool --current-song `;

        chomp $songtitle;
        chomp $artist;

        my $music = "#nowplaying $songtitle - $artist. #audacious";
	#$music =~ s/^(.{137}).*$/$1.../s if length($music) > 140;

	if ($input eq "debug") {
	    print($music."\n");
            
	    print("Do you post this? (y/N): ");
            my $what = <STDIN>;
            chomp $what;
	    
	    if (($what eq "y") || ($what eq "Y")) {
	    	$bot->update($music);
		print ("Done.\n");
            } 
	
	} else 
	  {
	    $bot->update($music);
	  }

} else {
        print "Audacious is not currently running.\n";
        }

