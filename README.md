# Port for `vpnd`

This is the BSD Ports system configuration project for vpnd.

## Project Makefile requirements

The Makefile for the software being built needs an install target in which
the commands that specify installation paths are aware of a special variable
called DESTDIR. DESTDIR comes into play during staging and package creation.
The ports system builds the code and installs it into a blank directory
structure before packaging it up. Without it, the ports system will try to
install into the wrong place: `/usr/obj/dports` on DragonFlyBSD, or directly
into the real installation directory (`/usr/local`) on FreeBSD.

Install target commands should look like:

`cp my-binary ${DESTDIR}/${PREFIX}/sbin/`

## Procedure

1. Make sure that the ports system is setup. On FreeBSD, this is done with

    `sudo portsnap fetch extract`

   On DragonFly the procedure is:

   ```
   cd /usr
   sudo make dports-create-shallow
   ```

2. Create the distinfo file, which has a checksum of the tarball containing the source.

    `sudo make makesum`

   This file is currently in the repository and will need to be updated if the code
   changes. If the release has changed, update the Makefile before running this command.
   If the tarball is different but the release hasn't changed, you'll need to remove
   the distfile tarball before running this command. On FreeBSD, it's in `/usr/ports/distfiles`.
   On DragonFlyBSD, it's in `/usr/distfiles`.

   Note that the work directory on FreeBSD is `work` in the current directory, but on
   DragonFly, the base is /usr/obj/dports. So, the commands below need to be run via
   `sudo(8)`. Alternatively, I think that the WORKDIR environment variable can be set
   to a different location that's writable by a normal user.

3. Go through package building steps (these are taken from the FreeBSD Porters Handbook):

   ```
   make stage
   make check-orphans
   make package
   make install
   make deinstall
   pkg add ./vpnd.txz

   make package (as user)
   ```
