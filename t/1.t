# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl 1.t'

#########################

use Test::More tests => 4;
BEGIN { use_ok('Data::HTMLDumper') };

#########################

my $list = [
    "phil", "crow", "programmer"
];

my $table = Dumper($list);
my $expected_table = <<EOJ;
<table border='1'><tr><td>

          phil</td></tr><tr><td>
          crow</td></tr><tr><td>
          programmer
        </td></tr></table>
EOJ

is($table, $expected_table, "simple list");

my $first_hash = {
    name => "phil"
};
my $first_hash_table = Dumper($first_hash);
my $expected_first_hash = <<EOJ;
<table border='1'><tr><td>

          name </td><td> phil
        </td></tr></table>
EOJ

is($first_hash_table, $expected_first_hash, "simple hash");

my $hash = {
    phil => [
        { type => 'desk'},
        { type => 'home'},
        { type => 'pager'},
    ],
};

my $module_out = Dumper($hash);
my @module_out = split /\n/, $module_out;

# Do not use Data::Dumper, HTMLDumper does that for us, doing it again
# raises flags.

chomp(my @correct = <DATA>);

is_deeply (\@correct, \@module_out, "sample output");

print $new;

__DATA__
<table border='1'><tr><td>

          phil </td><td> <table border='1'><tr><td>

                      <table border='1'><tr><td>

                        type </td><td> desk
                      </td></tr></table>
</td></tr><tr><td>
                      <table border='1'><tr><td>

                        type </td><td> home
                      </td></tr></table>
</td></tr><tr><td>
                      <table border='1'><tr><td>

                        type </td><td> pager
                      </td></tr></table>

                    </td></tr></table>

        </td></tr></table>
