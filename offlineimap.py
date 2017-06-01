#!/usr/bin/env python

from getpass import getpass


def vsoul_arr_get_pass():
    user = "vsoul"
    domain = "arrikto.com"
    msg = "Password for %s@%s: " % (user, domain)
    return getpass(msg)
