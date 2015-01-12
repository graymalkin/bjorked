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
    description  => "Replace borked and broken with derivations of björk"
    );

sub message_bjork {
    my ($cmd, $server, $winitem) = @_;
    my ($param, $target,$data) = $cmd =~ /^(-\S*\s)?(\S*)\s(.*)/;

    # Replace all broken and borked with björk equivs. Ignore case.
    $data =~ s/broken/björken/gi;
    $data =~ s/borked/björked/gi;
    $data =~ s/borken/björken/gi;

    # print "$target $_";
    Irssi::signal_emit("command msg", "$target $data", $server, $winitem);
    Irssi::signal_stop();
}

Irssi::command_bind('msg', 'message_bjork');
