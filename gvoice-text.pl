#!/usr/bin/perl
#
# Requires: Google::Voice
#
# Thanks to:
#   http://search.cpan.org/~tempire/Google-Voice/lib/Google/Voice.pm

my $usage = <<'USAGE';
Usage:
    Send text (SMS) message to NUMBER
        gvoice-text.pl NUMBER message

    You can create contact names (aliases) by adding to the "contacts" hash:
        gvoice-text.pl CONTACT_NAME message

    You can set username and/or password as environment variables:
        GVOICE_USERNAME=myuser GVOICE_PASSWORD=xxx gvoice-text.pl ...
USAGE

# Add your contacts here
my %contacts = (
    "jack" => "5555555555",
    "jill" => "5555555556",
    );


use Google::Voice;

sub get_number {
    return $_[0] if $_[0] =~ /^\d+$/;
    return %contacts{$_[0]};
}

sub get_password {
    print "Enter password:";
    my $pw;
    system('stty','-echo');
    chomp($pw=<STDIN>);
    system('stty','echo');
    print "\n";
    return $pw;
}

sub get_username {
    print "Enter username:";
    my $user = <STDIN>;
    return $user;
}

if ($#ARGV != 1) {
    print $usage;
} else {
    my $user;
    $user = get_username() unless $user = $ENV{"GVOICE_USERNAME"};

    my $pw;
    $pw = get_password() unless $pw = $ENV{"GVOICE_PASSWORD"};

    die "Invalid username/password" unless my $g = Google::Voice->new->login($user, $pw);

    my $recipient = get_number($ARGV[0]);
    die "Invalid recipient" unless $recipient;

    shift(@ARGV);
    my $msg = join(" ", @ARGV);

    die "Recipient number not valid" unless $g->send_sms($recipient => $msg);
    print "Sent to $recipient: $msg\n";
}
