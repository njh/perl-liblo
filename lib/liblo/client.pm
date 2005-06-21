package liblo::client;

################
#
# liblo: perl client bindings
#
# Copyright 2005 Nicholas Humfrey <njh@aelius.com>
#

use strict;
use XSLoader;
use Carp;
use liblo::message;

use vars qw/$VERSION/;

$VERSION="0.01";

XSLoader::load('liblo::api', $VERSION);



sub new {
    my $class = shift;
    my $self = { address => undef };
    
    # Bless the hash into an object
    bless $self, $class;

    # 1 parameter = URL
    # 2 parameters = host and port
    if (scalar(@_)==1) {
    	my ($url) = @_;

		$self->{address} = liblo::api::lo_address_new_from_url( $url );
    	
    } elsif (scalar(@_)==2) {
    	my ($host, $port) = @_;

		$self->{address} = liblo::api::lo_address_new( $host, $port );
    	
    } else {
    	croak( "invalid number of parameters" );
    }
    
    # Was there an error ?
    if (!defined $self->{address}) {
    	warn "Error creating lo_address";
    	undef $self;
    }
    
   	return $self;
}

sub errno {
	my $self=shift;

	return liblo::api::lo_address_errno( $self->{address} );
}

sub errstr {
	my $self=shift;

	return liblo::api::lo_address_errstr( $self->{address} );
}

sub send {
	my $self=shift;
	my ($path, $type, @params) = @_;
	my $message = new liblo::message( $type, @params );
	liblo::api::lo_send_message( $self->{address}, $path, $message->{message} );
}


sub send_message {
	my $self=shift;
	my ($path, $message) = @_;
	liblo::api::lo_send_message( $self->{address}, $path, $message->{message} );
}


sub DESTROY {
    my $self=shift;
    
    if (defined $self->{address}) {
    	liblo::api::lo_address_free( $self->{address} );
    	undef $self->address;
    }
}


1;

__END__

=pod

=head1 NAME

liblo::client - Perl client bindings for liblo high-level API

=head1 SYNOPSIS

  use liblo::client;

  my $lo = new liblo::client( 'osc.udp://localhost:4444/' );
  
  # or 
  
  my $lo = new liblo::client( 'localhost', 4444 );

  $lo->send( "/foo/bar", "ff", 0.1f, 23.0f );


=head1 DESCRIPTION

liblo::client

=head1 TODO


=over
=item Add libosc::server class
=item Add libosc::blob class
=item Add libosc::bundle class
=item Add support for int64
=item Add support for midi
=item Add support for timetags
=back


=head1 AUTHOR

Nicholas Humfrey, njh@aelius.com

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2005 Nicholas J. Humfrey

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

=cut
