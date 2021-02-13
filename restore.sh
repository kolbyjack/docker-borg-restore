#!/bin/bash

die() {
	echo FATAL: $* 1>&2
	exit 1
}

onexit() {
    if [[ $? -eq 0 ]]; then
        rm -f /tmp/restore_failed
    else
        touch /tmp/restore_failed
    fi
}

set -e
trap onexit EXIT

renice +19 -p $$

source /etc/backup.env

if [[ -f /run/secrets/borg_passphrase ]]; then
    export BORG_PASSPHRASE=$( cat /run/secrets/borg_passphrase | xargs echo -n )
fi

if [[ -f /etc/borg_ssh_key ]]; then
    export BORG_RSH="ssh -o StrictHostKeyChecking=accept-new -i ${BORG_KEY:-/etc/borg_ssh_key}"
fi

if [[ -z "$BORG_ARCHIVE_NAME" ]]; then
    BORG_ARCHIVE_NAME=$( borg list --format "{name}" --last 1 )
fi

[[ -n "$BORG_REPO" ]] || die "BORG_REPO is not set"
[[ -n "$BORG_ARCHIVE_NAME" ]] || die "BORG_ARCHIVE_NAME is not set"

cd /restore
borg extract --list --numeric-owner --strip-components "${BORG_STRIP_COMPONENTS:-1}" "::${BORG_ARCHIVE_NAME}"

