# README

Installation for windows:
https://gorails.com/setup/windows/10
using ruby 2.5.1 and rails 5.2.1 Follow RVM and install mysql


USING bash.exe

Run in two terminal:
One:
./bin/webpack-dev-server

Two:
rails s

If There is already a server running remove it:
rm /mnt/e/Programming/repos/salvo_site/miracles/tmp/pids/server.pid

If Cannot connect to DB:
sudo /etc/init.d/mysql start

Create Models:
e.g. A model for Users
rails generate model User