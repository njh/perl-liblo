package Net::LibLO;

################
#
# liblo: perl bindings
#
# Copyright 2005 Nicholas J. Humfrey <njh@aelius.com>
#

use XSLoader;
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
    my $self = {};
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

sub add_method {
    my $self=shift;
    my ($path, $typespec, $handler, $userdata) = @_;
    

}

sub del_method {
    my $self=shift;
    my ($path, $typespec) = @_;

}

sub send {
	my $self=shift;

}

sub recv {
	my $self=shift;

}

sub recv_noblock {
	my $self=shift;
	my ($timeout) = @_;

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

LibLO - Perl interface for liblo Lightweight OSC library

=head1 DESCRIPTION

liblo-perl is a Perl Interface for the liblo Lightweight OSC library.

See L<LibLO::Client> for details of how to use this module in a client.

=head1 TODO

=over

=item Create LibLO::Server class

=item Create LibLO::Blob class

=item Create LibLO::Bundle class

=item Add support for int64

=item Add support for midi

=item Add support for timetags

=back

=head1 SEE ALSO

L<LibLO::Client>

L<LibLO::Message>

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
