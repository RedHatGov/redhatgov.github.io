---
title: Create A New Workshop
workshops: example
workshop_weight: 20
layout: lab
---

# Don't Recreate The Wheel

Not only is this example workshop here to show you what's possible, but it's
also expected to be the starting point and reference for any new workshop.

The easiest way to get started is to **copy this workshop** into a new
directory and add your own content.

{{% alert warning %}}
**Warning:** There are a few things you'll need to change though, so pay close
attention to each step below to save yourself frustration down the road.
{{% /alert %}}

# Tell Me The Steps Already!

## Step 1

In the [Prerequisites lab]({{< relref "prerequisites.md" >}}), you were told
to clone the https://github.com/RedHatGov/redhatgov.github.io repository. This
works if you want to pull down the source code and build the site locally
using Hugo.

If you want to contribute, **we need to fork the repository** so that you have
your own copy that you can push changes to.

To do that, go to https://github.com/RedHatGov/redhatgov.github.io/fork and
follow the instructions.

{{% alert info %}}
After the forking is complete, you will have your own copy at
https://github.com/YOUR_USERNAME/redhatgov.github.io
{{% /alert %}}

## Step 2

If you cloned the main repository in the Prerequisites lab, follow **Step 2a**.<br/>
If you have not cloned the main repository, follow **Step 2b**.

### Step 2a

Open up your **Terminal** and change to the directory where you cloned the main
repository. This example assumes that location is
`~/projects/redhatgov.github.io`.

```bash
$ cd ~/projects/redhatgov.github.io
```

Currently, the main repository is going to be listed as the `origin` remote. We
need to rename this to `upstream` so that we can add our fork as the `origin`
remote.

First, let's verify that this is true. Run `git remote -v` and you should see
the following output.

```bash
$ git remote -v
origin	https://github.com/RedHatGov/redhatgov.github.io.git (fetch)
origin	https://github.com/RedHatGov/redhatgov.github.io.git (push)
```

Now we will rename the main repository from `origin` to `upstream` and add your
fork as `origin`. Take note of `YOUR_USERNAME` and replace that before running
the 2nd command.

```bash
$ git remote rename origin upstream

$ git remote add origin git@github.com:YOUR_USERNAME/redhatgov.github.io.git
```

Let's check `git remote -v` to verify everything looks correct.

```bash
$ git remote -v                                                           
origin	git@github.com:YOUR_USERNAME/redhatgov.github.io.git (fetch)
origin	git@github.com:YOUR_USERNAME/redhatgov.github.io.git (push)
upstream	https://github.com/RedHatGov/redhatgov.github.io.git (fetch)
upstream	https://github.com/RedHatGov/redhatgov.github.io.git (push)
```

Lastly, we need to update your local `docs` branch to point to the remote
`docs` branch in your fork.

```bash
$ git fetch --all

$ git branch --set-upstream-to origin/docs docs
Branch docs set up to track remote branch docs from origin.
```

You can now move on to **Step 3**.

### Step 2b

Open up your **Terminal** and change to the directory where you want to clone
your fork of the repository. This example assumes you are in the
`~/projects` directory.

```bash
$ cd ~/projects

$ $ git clone git@github.com:YOUR_USERNAME/redhatgov.github.io.git
```

Next, let's add the main repository as the `upstream` remote so that you'll be
able to pull down changes as needed.

```bash
$ git remote add upstream https://github.com/RedHatGov/redhatgov.github.io.git
```

Let's check `git remote -v` to verify everything looks correct.

```bash
$ git remote -v                                                           
origin	git@github.com:YOUR_USERNAME/redhatgov.github.io.git (fetch)
origin	git@github.com:YOUR_USERNAME/redhatgov.github.io.git (push)
upstream	https://github.com/RedHatGov/redhatgov.github.io.git (fetch)
upstream	https://github.com/RedHatGov/redhatgov.github.io.git (push)
```

You can now move on to **Step 3**.

## Step 3

Now that you have the files on your computer, you can get to working on your
workshop content!

Let's start by copying this example to a new directory. You can find the source
code for this example workshop at
`~/projects/redhatgov.github.io/content/workshops/example`.

```bash
$ cd ~/projects/redhatgov.github.io/content/workshops

$ cp -rv example new_workshop
```

# Personalization

{{% alert warning %}}
This is a very important section. If you skip this section, your content will
not show up where you expect it to.
{{% /alert %}}

Now that we have our new workshop, there are a few things we need to update
in order to make our content show up in the correct location and remain linked
together.

## Step 1

Let's start with the name of your workshop.

This is set in the metadata section at the top of the `_index.md` file.

By default, it will look something like this:

```yaml
---
title: Example Workshop
menu:
  main:
    parent: workshops
---
```

Update `title: Example Workshop` to be the name of your workshop.

{{% alert warning %}}
Be sure to keep the `menu` section there, otherwise your workshop will not show
up on the home page or the navigation bar.
{{% /alert %}}

You can then update the content of this file to be the content you wish to have
on the main page of your workshop.

{{% alert info %}}
Take note of the <code>\{\{< labs example >\}\}</code> item under the **Labs**
heading. This is a _shortcode_ that will automatically add a list of your labs
to your main page and keep it updated as you add new labs.

You will need to update the value `example` to match the name of the directory
that your new workshop is in. Following the example from above, this would be
`new_workshop`.
{{% /alert %}}

## Step 2

Next, let's take a look at one of the lab files. We'll use `prerequisites.md`
as an example.

You will see this metadata section at the top of that file:

```yaml
---
title: Prerequisites
workshops: example
workshop_weight: 10
layout: lab
---
```

We need to update a few things here in order to have the lab content show up
under your new workshop.

- `title`: Set this to the title of your lab.
- `workshops`: This value needs to match the name of the directory you created
  for your workshop. **This is how your lab is associated with your workshop.**
- `workshop_weight`: This is how you control the ordering of your labs.
- `layout`: Keep this value set to `lab` as it will ensure the proper layout of
  your content and will include forward and back buttons for your labs.

{{% alert info %}}
You may need to restart the Hugo server in order for your listing of labs to show up on the workshop index.

Hit ctrl+c in the terminal window where you launched the hugo server command. Then rerun hugo server to restart.
{{% /alert %}}

## Step 3

You are now free to add your own content for your workshop.

For each lab:

- Create a new file
- Add the metadata section from **Step 2** to the top of the file
- Add your content

{{% alert warning %}}
Be sure to delete any files in your workshop directory that are left over from
the example workshop that you are not using.
{{% /alert %}}
