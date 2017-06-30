# Contributing

> **WARNING:** This guide is a work in progress and will continue to evolve over
> time. If you have content to contribute, please refer to this document
> each time as things may have changed since the last time you contributed.
>
> This warning will be removed once we have settled on a reasonable set of
> guidelines for contributions.

Fork, then clone the repo:

    git clone git@github.com:your-username/redhatgov.github.io.git
    cd redhatgov.github.io
    git remote add upstream https://github.com/RedHatGov/redhatgov.github.io

    # Never push to upstream master
    git remote set-url --push upstream no_push

    # Confirm that your remotes make sense:
    git remote -v

Get your local docs up to date:

    git fetch upstream
    git checkout docs
    git rebase upstream/docs

Make your change.

Push to your fork and [submit a pull request][pr].

At this point you're waiting on us. We may suggest some changes or improvements
or alternatives. We'll do our best to review and at least comment within 3
business days (often much sooner).


[pr]: https://github.com/RedHatGov/redhatgov.github.io/compare/
