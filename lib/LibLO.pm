package LibLO;

################
#
# liblo: perl bindings
#
# Copyright 2005 Nicholas J. Humfrey <njh@aelius.com>
#

use XSLoader;
use Carp;
use strict;

use vars qw/$VERSION/;

$VERSION="0.01";

XSLoader::load('LibLO', $VERSION);


1;

__END__

=pod

=head1 NAME

LibLO - Perl bindings for liblo library

=head1 DESCRIPTION

LibLO

=head1 TODO


=over

=item Add LibLO::Server class

=item Add LibLO::Blob class

=item Add LibLO::Bundle class

=item Add support for int64

=item Add support for midi

=item Add support for timetags

=back


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
