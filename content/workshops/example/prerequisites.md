---
title: Prerequisites
workshops: example
workshop_weight: 10
layout: lab
---

# Getting Started

This entire site, including the workshop content, is built using a tool named
[Hugo][hugo_intro]. Hugo is known as a "static site generator" where the
content you build is pre-compiled before being served by a web server.

## The Good News

The good news is that you don't have to worry about how Hugo works, how to
configure it, or how everything gets deployed.

All of that is being handled for you and you can **focus on the content of your
workshop**.

## There Is A "But"

But, you will need to download the Hugo binary so that you can run Hugo on your
laptop while you're working on your workshop. Don't worry though, because all
you need to do is know **one command** and the rest is _magic_.

That command is:

```
$ hugo server
```

That command is what is going to let you work on your workshop content and
preview it live in your browser so you can verify that everything looks like
you intend it to.

# That Sounds Great, Just Tell Me What To Do Already!

You got it!

## Step 1

Hugo requires Asciidoctor in order to proccess your workshop files.

Run the command below to install Asciidoctor using the Ruby gem install command (assuming you have requirements met)

```
$ gem install asciidoctor
```

{{% alert info %}}
If you want more detailed installation instructions or alternative ways to
install Asciidoctor, check out http://asciidoctor.org/. Scroll to the Requirements and Installation sections.
{{% /alert %}}

## Step 2

Go to https://github.com/spf13/hugo/releases/tag/v0.20.7 and scroll to the
**Downloads** section (it's near the bottom).

Here are direct links for the common ones:

- [Linux][hugo_download_linux64]
- [OS X / macOS][hugo_download_macos64]
- [Windows][hugo_download_windows64]

{{% alert warning %}}
You must have Hugo version **0.20.7** or greater. Versions older than 0.20.7
contain a breaking change that will fail to build the site.
{{% /alert %}}

## Step 3

Unpack the download and put the `hugo` binary anywhere you want.

For ease of use, it's best to put it somewhere that's on your `PATH`
(e.g. `/usr/local/bin`, `/usr/bin`), but it is not required. If you don't know
what putting it in your `PATH` means, you can just skip that part.

{{% alert info %}}
If you want more detailed installation instructions or alternative ways to
install Hugo, check out https://gohugo.io/overview/installing/
{{% /alert %}}

## Step 4

Open up your **Terminal** and change to the directory where you want to clone
this [repository][main_repo]. This example assumes you are in the
`~/projects` directory.

```
$ cd ~/projects

$ git clone https://github.com/RedHatGov/redhatgov.github.io.git
```

This will pull down the content of the repo into `~/projects/redhatgov.github.io`

For the next steps, go ahead and change to this directory.

```
$ cd ~/projects/redhatgov.github.io
```

## Step 5

From the `redhatgov.github.io` repo directory, run the Hugo server:

```
$ hugo server
```

You can now go to http://localhost:1313/ in your browser and see your own
local copy of the workshop site.

As long as the `hugo server` command stays running, anytime you make changes
to any of the content it will automatically rebuild the site and refresh your
browser for you.

# It's That Easy

That's all there is to it to getting up and running!

[hugo_download_linux64]: https://github.com/spf13/hugo/releases/download/v0.20.7/hugo_0.20.7_Linux-64bit.tar.gz
[hugo_download_macos64]: https://github.com/spf13/hugo/releases/download/v0.20.7/hugo_0.20.7_macOS-64bit.tar.gz
[hugo_download_windows64]: https://github.com/spf13/hugo/releases/download/v0.20.7/hugo_0.20.7_Windows-64bit.zip
[hugo_install]: https://gohugo.io/overview/installing/
[hugo_intro]: https://gohugo.io/overview/introduction/
[main_repo]: https://github.com/RedHatGov/redhatgov.github.io
