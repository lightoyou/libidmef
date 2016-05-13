# Author: Sebastien Tricaud <stricaud@inl.fr>
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

package GenerateIDMEFTreeWrapCxx;

use Generate;
@ISA = qw/Generate/;

use strict;
use IDMEFTree;

sub     header
{
    my  $self = shift;
    my  $file = $self->{file};

    $self->output("
/*****
*
* Based on GenerateIDMEFTreeWrapC.pm
* Author: Sebastien Tricaud <stricaud\@inl.fr>
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

/* Auto-generated by the GenerateIDMEFTreeWrapCppBindings package */

#include \"config.h\"

#include \"idmef-tree-wrap.hxx\"
#include \"common.h\"


static std::string *to_string(prelude_string_t *str)
\{
        return new std::string(prelude_string_get_string(str));
\}


static prelude_string_t *from_string(std::string *str)
\{
        int ret;
        prelude_string_t *pstr;

        ret = prelude_string_new_dup_fast(&pstr, str->c_str(), str->length());
        if ( ret < 0 )
                throw PreludeError(ret);

        return pstr;
\}

");
}

sub     struct_constructor
{
    my  $self = shift;
    my  $tree = shift;
    my  $struct = shift;

    $self->output("
/**
 * idmef_$struct->{short_typename}_new:
 * \@ret: Pointer where to store the created #$struct->{typename} object.
 *
 * Create a new #$struct->{typename} object.
 *
 * Returns: 0 on success, a negative value if an error occured.
 */
IDMEF$struct->{short_typename}::IDMEF$struct->{short_typename}()
\{
        idmef_$struct->{short_typename}_new(&_priv);
\}
");
}


sub     struct_copy
{
    my  $self = shift;
    my  $tree = shift;
    my  $struct = shift;

    $self->output("
/**
 * idmef_$struct->{short_typename}_copy:
 * \@src: Source of the copy.
 * \@dst: Where to copy the object.
 *
 * Copy a new #$struct->{typename} object from \@src to \@dst.
 *
 * Returns: 0 on success, a negative value if an error occured.
 */
int IDMEF$struct->{short_typename}::copy(IDMEF$struct->{short_typename} *dst)
\{
        return idmef_$struct->{short_typename}_copy(_priv, dst->_priv);
\}
");
}



sub     struct_clone
{
    my  $self = shift;
    my  $tree = shift;
    my  $struct = shift;

    $self->output("
/**
 * idmef_$struct->{short_typename}_clone:
 * \@src: Object to be cloned.
 * \@dst: Address where to store the pointer to the cloned object.
 *
 * Create a copy of \@src, and store it in \@dst.
 *
 * Returns: 0 on success, a negative value if an error occured.
 */
IDMEF$struct->{short_typename} *IDMEF$struct->{short_typename}::clone()
\{
        int ret;
        $struct->{typename} *dst;
        IDMEF$struct->{short_typename} *ptr;

        ret = idmef_$struct->{short_typename}_clone(_priv, &dst);
        if ( ret < 0 )
                throw PreludeError(ret);

        ptr = new IDMEF$struct->{short_typename}();
        idmef_$struct->{short_typename}_destroy(ptr->_priv);
        ptr->_priv = dst;

        return ptr;
\}
");
}


sub     struct_cmp
{
    my  $self = shift;
    my  $tree = shift;
    my  $struct = shift;

    $self->output("
/**
 * idmef_$struct->{short_typename}_compare:
 * \@obj1: Object to compare with \@obj2.
 * \@obj2: Object to compare with \@obj1.
 *
 * Compare \@obj1 with \@obj2.
 *
 * Returns: 0 on match, a negative value on comparison failure.
 */
int IDMEF$struct->{short_typename}::compare(IDMEF$struct->{short_typename} *obj)
\{
        return idmef_$struct->{short_typename}_compare(_priv, obj->_priv);
\}
");
}




sub     struct_destroy
{
    my  $self = shift;
    my  $tree = shift;
    my  $struct = shift;

    return if ( $struct->{toplevel} );

    $self->output("
/**
 * idmef_$struct->{short_typename}_destroy:
 * \@ptr: pointer to a #$struct->{typename} object.
 *
 * Destroy \@ptr and all of it's children.
 * The objects are only destroyed if their reference count reach zero.
 */
IDMEF$struct->{short_typename}::~IDMEF$struct->{short_typename}()
\{
        idmef_$struct->{short_typename}_destroy(_priv);
\}
");
}

sub     struct_ref
{
    my  $self = shift;
    my  $tree = shift;
    my  $struct = shift;

    $struct->{refcount} or return;

    #FIXME
}

sub     struct_field_normal
{
    my  $self = shift;
    my  $tree = shift;
    my  $struct = shift;
    my  $field = shift;
    my  $name = shift || $field->{name};
    my  $ptr = "";
    my  $refer = "";

    if ( $field->{ptr} ) {
        if ( $field->{metatype} & &METATYPE_STRUCT ) {
            $ptr = "*";

        } else {
            $refer = "*";
        }

    } else {
        if ( $field->{metatype} & (&METATYPE_STRUCT|&METATYPE_OPTIONAL_INT) ) {
            $ptr = "*";
            $refer = "&";
        }
    }

    my $type;
    my $fromcast;
    my $tocast;

    if ( $field->{typename} eq "prelude_string_t" ) {
        $type = "std::string";
        $fromcast = "from_string";
        $tocast = "to_string";
    } else {
        $type = $field->{typename};
        $fromcast = $tocast = "";
    }


    ##############################
    # Generate *_get_* functions #
    ##############################

    $self->output("
$type ${ptr} IDMEF$struct->{short_typename}::get_${name}()
\{
        return $tocast(idmef_$struct->{short_typename}_get_${name}(_priv));
\}
");


    ##############################
    # Generate *_set_* functions #
    ##############################

    my $field_name = ($field->{"name"} eq "class") ? "class_str" : $field->{name};

    if ( $field->{metatype} & &METATYPE_OPTIONAL_INT ) {
        $self->output("
void IDMEF$struct->{short_typename}::set_$field->{name}($field->{typename} $field_name)
\{
        prelude_return_if_fail(ptr);
        ptr->$field->{name} = $field_name;
        ptr->$field->{name}_is_set = 1;
\}


void IDMEF$struct->{short_typename}::unset_$field->{name}()
\{
        idmef_$struct->{short_typename}_unset_$field->{name}(_priv);
\}
");

    } elsif ( $field->{metatype} & &METATYPE_STRUCT ) {
        if ( $field->{ptr} ) {
            my $destroy_func = "$field->{short_typename}_destroy";
            $destroy_func = "idmef_${destroy_func}" if ( ! ($field->{metatype} & &METATYPE_PRIMITIVE) );

            $self->output("
void IDMEF$struct->{short_typename}::set_$field->{name}($field->{typename} *$field_name)
\{
        idmef_$struct->{short_typename}_set_$field->{name}(this, $field_name);
\}
");
        } else {
            my $destroy_internal_func = "$field->{short_typename}_destroy_internal";
            $destroy_internal_func = "idmef_${destroy_internal_func}" if ( ! ($field->{metatype} & &METATYPE_PRIMITIVE) );
            $self->output("

void IDMEF$struct->{short_typename}::set_$field->{name}($field->{typename} *$field_name)
\{
        idmef_$struct->{short_typename}_set_$field->{name}(this, $field_name);
\}
");
        }
    } else {
        if ( $field->{ptr} ) {
            $self->output("
void IDMEF$struct->{short_typename}::set_$field->{name}($field->{typename} *$field_name)
\{
        idmef_$struct->{short_typename}_set_$field->{name}(this, $field_name);
\}
");

        } else {
            $self->output("
            void IDMEF$struct->{short_typename}::set_$field->{name}($field->{typename} $field_name)
\{
        idmef_$struct->{short_typename}_set_$field->{name}(this, $field_name);
\}
");
        }
    }
}

sub     struct_field_union
{
    my  $self = shift;
    my  $tree = shift;
    my  $struct = shift;
    my  $field = shift;

    $self->output("
/**
 * idmef_$struct->{short_typename}_get_$field->{var}:
 * \@ptr: pointer to a #$struct->{typename} object.
 *
 * Access the $field->{var} children of \@ptr.
 *
 * Returns: a pointer to the #$field->{typename} children, or NULL if it is not set.
 */
$field->{typename} IDMEF$struct->{short_typename}::get_$field->{var}()
\{
        return idmef_$struct->{short_typename}_get_$field->{var}(_priv);
\}
");

    foreach my $member ( @{ $field->{member_list} } ) {
        $self->output("
/**
 * idmef_$struct->{short_typename}_get_$member->{name}:
 * \@ptr: pointer to a #$struct->{typename} object.
 *
 * Access the $member->{name} children of \@ptr.
 *
 * Returns: a pointer to the #$member->{typename} children, or NULL if it is not set.
 */
$member->{typename} *IDMEF$struct->{short_typename}::get_$member->{name}()
\{
        return idmef_$struct->{short_typename}_get_$member->{name}(_priv);
\}
"
);

        $self->output("
/**
 * idmef_$struct->{short_typename}_set_$member->{name}:
 * \@ptr: pointer to a #$struct->{typename} object.
 * \@$member->{name}: pointer to a #$member->{typename} object.
 *
 * Set \@$member->{name} object as a children of \@ptr.
 * if \@ptr already contain a \@$member->{name} object, then it is destroyed,
 * and updated to point to the provided \@$member->{name} object.
 */
void IDMEF$struct->{short_typename}::set_$member->{name}($member->{typename} *$member->{name})
\{
        idmef_$struct->{short_typename}_set_$member->{name}(_priv, $member->{name});
\}
");

        $self->output("
/**
 * idmef_$struct->{short_typename}_new_$member->{name}:
 * \@ptr: pointer to a #$struct->{typename} object.
 * \@ret: pointer where to store the created #$member->{typename} object.
 *
 * Create a new $member->{typename} object, children of #$struct->{typename}.
 * If \@ptr already contain a #$member->{typename} object, then it is destroyed.
 *
 * Returns: 0 on success, or a negative value if an error occured.
 */
IDMEF$member->{short_typename} *IDMEF$struct->{short_typename}::new_$member->{name}()
\{
        int ret;
        $member->{typename} *ptr;
        IDMEF$member->{short_typename} *obj;

        ret = idmef_$struct->{short_typename}_new_$member->{name}(_priv, &ptr);
        if ( ret < 0 )
                throw PreludeError(ret);

        obj = new IDMEF$member->{short_typename};
        idmef_$member->{short_typename}_destroy(obj->_priv);
        obj->_priv = ptr;
\}
");
    }
}

sub     struct_field_list
{
    my  $self = shift;
    my  $tree = shift;
    my  $struct = shift;
    my  $field = shift;
    my  $new_field_function = "$field->{short_typename}_new(ret)";

    $new_field_function = "idmef_${new_field_function}" if ( ! ($field->{metatype} & &METATYPE_PRIMITIVE) );

        return;

    $self->output("
/**
 * idmef_$struct->{short_typename}_get_next_$field->{short_name}:
 * \@$struct->{short_typename}: pointer to a #$struct->{typename} object.
 * \@$field->{short_typename}_cur: pointer to a #$field->{typename} object.
 *
 * Get the next #$field->{typename} object listed in \@ptr.
 * When iterating over the $field->{typename} object listed in \@ptr,
 * \@object should be set to the latest returned #$field->{typename} object.
 *
 * Returns: the next #$field->{typename} in the list.
 */
$field->{typename} *IDMEF$struct->{short_typename}::get_next_$field->{short_name}($field->{typename} *$field->{short_typename}_cur)
\{
        return idmef_$struct->{short_typename}_get_next_$field->{short_name}(_priv, $field->{short_typename}_cur);
\}


/**
 * idmef_$struct->{short_typename}_set_$field->{short_name}:
 * \@ptr: pointer to a #$struct->{typename} object.
 * \@object: pointer to a #$field->{typename} object.
 * \@pos: Position in the list.
 *
 * Add \@object to position \@pos of \@ptr list of #$field->{typename} object.
 *
 * If \@pos is #IDMEF_LIST_APPEND, \@object will be inserted at the tail of the list.
 * If \@pos is #IDMEF_LIST_PREPEND, \@object will be inserted at the head of the list.
 */
void IDMEF$struct->{short_typename}::set_$field->{short_name}($field->{typename} *object, int pos)
\{
        idmef_$struct->{short_typename}_set_$field->{short_name}(_priv, object, pos);
\}


/**
 * idmef_$struct->{short_typename}_new_$field->{short_name}:
 * \@ptr: pointer to a #$struct->{typename} object.
 * \@ret: pointer to an address where to store the created #$field->{typename} object.
 * \@pos: position in the list.
 *
 * Create a new #$field->{typename} children of \@ptr, and add it to position \@pos of
 * \@ptr list of #$field->{typename} object. The created #$field->{typename} object is
 * stored in \@ret.
 *
 * If \@pos is #IDMEF_LIST_APPEND, \@object will be inserted at the tail of the list.
 * If \@pos is #IDMEF_LIST_PREPEND, \@object will be inserted at the head of the list.
 *
 * Returns: 0 on success, or a negative value if an error occured.
 */
int IDMEF$struct->{short_typename}::new_$field->{short_name}($field->{typename} **ret, int pos)
\{
        return idmef_$struct->{short_typename}_new_$field->{short_name}(_priv, ret, pos);
\}

");
}

sub        struct_fields
{
    my        $self = shift;
    my        $tree = shift;
    my        $struct = shift;

    foreach my $field ( @{ $struct->{field_list} } ) {
        $self->struct_field_normal($tree, $struct, $field) if ( $field->{metatype} & &METATYPE_NORMAL );
         $self->struct_field_list($tree, $struct, $field) if ( $field->{metatype} & &METATYPE_LIST );
         $self->struct_field_union($tree, $struct, $field) if ( $field->{metatype} & &METATYPE_UNION );
    }
}

sub        struct_func
{
    my        $self = shift;
    my        $tree = shift;
    my        $struct = shift;

    $self->struct_constructor($tree, $struct);
    $self->struct_ref($tree, $struct);
    $self->struct_destroy($tree, $struct);
    $self->struct_fields($tree, $struct);
    $self->struct_copy($tree, $struct);
    $self->struct_clone($tree, $struct);
    $self->struct_cmp($tree, $struct);
}

sub        enum
{
    my        $self = shift;
    my        $tree = shift;
    my        $enum = shift;

    ## FIXME
    return;

    $self->output("
/**
 * idmef_$enum->{short_typename}_to_numeric:
 * \@name: pointer to an IDMEF string representation of a #$enum->{typename} value.
 *
 * Returns: the numeric equivalent of \@name, or -1 if \@name is not valid.
 */
$enum->{typename} IDMEF$enum->{short_typename}::$enum->{short_typename}_to_numeric(const char *name)
\{
        return idmef_$enum->{short_typename}_to_numeric(name);
\}
");

        $self->output("
/**
 * idmef_$enum->{short_typename}_to_string:
 * \@val: an enumeration value for #$enum->{typename}.
 *
 * Return the IDMEF string equivalent of \@val provided #$enum->{typename} value.
 *
 * Returns: a pointer to the string describing \@val, or NULL if \@val is invalid.
 */
const char *IDMEF$enum->{short_typename}::to_string($enum->{typename} val)
\{
        return idmef_$enum->{short_typename}_to_string(val);
\}
");
}


sub footer
{
    my $self = shift;

    $self->output("
void IDMEFMessage::set_pmsg(prelude_msg_t *msg)
\{
        idmef_message_set_pmsg(_priv, msg);
\}


prelude_msg_t *IDMEFMessage::get_pmsg()
\{
        return idmef_message_get_pmsg(_priv);
\}


/**
 * idmef_message_destroy:
 * \@ptr: pointer to a #idmef_message_t object.
 *
 * Destroy \@ptr and all of it's children.
 * The objects are only destroyed if their reference count reach zero.
 */
void IDMEFMessage::~IDMEFMessage()
\{
        idmef_message_destroy(_priv);
\}
");

}
1;