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

package GenerateIDMEFMessagePrintH;

use Generate;
@ISA = qw/Generate/;

use strict;
use IDMEFTree; 

sub	header
{
    my	$self = shift;

    $self->output("
/*****
*
* Copyright (C) 2003-2016 CS-SI. All Rights Reserved.
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

/* Auto-generated by the GenerateIDMEFTreePrintH package */

#ifndef _LIBPRELUDE_IDMEF_MESSAGE_PRINT_H
#define _LIBPRELUDE_IDMEF_MESSAGE_PRINT_H

#ifdef __cplusplus
 extern \"C\" \{
#endif

");
}

sub	struct
{
    my	$self = shift;
    my	$tree = shift;
    my	$struct = shift;

    $self->output("
void idmef_$struct->{short_typename}_print($struct->{typename} *ptr, prelude_io_t *fd);");
}

sub	footer
{
    my	$self = shift;
    my	$tree = shift;

    $self->output("

#ifdef __cplusplus
 }
#endif

#endif /* _LIBPRELUDE_IDMEF_MESSAGE_PRINT_H */
"
);
}

1;
