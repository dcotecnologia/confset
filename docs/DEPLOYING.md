# Deploying

Deploying it to the Rubygems server:

```sh
rake release
```

Depploying it to the Github packages:

```sh
gem build confset.gemspec
gem push --key github --host https://rubygems.pkg.github.com/dcotecnologia confset-1.0.0.gem
```
