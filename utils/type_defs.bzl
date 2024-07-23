# Copyright (c) Meta Platforms, Inc. and affiliates.
#
# This source code is licensed under both the MIT license found in the
# LICENSE-MIT file in the root directory of this source tree and the Apache
# License, Version 2.0 found in the LICENSE-APACHE file in the root directory
# of this source tree.

"""Provides macros for queries type information."""

_SELECT_TYPE = type(select({"DEFAULT": []}))

def is_select(thing):
    return type(thing) == _SELECT_TYPE

def is_unicode(arg):
    """Checks if provided instance has a unicode type.

    Args:
      arg: An instance to check. type: Any

    Returns:
      True for unicode instances, False otherwise. rtype: bool
    """
    return hasattr(arg, "encode")

def is_string(arg):
    """Checks if provided instance has a string type.

    Args:
      arg: An instance to check. type: Any

    Returns:
      True for string instances, False otherwise. rtype: bool
    """
    return isinstance(arg, str)

def is_list(arg):
    """Checks if provided instance has a list type.

    Args:
      arg: An instance to check. type: Any

    Returns:
      True for list instances, False otherwise. rtype: bool
    """
    return isinstance(arg, list)

def is_dict(arg):
    """Checks if provided instance has a dict type.

    Args:
      arg: An instance to check. type: Any

    Returns:
      True for dict instances, False otherwise. rtype: bool
    """
    return isinstance(arg, dict)

def is_tuple(arg):
    """Checks if provided instance has a tuple type.

    Args:
      arg: An instance to check. type: Any

    Returns:
      True for tuple instances, False otherwise. rtype: bool
    """
    return isinstance(arg, tuple)

def is_collection(arg):
    """Checks if provided instance is a collection subtype.

    This will either be a dict, list, or tuple.
    """
    return is_dict(arg) or is_list(arg) or is_tuple(arg)

def is_bool(arg):
    """Checks if provided instance is a boolean value.

    Args:
      arg: An instance of check. type: Any

    Returns:
      True for boolean values, False otherwise. rtype: bool
    """
    return isinstance(arg, bool)

def is_number(arg):
    """Checks if provided instance is a number value.

    Args:
      arg: An instance of check. type: Any

    Returns:
      True for number values, False otherwise. rtype: bool
    """
    return isinstance(arg, int)

def is_struct(arg):
    """Checks if provided instance is a struct value.

    Args:
      arg: An instance to check. type: Any

    Returns:
      True for struct values, False otherwise. rtype: bool
    """
    return isinstance(arg, struct)

def is_function(args):
    """Checks if provided instance is a function value.

    Args:
      arg: An instance to check. type: Any

    Returns:
      True for function values, False otherwise. rtype: function
    """
    return isinstance(args, typing.Callable)

type_utils = struct(
    is_bool = is_bool,
    is_number = is_number,
    is_string = is_string,
    is_unicode = is_unicode,
    is_list = is_list,
    is_dict = is_dict,
    is_tuple = is_tuple,
    is_collection = is_collection,
    is_select = is_select,
    is_struct = is_struct,
    is_function = is_function,
)
