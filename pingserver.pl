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
$lo->recv();


print "Finished.\n";




sub pinghandler {
	my ($serv, $mesg, $path, $typespec, @params) = @_;

	#print Dumper( @_ );
	print "Got ping.\n";
}