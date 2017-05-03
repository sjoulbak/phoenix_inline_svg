use Mix.Config

config :phoenix_inline_svg,
  dir: "test/fixtures",
  default_collection: "",
  not_found: "<svg viewbox='0 0 60 60'><text x='0' y='40' font-size='30' font-weight='bold' font-family='monospace'>Err</text></svg>"
