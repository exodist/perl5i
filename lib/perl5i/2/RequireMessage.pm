package perl5i::2::RequireMessage;
use strict;
use warnings;

# This is the sub that displays the message
my $diesub = sub {
    my ( $sub, $mod ) = @_;
    my ( $package, $file, $line ) = caller;
    die( <<EOT );
Can't locate $mod in \@INC (Your Perl library.) at $file line $line
You may need to install it from CPAN or another repository.
Your library paths are:
@{[ map { "  $_\n" } grep { !ref($_) } @INC ]}
at $file line $line
EOT
};

# This sub makes sure the die sub si always at the end of @INC.
push @INC => sub {
    return if ref($INC[-1]) && $INC[-1] == $diesub;
    @INC = grep { !(ref($_) && $_ == $diesub) } @INC;
    push @INC => $diesub;
};
push @INC => $diesub;

1;
