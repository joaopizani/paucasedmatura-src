#!/usr/bin/env bash

DATAROOT_DEFAULT="/data/data"
DATAROOT="$(readlink -m "${1:-"${DATAROOT_DEFAULT}"}")"

ARCHIVEHOST_DEFAULT="hostarchive"
ARCHIVEHOST="${2:-"${ARCHIVEHOST_DEFAULT}"}"

HTDOCS_DEFAULT="/var/www/archive.alvb.in/html"
HTDOCS="${3:-"${HTDOCS_DEFAULT}"}"

REMOTEROOT="${ARCHIVEHOST}:${HTDOCS}"

PRIVNAME_DEFAULT="priv"
PRIVNAME="${4:-"${PRIVNAME_DEFAULT}"}"

PRIVROOT="$(readlink -m "${DATAROOT}/${PRIVNAME}")"


rsync -av "${PRIVROOT}/bsc/disciplinas"  "${REMOTEROOT}/bsc/"
rsync -av "${PRIVROOT}/bsc/labmicro"     "${REMOTEROOT}/bsc/"
rsync -av "${PRIVROOT}/bsc/TCC"          "${REMOTEROOT}/bsc/"

rsync -av "${PRIVROOT}/svn/FromBScToMSc/"  "${REMOTEROOT}/bsc2msc/"
rsync -av "${PRIVROOT}/msc"                "${REMOTEROOT}/"

