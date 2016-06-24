# AWS Global Plan

This terraform plan sets up a number of global AWS systems for Automato.

## Notes

These notes are for the execution and modification of this plan.

### External Process

* This plan sets up a Route53 hosted zone for a number of domain names and assigns DNS servers.
  The DNS servers generated for a root hosted zone must be entered with the current domain registrar.
  For Namecheap, this requires entering the DNS servers as "custom DNS" for domain management.
