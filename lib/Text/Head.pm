package Text::Head;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

use Exporter::Rinci qw(import);

our %SPEC;

# TODO: accept filehandle in addition to string
# TODO: mode characters/bytes
# TODO: record separator option
# TODO: accept negative number (-N), which means all but last N lines of file

$SPEC{head_text} = {
    v => 1.1,
    summary => 'Output the first part of text',
    args => {
        text => {
            schema => 'str*',
            req => 1,
        },
        lines => {
            schema => 'int*',
            default => 10,
        },
        hint => {
            schema => 'bool',
        },
    },
    result_naked => 1,
    examples => [
        {
            args => {text=>"line 1\nline 2\nline 3\nline 4\n", lines=>2},
            result => "line 1\nline 2\n",
        }
    ],
};
sub head_text {
    my %args = @_;

    my $lines = $args{lines} // 10;

    my @lines = split /^/, $args{text};
    if ($lines >= @lines) {
        return $args{text};
    } else {
        my $remaining = @lines - $lines;
        my $res = join("", @lines[0..$lines-1]);
        if ($args{hint}) {
            $res .= "\n" unless $res =~ /\R\z/;
            $res .= "(... $remaining more line(s) not shown ...)\n";
        }
        return $res;
    }
}

1;
# ABSTRACT:


=head1 SEE ALSO

The L<head> Unix command.
