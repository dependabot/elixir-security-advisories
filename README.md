# Elixir Advisory Database

The Elixir Advisory Database is a repository of security advisories filed
against Elixir packages published via https://hex.pm.

Advisory metadata is stored in [YAML] format for [Sobelow], [Dependabot] and
other automated tools to consume.

**NOTE: This database is currently in beta, and as such the format is subject
to change. If you have suggestions, please create an issue.**

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
    package: plug
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

## Contributing

Do you know about a vulnerability that isn't listed in this database? Open an
issue or submit a PR.

## License

All content in this repository is placed in the public domain.

[![Public Domain](http://i.creativecommons.org/p/zero/1.0/88x31.png)](https://github.com/RustSec/advisory-db/blob/master/LICENSE.txt)

[YAML]: http://yaml.org/
[Sobelow]: https://github.com/nccgroup/sobelow
[Dependabot]: https://dependabot.com
