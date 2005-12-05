/*

	liblo perl bindings

	Copyright 2005 Nicholas J. Humfrey <njh@aelius.com>

*/

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include <lo/lo.h>



MODULE = LibLO	PACKAGE = LibLO

##
## Return the error code for the last error
## associated with an address
##
int
lo_address_errno( address )
	lo_address	address
  CODE:
	RETVAL = lo_address_errno( address );
  OUTPUT:
	RETVAL


##
## Return the error string from the last error
## associated with an address
##
const char*
lo_address_errstr( address )
	lo_address address
  CODE:
	RETVAL = lo_address_errstr( address );
  OUTPUT:
	RETVAL


##
## New address from host and port
##
lo_address
lo_address_new( host, port )
	const char *host
	const char *port
  CODE:
	RETVAL = lo_address_new( host, port );
  OUTPUT:
	RETVAL


##
## New address from URL
##
lo_address
lo_address_new_from_url ( url )
	const char *url
  CODE:
	RETVAL = lo_address_new_from_url( url );
  OUTPUT:
	RETVAL


##
## Free up memory used by an address
##
void
lo_address_free ( address )
	lo_address	address
  CODE:
	lo_address_free( address );


##
## New blob from Perl Scalar
##
lo_blob
lo_blob_new( sv )
	SV* sv
  PREINIT:
	STRLEN  size = 0;
	char *  data = NULL;
  CODE:
  	data = SvPV( sv, size );
	RETVAL = lo_blob_new( size, data );
  OUTPUT:
	RETVAL


##
## Return the size of a blob
##
int
lo_blob_datasize ( blob )
	lo_blob	blob
  CODE:
	RETVAL = lo_blob_datasize( blob );
  OUTPUT:
	RETVAL


##
## Free up memory used by a blob
##
void
lo_blob_free ( blob )
	lo_blob	blob
  CODE:
	lo_blob_free( blob );


##
## Send an OSC message (now)
##
int
lo_send_message( address, path, message )
	lo_address	 address
	const char*  path
	lo_message   message
  CODE:
	RETVAL = lo_send_message( address, path, message );
  OUTPUT:
	RETVAL


##
## Message related XSUBs
##
lo_message
lo_message_new()
  CODE:
	RETVAL = lo_message_new();
  OUTPUT:
	RETVAL

void
lo_message_free( msg )
	lo_message msg
  CODE:
	lo_message_free(msg);

void
lo_message_pp(msg)
	lo_message   msg
  CODE:
	lo_message_pp( msg );
	
size_t
lo_message_length(msg,path)
	lo_message msg
	const char *path
  CODE:
	RETVAL = lo_message_length(msg,path);
	
  OUTPUT:
	RETVAL

void
lo_message_add_char(msg, ch)
	lo_message   msg
	char		 ch
  CODE:
  	lo_message_add_char( msg, ch );
  	
void
lo_message_add_double(msg, d)
	lo_message   msg
	double		 d
  CODE:
  	lo_message_add_double( msg, d );
  	
void
lo_message_add_false(msg)
	lo_message   msg
  CODE:
  	lo_message_add_false( msg );

void
lo_message_add_float(msg, f)
	lo_message   msg
	float		 f
  CODE:
  	lo_message_add_float( msg, f );

void
lo_message_add_infinitum(msg)
	lo_message   msg
  CODE:
  	lo_message_add_infinitum( msg );

void
lo_message_add_int32(msg, i)
	lo_message   msg
	I32			 i
  CODE:
  	lo_message_add_int32( msg, i );

void
lo_message_add_nil(msg)
	lo_message   msg
  CODE:
  	lo_message_add_nil( msg );

void
lo_message_add_string(msg, str)
	lo_message   msg
	const char*  str
  CODE:
  	lo_message_add_string( msg, str );

void
lo_message_add_symbol(msg, sym)
	lo_message   msg
	const char*  sym
  CODE:
  	lo_message_add_symbol( msg, sym );

void
lo_message_add_true(msg)
	lo_message   msg
  CODE:
  	lo_message_add_true( msg );

