# Copyright (C) 2003-2016 CS-SI. All Rights Reserved.
# Author: Nicolas Delon <nicolas.delon@prelude-ids.com>
#
# This file is part of the Prelude library.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

package GenerateIDMEFMessageWriteH;

use Generate;
@ISA = qw/Generate/;

use strict;
use IDMEFTree;

sub     header
{
     my $self = shift;

     $self->output("
/*****
*
* Copyright (C) 2001-2016 CS-SI. All Rights Reserved.
* Author: Yoann Vandoorselaere <yoann.v\@prelude-ids.com>
*
* This file is part of the Prelude library.
*
* This program is free software; you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation; either version 2, or (at your option)
* any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License along
* with this program; if not, write to the Free Software Foundation, Inc.,
* 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
*
*****/

/* Auto-generated by the GenerateIDMEFMessageWriteH package */

#ifndef _LIBPRELUDE_IDMEF_MESSAGE_WRITE_H
#define _LIBPRELUDE_IDMEF_MESSAGE_WRITE_H

#include \"prelude-inttypes.h\"
#include \"idmef-time.h\"
#include \"prelude-string.h\"
#include \"prelude-io.h\"

#ifdef __cplusplus
 extern \"C\" {
#endif

");
}

sub     footer
{
    my  $self = shift;

    $self->output("

#ifdef __cplusplus
 }
#endif

#endif /* _LIBPRELUDE_IDMEF_MESSAGE_WRITE_H */
");
}

sub     struct
{
    my  $self = shift;
    my  $tree = shift;
    my  $struct = shift;

    $self->output("int idmef_$struct->{short_typename}_write($struct->{typename} *$struct->{short_typename}, prelude_io_t *fd);\n");
}

1;