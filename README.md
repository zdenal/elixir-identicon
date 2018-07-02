# Identicon

This lib is generating identicon avatar based on given name. My first experiment
with Elixir, following the great guide on Udemy.

## Run
Generating identicon for `zdenal` nickname.
```
$> mix deps.get

$> iex -S mix

iex> Identicon.main("zdenal")
```
result is:

![result for zdenal text](https://github.com/zdenal/elixir-identicon/blob/master/zdenal.png)
