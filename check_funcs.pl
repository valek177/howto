#!/usr/bin/perl

use 5.010;
use File::Find;

my %h;
open my $f, "</home/valek/libscst.map.text";
while (<$f>) {
        s/^\s*|;?\s*$//g;

        $h{"C.$_"} = "";
}

find{
        no_chdir => 1,
        wanted => sub{
                return unless /\.go$/;
                return if -d;

                my $fn = $_;
                if (open my $f, "<", $fn) {
                        my $raw = join "\n", <$f>;

                        close $f;

                        for my $k (keys %h) {
                                next if $h{$k};
                                $h{$k} = $fn
                                        if $raw =~ /(\b\Q$k\E\b)/;
                        }
                }

        }
}, "/home/valek/git/server/common/lib/libscst/";

say $_ for grep { !$h{$_} } keys %h;
~                                        
