use Net::LibLO;
use strict;


my $lo = new Net::LibLO(  );
my $addr = new Net::LibLO::Address( 'osc.udp://calx.ecs.soton.ac.uk:4444/echoo' );

my $msg = new LibLO::Message();
$msg->add_float(0.4);
$msg->add_int32(257);
$msg->add_double(rand()/100);
$msg->add_char('a');
$msg->add_string('hello world');
$msg->add_true();
$msg->add_nil();

#$msg->pretty_print();

$lo->send_message($addr, "/foo/bar", $msg);

$lo->send("/hello/world", "s", "moof!");


undef $lo;
undef $msg;
