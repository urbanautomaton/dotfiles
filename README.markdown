# my ludicrous dotfiles

Look, I'll be honest with you, I'm not even 100% sure why *I* use this
stuff, so I don't really recommend anyone else uses it.

Still, it's almost certainly the most effort I've put into open source
software, so sod it, let's cackhandedly document this boy.

## vim shenanigans

Ignore completely. Go look at @tpope's dotfiles or something. I know
literally nothing about this editor I've spent the last 6 years in.

## `env_hooker`

I'm sort of vaguely proud of this, I guess? It was born out of the
observation:

> Huh. I spend a lot of time cd'ing into directories and hoping that
> some sort of environment is set up as a result.

Examples include:

1. I enter a directory with a `.ruby-version`. I want `chruby` to pick the
   appropriate version
2. I enter a directory with a `.gemset` file. I want `gem_home` to
   modify the gem path appropriately
3. I enter a golang workspace directory. I want to set `$GOPATH` to...
   whatever the godawful hell `$GOPATH` should be
4. I enter a node project directory. I want to add `node_modules/.bin`
   to `$PATH`.

So basically, this is a system that lets you define "hook files" which,
if present, will fire a bash function (that you also define) when
entering the directory, and will fire a cleanup function (guess who
defines this!) when you leave.

So for example my node hook looks like this:

```bash
function enter_node_project {
  local -r current_dir=$1

  NODE_PATH_AUTO="${current_dir}/node_modules/.bin"
  add_to_path "${NODE_PATH_AUTO}"
}

function exit_node_project {
  if [[ -n "${NODE_PATH_AUTO}" ]]; then
    remove_from_path "${NODE_PATH_AUTO}"
    unset NODE_PATH_AUTO
  fi
}

register_env_hook .nodeproject node_project
```

And now all I need to do to get `node_modules/.bin` in my `$PATH` is
ensure there's a `.nodeproject` file in the project root.

The pattern by which this happens was entirely cribbed from
@postmodern's
[`chruby/auto.sh`](https://github.com/postmodern/chruby/blob/22a99ad3341b05a52f51fb924495359e9e42ef3c/share/chruby/auto.sh)
script - I've just (sorta) generalised it so it can be used for
different project types.
