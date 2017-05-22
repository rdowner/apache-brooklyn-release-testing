#!/usr/bin/env bash

function fblack() { tput setaf 0; }
function fred() { tput setaf 1; }
function fgreen() { tput setaf 2; }
function fyellow() { tput setaf 3; }
function fblue() { tput setaf 4; }
function fmagenta() { tput setaf 5; }
function fcyan() { tput setaf 6; }
function fwhite() { tput setaf 7; }

function bblack() { tput setab 0; }
function bred() { tput setab 1; }
function bgreen() { tput setab 2; }
function byellow() { tput setab 3; }
function bblue() { tput setab 4; }
function bmagenta() { tput setab 5; }
function bcyan() { tput setab 6; }
function bwhite() { tput setab 7; }

function boldon() { tput bold; }
function boldoff() { tput dim; }
function ulon() { tput smul; }
function uloff() { tput rmul; }

function rst() { fwhite; bblack; boldoff; uloff; }

[ \!  -z "$1" ] && VERSION=$1
[ -z "$VERSION" ] && { echo >&2 "Pass version number to test on the command line or in VERSION environment variable."; exit 1; }

LOC="${HOME}/dist.apache.org/repos/dist/dev/brooklyn/apache-brooklyn-${VERSION}"

