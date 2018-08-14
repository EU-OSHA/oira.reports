#!/usr/bin/env python
# coding=utf-8

import base64
import os

# Adjust as needed
database_url = "postgresql://oira-staging01.mainstrat.com:5432/euphorie2"
database_user = "euphorie2"
database_password = "secret"


def run():
    for fname in os.listdir("."):
        if not fname.endswith(".rptdesign"):
            continue
        with open(fname, 'r') as fh:
            txt = fh.read()
            txt = txt.replace("{{component.database_url}}", database_url)
            txt = txt.replace("{{component.database_user}}", database_user)
            txt = txt.replace(
                "{{component.database_password}}",
                base64.b64encode(database_user))
        with open(fname, 'w') as fh:
            fh.write(txt)
        print "Written: {}".format(fname)


if __name__ == '__main__':
    run()
