# ADJOIN role
This role will join a Debian or RedHat machine to (up to two) an Active
Directory domain(s). In order to use this role, you need the following:

Windows side:
* AD domain set up and ready to use
* Make sure DNS records for the domain are correctly setup
* A useraccount with enough privileges to create Computer Objects

Linux side:
* Administrative access to your client system
* Synchronized clocks with the AD domain controller on the client

## Configuration steps
This role will configure the following programs to prepare your system for AD
authentication:

* Kerberos
* Oddjob (only for RHEL)
* OpenLDAP
* PAM
* Samba
* SSSD

Each time this role is run, it will check the validity of the join with the AD
domain.  When this check fails, it will automatically try to (re)join the domain
with the configured credentials.

It will also configure sudo permissions for a user-specified AD group. The
default permissions given to this group is:

```
ALL=(ALL) ALL:NOPASSWD
```

There are 2 reasons for that:

* Combined with strong authentication via Kerberos the added value of a password
  is negligable.
* This allows for the same SSO experience when using SSH keys directly into the root user

## Usage
After fulfilling the requirements above this role can be used as follows:

* Install the role (either from Galaxy or directly from GitHub)
* Copy the defaults file to your inventory (or wherever you store them) and
  fill in the blanks
* Add the role to your master playbook
* Run Ansible
* ???
* Profit!
