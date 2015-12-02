OiRA Statistical Reports
========================

This is a collection of `BIRT`_ reports showing statistical data for osha.oira.

.. _BIRT: http://www.eclipse.org/birt/

Setup
-----

Most of the setup is done by `oira.batou`_. However, the materialized view *statistics_sessions* must be created by hand:

  psql -U euphorie2 euphorie2 < statistics_sessions.sql

.. _oira.batou: https://bitbucket.org/oshahosting/oira.batou/
