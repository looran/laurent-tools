#!/bin/sh

if [ $# -lt 1 ]; then
    echo "Usage: $(basename $0) key_id"
    exit 1
fi

keyid=$1
dest="gpg_reorder_tmp"
now=$(date +%Y%m%d_%H%M)

echo "Key ID to put first in private keyring: $keyid"
echo "Going to"
echo "* cp -Rp $HOME/.gnupg/ $HOME/.gnupg.$now"
echo "* export gpg private keys"
echo "* rm -rf $HOME/.gnupg/secring.gpg"
echo "* reimport only gpg private key $keyid"
echo "* reimport other gpg private keys"
echo "OK for you ? (Enter or Ctrl-C)"
read a

set -x

cp -Rp $HOME/.gnupg/ $HOME/.gnupg.bak.$now ||exit 1
umask 0077
mkdir $dest ||exit 1

gpg -a --export-secret-keys $keyid > $dest/$keyid.secret
gpg -a --export-secret-keys > $dest/all.secret
rm -rf ~/.gnupg/secring.gpg ||exit 1

cat $dest/$keyid.secret |gpg --import -a
cat $dest/all.secret |gpg --import -a

echo "DONE"
#rm -rf $dest ||exit 1
