#!/bin/sh

curl -L https://archive.raspberrypi.org/debian/raspberrypi.gpg.key > /etc/apt/trusted.gpg.d/raspberrypi.asc
curl -L https://archive.raspbian.org/raspbian.public.key > /etc/apt/trusted.gpg.d/raspbian.asc

