# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl 1.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 2;
BEGIN { use_ok('Data::HTMLDumper') };

#########################

my $hash = {
    phil => [
        { type => 'desk', number => '6666' },
        { type => 'home', number => '555-3489' },
        { type => 'pager', number => '555-0123' }
    ],
    frank => [
        { type => 'desk', number => '5555' },
        { type => 'cell', number => '555-1111' }
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

                        number </td><td> 6666</td></tr><tr><td>
                        type </td><td> desk
                      </td></tr></table>
</td></tr><tr><td>
                      <table border='1'><tr><td>

                        number </td><td> 555-3489</td></tr><tr><td>
                        type </td><td> home
                      </td></tr></table>
</td></tr><tr><td>
                      <table border='1'><tr><td>

                        number </td><td> 555-0123</td></tr><tr><td>
                        type </td><td> pager
                      </td></tr></table>

                    </td></tr></table>
</td></tr><tr><td>
          frank </td><td> <table border='1'><tr><td>

                       <table border='1'><tr><td>

                         number </td><td> 5555</td></tr><tr><td>
                         type </td><td> desk
                       </td></tr></table>
</td></tr><tr><td>
                       <table border='1'><tr><td>

                         number </td><td> 555-1111</td></tr><tr><td>
                         type </td><td> cell
                       </td></tr></table>

                     </td></tr></table>

        </td></tr></table>
