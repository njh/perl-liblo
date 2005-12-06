
use strict;
use Test;


# use a BEGIN block so we print our plan before Net::LibLO::Address is loaded
BEGIN { plan tests => 3 }

# load Net::LibLO::Address
use Net::LibLO::Address;

# Create a message object
my $addr = new Net::LibLO::Address( 'localhost', 4542 );
ok( $addr );

# Check get_hostname
ok($addr->get_hostname(), 'localhost');

# Check get_port
ok($addr->get_port(), 4542);

# Check get_url
ok($addr->get_url(), 'osc.udp://localhost:4542/');

# Delete the client object
undef $lo;
ok(1);

exit;
