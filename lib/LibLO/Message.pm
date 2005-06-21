package LibLO::Message;

################
#
# liblo: perl bindings
#
# Copyright 2005 Nicholas Humfrey <njh@aelius.com>
#

use XSLoader;
use Carp;
use strict;

XSLoader::load('LibLO');



sub new {
    my $class = shift;
    my $self = { message => LibLO::lo_message_new() };
    my @types = split(//, shift);
    
    # Bless the hash into an object
    bless $self, $class;
    
    
    # Type and parameters supplied ?
	foreach my $type (@types) {
	
		if    ($type eq 'i') {  $self->add_int32( shift ) }
		elsif ($type eq 'f') {  $self->add_float( shift ) }
		elsif ($type eq 's') {  $self->add_string( shift ) }
		elsif ($type eq 'd') {  $self->add_double( shift ) }
		elsif ($type eq 'S') {  $self->add_symbol( shift ) }
		elsif ($type eq 'c') {  $self->add_char( shift ) }
		elsif ($type eq 'T') {  $self->add_true() }
		elsif ($type eq 'F') {  $self->add_false() }
		elsif ($type eq 'N') {  $self->add_nil() }
		elsif ($type eq 'I') {  $self->add_infinitum() }
		else {
			croak("Unsupported character '$type' in format.");
		}
	
	}
    
   	return $self;
}

sub pretty_print {
	my $self=shift;

	LibLO::lo_message_pp( $self->{message} );
}

sub add_char {
	my $self=shift;
	my ($char) = @_;
	LibLO::lo_message_add_char( $self->{message}, $char );
}


sub add_nil {
	my $self=shift;
	LibLO::lo_message_add_nil( $self->{message} );
}

sub add_true {
	my $self=shift;
	LibLO::lo_message_add_true( $self->{message} );
}

sub add_false {
	my $self=shift;
	LibLO::lo_message_add_false( $self->{message} );
}

sub add_infinitum {
	my $self=shift;
	LibLO::lo_message_add_infinitum( $self->{message} );
}

sub add_double {
	my $self=shift;
	my ($double) = @_;
	LibLO::lo_message_add_double( $self->{message}, $double );
}

sub add_float {
	my $self=shift;
	my ($float) = @_;
	LibLO::lo_message_add_float( $self->{message}, $float );
}

sub add_float {
	my $self=shift;
	my ($float) = @_;
	LibLO::lo_message_add_float( $self->{message}, $float );
}

sub add_int32 {
	my $self=shift;
	my ($int) = @_;
	LibLO::lo_message_add_int32( $self->{message}, $int );
}

sub add_string {
	my $self=shift;
	my ($string) = @_;
	LibLO::lo_message_add_string( $self->{message}, $string );
}

sub add_symbol {
	my $self=shift;
	my ($symbol) = @_;
	LibLO::lo_message_add_symbol( $self->{message}, $symbol );
}

sub DESTROY {
    my $self=shift;
    
    if (defined $self->{message}) {
    	LibLO::lo_message_free( $self->{message} );
    	undef $self->message;
    }
}


1;

__END__

=pod

=head1 NAME

LibLO::blob

=head1 SYNOPSIS

  use LibLO::blob;

  my $blob = new LibLO::message( );
  


=head1 DESCRIPTION

LibLO::blob


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
