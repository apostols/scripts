# USAGE:
#
# /bitly URL
#

# Copyright 2010 Juan Angulo Moreno <apostols@gmail.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.


use strict;
use WWW::Shorten::Bitly;
use vars qw($VERSION %IRSSI);

$VERSION = "2010081300";

%IRSSI = (
	authors		=>	"Juan Angulo Moreno",
	contact		=>	"juan\@apuntale.com",
	name		=>	"bitly",
	description	=>	"url shorten with irssi using bit.ly",
	license		=>	"GPLv2",
	changed		=>	"$VERSION",
	commands	=>	"bitly"
);

use Irssi 20020324;

sub shorturl ($)
{
	my ($url) = @_;
	my $bitly = WWW::Shorten::Bitly->new(URL => $url, USER => "YOUR_USERNAME_HERE", APIKEY => "YOUR_API_KEY_HERE");
	$bitly->shorten(URL => $url);
	return $bitly->{bitlyurl};
}

sub cmd_bitly ($$$)
{
	my ($arg, $server, $witem) = @_;

	if ($witem && ($witem->{type} eq 'CHANNEL' || $witem->{type} eq 'QUERY'))
	{
		$witem->command('MSG '.$witem->{name}.' '.shorturl($arg));
	} else {
		print CLIENTCRAP "%B>>%n ".shorturl($arg);
	}
}

Irssi::command_bind('bitly',\&cmd_bitly);

print "%B>>%n ".$IRSSI{name}." ".$VERSION." loaded";

