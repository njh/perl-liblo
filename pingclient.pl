#!/usr/bin/perl -I ./blib/arch -I ./blib/lib
#
# OSC Ping Client
#

use Net::LibLO;
use strict;

# Create objects
my $lo = new Net::LibLO();
my $addr = new Net::LibLO::Address( 'localhost', 4542 );


# Add reply handler
$lo->add_method( '/reply', 's', \&replyhandler );

# Send the ping message
my $result = $lo->send( $addr, '/osc/ping' );
if ($result <= 0) {
	print "Pinging ".$addr->get_url()." failed: $result\n";
} else {
	print "Sent $result bytes to ".$addr->get_url()." from ".$lo->get_url()."\n";
}

# Wait for reply
$lo->recv();


print "Finished.\n";




sub replyhandler {
	my ($serv, $mesg, $path, $typespec, @params) = @_;
	print "Got reply.\n";
}