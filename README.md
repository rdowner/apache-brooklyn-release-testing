Apache Brooklyn Release Testing
===============================

A `Vagrantfile` and some scripts that I use for testing release candidates of
Apache Brooklyn.

Typical usage:

    vagrant up
    vagrant ssh
    /vagrant/install
    /vagrant/test-hashes
    /vagrant/test-source

Then unpack and start Brooklyn and perform some manual testing.
