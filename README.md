[![](https://img.shields.io/hexpm/v/revision_plate_ex.svg?style=flat)](https://hex.pm/packages/revision_plate_ex)
[![Build Status](https://travis-ci.org/KazuCocoa/revision_plate_ex.svg?branch=support_over_elixir_13)](https://travis-ci.org/KazuCocoa/revision_plate_ex)

# RevisionPlateEx

Plug application and middleware that serves endpoint returns application's REVISION.

See also [revision_plate](https://github.com/sorah/revision_plate) which is implemented with Ruby.

Document is [here](http://hexdocs.pm/revision_plate_ex/api-reference.html).

## Requirement

Elixir ~> 1.3

## Quick use as standalone server

  1. Add revision_plate_ex to your list of dependencies in `mix.exs`:

        def deps do
          [{:revision_plate_ex, "~> 0.2.0"}]
        end

  2. Ensure revision_plate_ex is started before your application:

        def application do
          [applications: [:revision_plate_ex]]
        end

  3. Create `REVISION` file in root path.
  4. Start application
  5. Access to `http://localhost:4000/hello/revision` via browser, then the server return binary written in `REVISION`

## Use with Phoenix

Read document associated with `RevisionPlateEx.Hello.revision/1`

## Configurations

Can use two configurations.

```elixir
use Mix.Config

config :revision_plate_ex,
  http_port: 8000,         # Used only standalone mode. Default is `4000`.
  file_path: "REVISION"    # Used anyone would like to customize path to revision file. Default is "REVISION".
```

# LICENSE
MIT. Read LICENSE file.
