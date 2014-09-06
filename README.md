Bloinck
=======


Block  Incremental
Blo Incremental ck
bloinck

Slices up a file into chuncks of {size}MB.
Does a checksum for each.

If checksum is different than previous one,
it will remotely compress the chunk and transfer the compressed version


Backup Usage
------------

* backup all the storage associated with a KVM host's virtual machines:

	./bloinck sshable.machine.world:kvm

* backup only a specific file/block device

	./bloinck sshable.machine.world:/path/to/file


Note: It will try to do an LVM snapshot before performing the backup. If the file is not an LVM volume, it will just do a backup.



De-Backup Usage
---------------

* to decompressed version of the snapshot to the standard output

	./de-bloinck sshable.machine.world/block_dev/date_of_backup



Check Usage
-----------

* to check that the backups are consistent with the checksums

	./check sshable.machine.world/block_dev/date_of_backup


