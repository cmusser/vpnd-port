# Port for `vpnd`

This is the BSD Ports system configuration project for vpnd.

## Procedure

1. Make sure that the ports system is setup. On FreeBSD, this is done with

    `sudo portsnap fetch extract`

   On DragonFly the procedure is:

   ```
   cd /usr
   sudo make dports-create-shallow
   ```

2. Bump the PORTVERSION in the Makefile to match the Git tag of the new version.

3. Run the following:

    `sudo make makesum`

   This writes the distinfo file, which is in version control. Make sure you commit this
   when done.

   In the uncommon case where you're rebuilding a release, but reusing the same version
   number, remove the distfile tarball before running this command. On FreeBSD, it's in
   `/usr/ports/distfiles`. On DragonFlyBSD, it's in `/usr/distfiles`.

   On DragonFly, the base is `/usr/obj/dports`, so, the commands below need to be run via
   `sudo(8)`. Alternatively, I think that the WORKDIR environment variable can be set
   to a different location that's writable by a normal user. On FreeBSD, it's done in `work`
   in the current directory, so `sudo(8)` isn't needed. 

4. Go through package building steps (these are taken from the FreeBSD Porters Handbook):

   ```
   sudo make clean
   sudo make stage
   sudo make check-orphans
   sudo make package
   sudo make install
   sudo make deinstall
   ```
5. Install the built package:
   ```
   sudo pkg install /usr/obj/dports/src/vpnd-port/pkg/vpnd-1.1.2.txz
   ```

## General Notes on Makefile Requirements for Software Packaged With Ports

**This is about the Makefile for the software being ported, not the Makefile
in a port (such as the one in this respository**

The Makefile for the software being built needs an install target in which
the commands that specify installation paths are aware of a special variable
called DESTDIR. DESTDIR comes into play during staging and package creation.
The ports system builds the code and installs it into a blank directory
structure before packaging it up. Without it, the ports system will try to
install into the wrong place: `/usr/obj/dports` on DragonFlyBSD, or directly
into the real installation directory (`/usr/local`) on FreeBSD.

Install target commands should look like:

`cp my-binary ${DESTDIR}/${PREFIX}/sbin/`

