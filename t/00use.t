
use strict;
use Test;


# use a BEGIN block so we print our plan before loading modules
BEGIN { plan tests => 3 }


# Check LibLO loads ok
use LibLO;
ok(1);

# Check LibLO::Message loads ok
use LibLO::Message;
ok(1);

# Check LibLO::Client loads ok
use LibLO::Client;
ok(1);


exit;
