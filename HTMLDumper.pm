package Data::HTMLDumper;
use strict; use warnings;

require Exporter;

our @ISA = qw(Exporter);

our %EXPORT_TAGS = ( 'all' => [ qw(
	Dumper
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	Dumper
);

our $VERSION = '0.01';

use Data::Dumper ();

sub Dumper {
    my $original_output = Data::Dumper::Dumper(@_);
    $original_output    =~ s/'//g;
    my $output;

    $original_output    =~ /=\s*/gc;
    while ($original_output !~ /\G\Z/gcm) {
        if ($original_output =~
        /
            \G       # where we left off
            (
                \{ | \[     # opening brace or bracket
            )
        /gcx) {
            $output .= "<table border='1'><tr><td>\n";
        }
        elsif ($original_output =~
        /
            \G
            (
                \} | \]  # closing brace or bracket
            )
        /gcx) {
            $output .= "</td></tr></table>\n";
        }
        elsif ($original_output =~ /\G=>/gc) {
            $output .= "</td><td>";
        }
        elsif ($original_output =~ /\G,/gc) {
            $output .= "</td></tr><tr><td>";
        }
        elsif ($original_output =~ /\G;/gc) { }  # discard ;
        else {
            $original_output =~ /\G(.)/gcs;
            $output .= $1;
        }
    }

    return $output;
}

1;
__END__

=head1 NAME

Data::HTMLDumper - Uses Data::Dumper to make HTML tables of structures

=head1 SYNOPSIS

  use Data::HTMLDumper;

  print Dumper(\%hash);

=head1 ABSTRACT

  Data::HTMLDumper turns Data::Dumper::Dumper output into an HTML table.
  It's for those who like Data::Dumper for quick peeks at their structures,
  but need to display the output in a web browser.

=head1 DESCRIPTION

If you like to use Data::Dumper for quick and dirty pictures of your structures
during development, but you are now developing for the web, this modules might
be for you.  It uses Data::Dumper, but formats the results as HTML tables.

It only implements the Dumper method.  It can only handle one reference
at a time which must be an array or hash reference.  If there is any interest,
it could be expanded in the future.

=head2 EXPORT

Dumper

=head1 DEPENDENCIES

Data::Dumper

=head1 BUGS and OMISSIONS

Only one reference can be processed in each call.  It must be a hash or
array ref.

Blessings are not handled well.  They don't break the picture, but they
are unsightly.

=head1 SEE ALSO

This module depends on Data::Dumper to do the real work.  Check its
documentation for details about how to call Dumper.

=head1 AUTHOR

Phil Crow, E<lt>philcrow2000@yahoo.com<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2003 by Phil Crow

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl 5.8.0 itself. 

=cut
