# Copyright (C) 2003-2012 CS-SI. All Rights Reserved.
# Author: Nicolas Delon <nicolas.delon@libidmef-ids.com>
#
# This file is part of the LibIdmef library.
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

package GenerateIDMEFMessageJSONH;

use Generate;
@ISA = qw/Generate/;

use strict;
use IDMEFTree;

sub header
{
    my  $self = shift;

    $self->output("
/*****
*
* Copyright (C) 2003-2016 CS-SI. All Rights Reserved.
* Author: Yoann Vandoorselaere <yoann.v\@libidmef-ids.com>
*
* This file is part of the LibIdmef library.
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

/* Auto-generated by the GenerateIDMEFTreeJSONH package */

#ifndef _LIBIDMEF_IDMEF_MESSAGE_PRINT_JSON_H
#define _LIBIDMEF_IDMEF_MESSAGE_PRINT_JSON_H

#ifdef __cplusplus
 extern \"C\" \{
#endif

");
}

sub struct
{
    my  $self = shift;
    my  $tree = shift;
    my  $struct = shift;

    $self->output("
int idmef_$struct->{short_typename}_print_json($struct->{typename} *ptr, libidmef_io_t *fd);");
}

sub footer
{
    my  $self = shift;
    my  $tree = shift;

    $self->output("

int idmef_message_print_json(idmef_message_t *ptr, libidmef_io_t *fd);

#ifdef __cplusplus
 }
#endif

#endif /* _LIBIDMEF_IDMEF_MESSAGE_JSON_H */
"
);
}

1;
