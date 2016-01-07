# RevisionPlateEx

Plug application and middleware that serves endpoint returns application's REVISION.

See also [revision_plate](https://github.com/sorah/revision_plate) which is implemented with Ruby.

## Quick use as standalone

  1. Add revision_plate_ex to your list of dependencies in `mix.exs`:

        def deps do
          [{:revision_plate_ex, "~> 0.1.0"}]
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
