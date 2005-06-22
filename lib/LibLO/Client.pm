package LibLO::Client;

################
#
# liblo: perl bindings
#
# Copyright 2005 Nicholas J. Humfrey <njh@aelius.com>
#

use Carp;
use LibLO;
use LibLO::Message;
use strict;



sub new {
    my $class = shift;
    my $self = { address => undef };
    
    # Bless the hash into an object
    bless $self, $class;

    # 1 parameter = URL
    # 2 parameters = host and port
    if (scalar(@_)==1) {
    	my ($url) = @_;

		$self->{address} = LibLO::lo_address_new_from_url( $url );
    	
    } elsif (scalar(@_)==2) {
    	my ($host, $port) = @_;

		$self->{address} = LibLO::lo_address_new( $host, $port );
    	
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

	return LibLO::lo_address_errno( $self->{address} );
}

sub errstr {
	my $self=shift;

	return LibLO::lo_address_errstr( $self->{address} );
}

sub send {
	my $self=shift;
	my ($path, $type, @params) = @_;
	my $message = new LibLO::Message( $type, @params );
	return LibLO::lo_send_message( $self->{address}, $path, $message->{message} );
}


sub send_message {
	my $self=shift;
	my ($path, $message) = @_;
	return LibLO::lo_send_message( $self->{address}, $path, $message->{message} );
}


sub DESTROY {
    my $self=shift;
    
    if (defined $self->{address}) {
    	LibLO::lo_address_free( $self->{address} );
    	undef $self->{address};
    }
}


1;

__END__

=pod

=head1 NAME

LibLO::Client - Perl client bindings for liblo high-level API

=head1 SYNOPSIS

  use LibLO::Client;

  my $lo = new LibLO::Client( 'osc.udp://localhost:4444/' );
  
  my $lo = new LibLO::Client( 'localhost', 4444 );

  $lo->send( "/foo/bar", "Tsfi", "hello", 0.1f, 23 );

  my $message = new LibLO::Message();
  $message->add_string( "Hello World" );
  $lo->send_message( "/foo/bar", $message );


=head1 DESCRIPTION

LibLO::Client provides methods for sending messages to a 
server process. 

=head2 METHODS

=over 4

=item B<new( url )>

Create a Client object from an OSC URL.

=item B<new( host, port )>

Create a Client object from a specified host address and port.

=item B<send( path, types, ... )>

Send an OSC message without having to create a LibLO::Message object.

C<path> the OSC path the message will be delivered to.

C<types> The types of the data items in the message.


=over 4

=item B<i>  32 bit signed integer.

=item B<f>  32 bit IEEE-754 float.

=item B<s>  A string

=item B<d>  64 bit IEEE-754 double.

=item B<S>  A symbol - used in systems which distinguish strings and symbols.

=item B<c>  A single 8bit charater

=item B<T>  Symbol representing the value True.

=item B<F>  Symbol representing the value False.

=item B<N>  Symbol representing the value Nil.

=item B<I>  Symbol representing the value Infinitum.

=back

C<...> The data values to be transmitted.
The types of the arguments passed here must agree with the 
types specified in the type parameter.

Returns -1 if there was an error.

=item B<send_message( path, message )>

Send a C<LibLO::Message> object to the specified path.

Returns -1 if there was an error.

=item B<errno()>

Return the error number for the last error.

=item B<errstr()>

Return the error string for the last error.

=back

=head1 SEE ALSO

L<LibLO>

L<LibLO::Message>

L<http://plugin.org.uk/liblo/>

=head1 AUTHOR

Nicholas J. Humfrey, njh@aelius.com

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
