
use strict;
use Test;


# use a BEGIN block so we print our plan before liblo::client is loaded
BEGIN { plan tests => 1 }

# load liblo::client
use liblo::client;


# Module has loaded sucessfully 
ok(1);


exit;
