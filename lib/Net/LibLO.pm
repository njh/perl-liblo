package Net::LibLO;

################
#
# liblo: perl bindings
#
# Copyright 2005 Nicholas J. Humfrey <njh@aelius.com>
#

use XSLoader;
use Data::Dumper;
use Carp;

use Net::LibLO::Address;
use Net::LibLO::Message;
use Net::LibLO::Bundle;
use strict;

use vars qw/$VERSION/;

$VERSION="0.03";

XSLoader::load('Net::LibLO', $VERSION);



sub new {
    my $class = shift;
    my ($port, $protocol) = @_;
    
    # Default to using random UDP port
    $port = '' if (!defined $port);
    $protocol = 'udp' if (!defined $protocol);

    # Bless the hash into an object
    my $self = { 'method_handlers'=>[] };
    bless $self, $class;
        
    # Create new server instance
    $self->{server} = Net::LibLO::lo_server_new_with_proto( $port, $protocol );
    if (!defined $self->{server}) {
    	carp("Error creating lo_server");
    	undef $self;
    }

   	return $self;
}

sub get_port {
    my $self=shift;
	return Net::LibLO::lo_server_get_port( $self->{server} );
}

sub get_url {
    my $self=shift;
	return Net::LibLO::lo_server_get_url( $self->{server} );
}

sub send {
	my $self=shift;
	my $dest=shift;
	
	# Contruct an address object ?
	if (ref($dest) ne 'Net::LibLO::Address') {
		$dest = new Net::LibLO::Address($dest);
	}
	
	if (ref($_[0]) eq 'Net::LibLO::Bundle') {
		# Send a bundle
		my $bundle = shift;
		return Net::LibLO::lo_send_bundle_from( $dest->{'address'}, $self->{'server'}, $bundle->{'bundle'} );
	} else {
		# Send a meesage
		my $path = shift;
		my $mesg;
		if (ref($_[0]) eq 'Net::LibLO::Message') {
			$mesg = $_[0];
		} else {
			$mesg = new Net::LibLO::Message( @_ );
		}
		
		return Net::LibLO::lo_send_message_from( $dest->{'address'}, $self->{'server'}, $path, $mesg->{'message'} );
	}
}

sub recv {
	my $self=shift;

	return Net::LibLO::lo_server_recv( $self->{'server'} );
}

sub recv_noblock {
	my $self=shift;
	my ($timeout) = @_;

	$timeout = 0 unless (defined $timeout);

	return Net::LibLO::lo_server_recv_noblock( $self->{'server'}, $timeout );
}

sub add_method {
    my $self=shift;
    my ($path, $typespec, $handler, $userdata) = @_;
    
    # Check parameters
    carp "Missing typespec parameter" unless (defined $typespec);
    carp "Missing path parameter" unless (defined $path);
    carp "Missing handler parameter" unless (defined $handler);
    carp "Handler parameter isn't a code reference" unless (ref($handler) eq 'CODE');
    #carp "Handle parameter isn't subroutine reference" unless (ref
    
    # Create hashref to store info in
    my $handle_ref = {
    	'method' => $handler,
    	'server' => $self,
    	'path' => $path,
    	'typespec' => $typespec,
    	'userdata' => $userdata
    };
    
    # Add the method handler
	my $result = Net::LibLO::lo_server_add_method( $self->{server}, $path, $typespec, $handle_ref );
	if (!defined $result) {
    	carp("Error adding method handler");
	} else {
		# Add it to array of method handlers
		push( @{$self->{'method_handlers'}}, $handle_ref );
	}
	
	return $result;
}

#sub del_method {
#    my $self=shift;
#    my ($path, $typespec) = @_;
#
#	my $result = Net::LibLO::lo_server_del_method( $self->{server}, $path, $typespec );
#
#	# XXX: Remove from array too
#}

sub _method_dispatcher {
	my ($ref, $mesg, $path, $typespec, @params) = @_;
	
	my $serv = $ref->{server};
	my $message = new Net::LibLO::Message( $mesg );
	my $userdata = $ref->{userdata};

	# Call the proper perl subroutine
	return &{$ref->{method}}( $serv, $message, $path, $typespec, $userdata, @params);
}


sub DESTROY {
    my $self=shift;
    
    if (defined $self->{server}) {
    	Net::LibLO::lo_server_free( $self->{server} );
    	undef $self->{server};
    }
}


1;

__END__

=pod

=head1 NAME

Net::LibLO - Perl interface for liblo Lightweight OSC library

=head1 DESCRIPTION

liblo-perl is a Perl Interface for the liblo Lightweight OSC library.


=head1 SEE ALSO

L<Net::LibLO::Address>

L<Net::LibLO::Bundle>

L<Net::LibLO::Message>

L<http://plugin.org.uk/liblo/>

=head1 AUTHOR

Nicholas J. Humfrey <njh@aelius.com>

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
