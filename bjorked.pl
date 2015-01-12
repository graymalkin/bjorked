# bjorked.pl
#
# Licensed under the MIT license. Based on the splitlong.pl plugin
# which can be found at:
# https://github.com/irssi/scripts.irssi.org/blob/gh-pages/scripts/splitlong.pl
###
use strict;
use vars qw($VERSION %IRSSI);

use Irssi 2011001;

$VERSION = "0.1";
%IRSSI = (
    authors      => "Simon Cooksey",
    contact      => "sjc80\@kent.ac.uk",
    name         => "björked",
    license      => "MIT http://opensource.org/licenses/",
    description  => "Replace borked and borken with derivations of björk"
    );

sub message_bjork {
    my ($cmd, $server, $winitem) = @_;
    my ($param, $target,$data) = $cmd =~ /^(-\S*\s)?(\S*)\s(.*)/;

    my @subs = (
        # Match borked type strings
        [m/\bborke[dn]\b/i, 
            [s/\b([Bb])o([Rr][Kk][Ee][DdNn])\b/\1jö\2/g,
             s/\b([Bb])O([Rr][Kk][Ee][DdNn])\b/\1JÖ\2/g ]],
        # Match broken type strings
        [m/\bbroke[dn]\b/i],
            [s/\b([Bb])([Rr])o([Kk][Ee][DdNn])\b/\1jö\2\3/g,
             s/\b([Bb])([Rr])O([Kk][Ee][DdNn])\b/\1JÖ\2\3/g ]]
    )
    my $modified = 0;

    foreach(@subs)              # For each substitution
    {
        if($data =~ $_[0])      # Check matches
        {
            foreach($_[1])      # For each transformation in substitutions
            {
                $data =~ $_;    # Apply
                $modified = 1;  # Flag chaned
            }
        }
    }

    if($modified) {
        # print "$param$target $data";
        Irssi::signal_emit("command msg", "$param$target $data", $server, $winitem);
        Irssi::signal_stop();
    }
}

Irssi::command_bind('msg', 'message_bjork');
