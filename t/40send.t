use strict;
use Test;


# use a BEGIN block so we print our plan before modules are loaded
BEGIN { plan tests => 4 }

# load modules
use Net::LibLO;

# Create objects
my $lo = new Net::LibLO();
ok( $lo );
my $addr = new Net::LibLO::Address( 'localhost', 4542 );
ok( $addr );
my $mesg = new Net::LibLO::Message( 's', 'Hello World' );
ok( $mesg );


# Check port
ok( $lo->get_port() =~ /^\d{4,}$/ );

# Check URL
ok( $lo->get_url() =~ /^osc\.udp\:\/\// );


# Send Message
my $result = $lo->send( $addr, '/foo', $mesg );
ok( $result, 0 );



exit;
