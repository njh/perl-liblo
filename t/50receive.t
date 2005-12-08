use strict;
use Test;


# use a BEGIN block so we print our plan before modules are loaded
BEGIN { plan tests => 11 }

# load modules
use Net::LibLO;

# Create objects
my $lo = new Net::LibLO();

# Add method


# Destroy the LibLO object
undef $lo;
ok( 1 );

exit;





sub myhandler {
	my ($serv, $mesg, $path, $types, @params) = @_;

	
}
