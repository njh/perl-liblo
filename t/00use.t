
use strict;
use Test;


# use a BEGIN block so we print our plan before loading modules
BEGIN { plan tests => 3 }


# Check Net::LibLO loads ok
use Net::LibLO;
ok(1);

# Check Net::LibLO::Message loads ok
use Net::LibLO::Message;
ok(1);

# Check Net::LibLO::Client loads ok
use Net::LibLO::Client;
ok(1);


exit;
