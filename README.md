# Deprecation Notice

This repo was created before the GitHub Security Advisory DB supported Hex / Elixir. Now that [support has been added](https://github.blog/2022-06-27-github-advisory-database-now-supports-erlang-and-elixir-packages/), we've deprecated / archived this repo. The Security Advisory DB is a much more flexible solution that includes an actual API, GraphQL support, auto-ingesting from various data sources, professional curation, etc.

<p align="center"><img src="logo/horizontalversion.png" alt="elixir-security-advisories" height="200px"></p>

# Elixir Advisory Database

The Elixir Advisory Database is a repository of security advisories filed
against published Elixir packages.

Advisory metadata is stored in [YAML] format for [Sobelow], [Dependabot],
[MixAudit] and other automated tools to consume.

This is also an [experimental web API] for the database.

[![Build Status](https://travis-ci.org/dependabot/elixir-security-advisories.svg?branch=master)](https://travis-ci.org/dependabot/elixir-security-advisories)

## Directory Structure

The database is a list of directories that match the names of Elixir libraries
on [hex.pm]. Within each directory are one or more advisory files for the Elixir
library.

    packages/:
      plug/:
        2017-02-28.yml
        2017-02-28_2.yml

## Format

Each advisory file contains the advisory information in [YAML] format:

    ---
    id: 8268e120-60b4-4efb-b9ca-4e3faca0cca6
    package: plug
    disclosure_date: 2017-02-28
    cve: 2017-1000052
    link: https://elixirforum.com/t/static-and-session-security-fixes-for-plug/3913
    title: |
      Null Byte Injection in Plug.Static

    description: |
      Plug.Static is used for serving static assets, and is vulnerable to null
      byte injection. If file upload functionality is provided, this can allow
      users to bypass filetype restrictions.

      We recommend all applications that provide file upload functionality and
      serve those uploaded files locally with Plug.Static to upgrade immediately
      or include the fix below. If uploaded files are rather stored and served
      from S3 or any other cloud storage, you are not affected.

    patched_versions:
      - ~> 1.3.2
      - ~> 1.2.3
      - ~> 1.1.7
      - ~> 1.0.4

    unaffected_versions:
      - "< 1.0.0"

## Schema

There is linting in place to enforce the following schema for each advisory:

| Attribute             | Type        | Description                                                            |
|-----------------------|-------------|------------------------------------------------------------------------|
| `id`                  | String      | A version 4 UUID (use https://www.uuidgenerator.net/version4).         |
| `package`             | String      | Name of the affected package.                                          |
| `disclosure_date`     | Date        | Date the vulnerability was publicly disclosed (here or elsewhere).     |
| `cve`                 | String/Null | (Optional) CVE assigned to the vulnerability.                          |
| `link`                | String      | Link to the original disclosure / more details.                        |
| `title`               | String      | Title of the vulnerability. This should be a (very) short description. |
| `description`         | String      | Description of the vulnerability.                                      |
| `patched_versions`    | Array       | Array of Elixir requirement strings specifying patched versions.       |
| `unaffected_versions` | Array       | Array of Elixir requirement strings specifying unaffected versions.    |

## Contributing

Do you know about a vulnerability that isn't listed in this database? Open an
issue or submit a PR.

## License

All content in this repository is placed in the public domain.

[![Public Domain](http://i.creativecommons.org/p/zero/1.0/88x31.png)](https://github.com/dependabot/elixir-security-advisories/blob/master/LICENSE.txt)

[YAML]: http://yaml.org/
[Sobelow]: https://github.com/nccgroup/sobelow
[Dependabot]: https://dependabot.com
[MixAudit]: https://github.com/mirego/mix_audit
[experimental web API]: https://github.com/ex-security-advisory/api
