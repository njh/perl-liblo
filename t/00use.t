
use strict;
use Test;


# use a BEGIN block so we print our plan before LibLO::Client is loaded
BEGIN { plan tests => 1 }

# load LibLO::Client
use LibLO::Client;


# Module has loaded sucessfully 
ok(1);


exit;
