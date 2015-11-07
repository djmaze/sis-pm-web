# SiS-PM Web

This is a web frontend for the `sispmctl` commandline executable. It allows seeing the socket status and switching sockets on supported SiS-PM devices. See the [original homepage](http://sispmctl.sourceforge.net/) for details.

## Prerequites

(This works on Linux only.)

You need to have Docker, Docker Compose (>= 1.5.0) and `lsusb` installed.

## Running

This project has been built to be run via Docker and Docker Compose. Because we need to have access to the right USB device, Compose has been wrapped in the `dc` script.

Start it like this (from inside the project folder):

    ./dc up -d

That's it. The container will be built and the app will be started. It should be available at [http://localhost:2638](http://localhost:2638) afterwards.

You can use all Docker Compose commands with the wrapper. Examples:

    ./dc ps
    ./dc stop

## Compatibility

The API has been built to be compatible with the legacy interface offered by `sispmctl -l`.

## Motivation

The web interface offered by `sispmctl` was running very unstable for me. Also, it does not have a developer-friendly (ie. JSON-based) API.
