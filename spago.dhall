{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "Slow Network Detector"
, dependencies =
  [ "console"
  , "effect"
  , "either"
  , "foldable-traversable"
  , "nullable"
  , "psci-support"
  , "strings"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
