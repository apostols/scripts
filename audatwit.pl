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
    die "Nombre de usuario o password no definido en este archivo.\n";
}


if (`ps -C audacious` =~ /audacious/) {
        my $artist;
        my $songtitle;

        $artist  = `audtool --current-song-tuple-data artist`;
        $songtitle = `audtool --current-song `;

        chomp $songtitle;
        chomp $artist;

        my $music = "#nowplaying $songtitle - $artist. Powered by: audacious.";

        print($music."\n");
        $bot->update($music);

} else {
        print "Audacious is not currently running.\n";
        }

