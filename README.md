# Port for vpndd

This is the BSD Ports system configuration project for vpnd.

## Procedure

1. Make sure that the ports system is setup. On FreeBSD, this is done with

    sudo portsnap fetch extract

1. Create the distinfo file, which has a checksum of the tarball containing the source.

    sudo make makesum

   This file is currently in the repository and will need to be updated if the code
   changes. If the release has changed, update the Makefile before running this command.
   If the tarball is different but the release hasn't changed, you'll need to remove
   the distfile tarball from `/usr/ports/distfiles` before running this command.

2. Go through package building steps (these are taken from the FreeBSD Porters Handbook):

   ```
   make stage
   make check-orphans
   make package
   make install
   make deinstall
   pkg add radnsd

   make package (as user)
   ```
