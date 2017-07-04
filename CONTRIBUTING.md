# Contributing

> **WARNING:** This guide is a work in progress and will continue to evolve over
> time. If you have content to contribute, please refer to this document
> each time as things may have changed since the last time you contributed.
>
> This warning will be removed once we have settled on a reasonable set of
> guidelines for contributions.

### 1 [Fork][git-fork] the RedHatGov.io repository

Forking RedHatGov.io is a simple two-step process.

1. On GitHub, navigate to the https://github.com/RedHatGov/redhatgov.github.io
repo.
2. In the top-right corner of the page, click **Fork**.

That's it! Now, you have a _fork_ of the original RedHatGov/redhatgov.github.io
repo.

### 2 Create a local [clone][git-clone] of your fork

```sh
git clone git@github.com:your-username/redhatgov.github.io.git
cd redhatgov.github.io

# Configure git to sync your fork with the original repo
git remote add upstream https://github.com/RedHatGov/redhatgov.github.io

# Never push to upstream repo
git remote set-url --push upstream no_push
```

### 3 Verify your [remotes][git-remotes]

To verify the new upstream repository you've specified for your fork, type
`git remote -v`. You should see the URL for your fork as `origin`, and the URL for the original repository as `upstream`.

```sh
origin  git@github.com:your-username/redhatgov.github.io.git (fetch)
origin  git@github.com:your-username/redhatgov.github.io.git (push)
upstream        https://github.com/RedHatGov/redhatgov.github.io (fetch)
upstream        no_push (push)
```

### 3 Modify your `docs` [branch][git-branch]

Get your local `docs` branch, up to date:

```sh
git fetch upstream
git checkout docs
git rebase upstream/docs
```

Then build your local `docs` branch, make code changes, etc.

### 4 Keep your `docs` in sync

```sh
git fetch upstream
git rebase upstream/master
```

### 5 [Commit][git-commit] your `docs`

```sh
git commit
```

Likely you'll go back and edit, build, test, etc.

### 6 [Push][git-push] your `docs`

When ready to review (or just to establish an offsite backup of your work),
push your branch to your fork on `github.com`:

```sh
git push
```

### 7 Submit a [pull request][pr]

1. Visit your fork at https://github.com/your-username/redhatgov.github.io.git
2. Click the `Compare & Pull Request` button next to your `docs` branch.

At this point you're waiting on us. We may suggest some changes or improvements
or alternatives. We'll do our best to review and at least comment within 3
business days (often much sooner).

_If you have upstream write access_, please refrain from using the GitHub UI
for creating PRs, because GitHub will create the PR branch inside the main
repository rather than inside your fork.

[git-fork]: https://help.github.com/articles/fork-a-repo/
[git-clone]: https://git-scm.com/docs/git-clone
[git-remotes]: https://git-scm.com/book/en/v2/Git-Basics-Working-with-Remotes
[git-branch]: https://git-scm.com/docs/git-branch
[git-commit]: https://git-scm.com/docs/git-commit
[git-push]: https://git-scm.com/docs/git-push
[pr]: https://github.com/RedHatGov/redhatgov.github.io/compare/
