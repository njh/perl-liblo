
use strict;
use Test;


# use a BEGIN block so we print our plan before LibLO::Client is loaded
BEGIN { plan tests => 3 }

# load LibLO::Client
use LibLO::Client;

# Create a message object
my $lo = new LibLO::Client( 'localhost', 4542);
ok( $lo );

# Send a message
my $result = $lo->send( '/test', 'siT', 'hello', 10 );
ok($result, 28);

# Delete the client object
undef $lo;
ok(1);

exit;
