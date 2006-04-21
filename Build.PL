#!/usr/bin/perl
#

use Module::Build;
use strict;


# Check for pkg-config
my $pkgconfig = `which pkg-config`;
chomp($pkgconfig);
if ($pkgconfig =~ /not found/) {
	die "Error: pkgconfig is not available on your system";
}

# Check for liblo
my $liblo_version = `$pkgconfig --modversion liblo`;
chomp($liblo_version);
if ($liblo_version !~ /^\d+\.\d+$/) {
	print STDERR $liblo_version;
	exit -1;
} else {
	print "Found liblo library version $liblo_version.\n";
}

# Is it new enough ?
if ($liblo_version < 0.23) {
	die "LibLO Version 0.23 or higher is required.\n";
}

# Get CFLAGS and LDFLAGS
my $CFLAGS = `$pkgconfig --cflags liblo`;
my $LDFLAGS = `$pkgconfig --libs liblo`;
chomp( $CFLAGS, $LDFLAGS );



# Create the Build script
my $build = Module::Build->new
(
	module_name => 'Net::LibLO',
	license => 'gpl',
	build_requires => {
		'Module::Build' => '0.20'
	},
	
	create_makefile_pl => 'passthrough',
	
	requires => {
		'Test' => '1.00',
	},
	
	extra_compiler_flags => $CFLAGS,
	extra_linker_flags => $LDFLAGS,
);

$build->create_build_script;
