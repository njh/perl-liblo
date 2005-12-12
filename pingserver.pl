#!/usr/bin/perl -I ./blib/arch -I ./blib/lib
#
# OSC Ping Server
#

use Net::LibLO;
use strict;

# Create objects
my $lo = new Net::LibLO( 4542 );


# Add method
$lo->add_method( '/osc/ping', '', \&pinghandler );

# Wait for ping
my $bytes = $lo->recv();
print "Recieved $bytes bytes.\n";




sub pinghandler {
	my ($serv, $mesg, $path, $typespec, @params) = @_;

	#print Dumper( @_ );
	print "Got ping.\n";
}