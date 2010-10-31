#! /usr/bin/perl -w
use 5.010;

use Data::Show; use Test::More 'no_plan';
my $STDERR; close STDERR; open *STDERR, '>', \$STDERR or die $!;

my %foo = (foo => 1, food => 2, fool => 3, foop => 4, foon => [5..10]);
my @bar = qw<b a r>;
my $baz = 'baz';
my $ref = \@bar;

show %foo;
show $/;
show @bar;
show (
    @bar,
    $baz,
);
show $baz;
show $ref;
show @bar[do{1..2;}];
show 2*3;
show 'a+b';
show 100 * sqrt length $baz;
show $foo{q[;{{{]};
do {
    show 'foo' ~~ m/;{\/{/
};
show $/{Answer};

my @expected = <DATA>;
my @got      = split "(?<=\n)", $STDERR;

for my $n (0..$#expected) {
    is $got[$n], $expected[$n] => ": $expected[$n]";
}

__DATA__
======(  %foo  )=============================[ 'show.t', line 12 ]======

    { foo => 1, food => 2, fool => 3, foon => [5 .. 10], foop => 4 }


======(  $/  )===============================[ 'show.t', line 13 ]======

    "\n"


======(  @bar  )=============================[ 'show.t', line 14 ]======

    ["b", "a", "r"]


======(  @bar, $baz,  )======================[ 'show.t', line 15 ]======

    ("b", "a", "r", "baz")


======(  $baz  )=============================[ 'show.t', line 19 ]======

    "baz"


======(  $ref  )=============================[ 'show.t', line 20 ]======

    ["b", "a", "r"]


======(  @bar[do{1..2;}]  )==================[ 'show.t', line 21 ]======

    ("a", "r")


======(  2*3  )==============================[ 'show.t', line 22 ]======

    6


======(  'a+b'  )============================[ 'show.t', line 23 ]======

    "a+b"


======(  100 * sqrt length $baz  )===========[ 'show.t', line 24 ]======

    "173.205080756888"


======(  $foo{q[;{{{]}  )====================[ 'show.t', line 25 ]======

    undef


======(  'foo' ~~ m/;{\/{/  )================[ 'show.t', line 27 ]======

    ""


======(  $/{Answer}  )=======================[ 'show.t', line 29 ]======

    undef
