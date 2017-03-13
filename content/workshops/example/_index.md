---
title: Example Workshop
menu:
  main:
    parent: workshops
---

# Introduction

This is an example workshop to showcase what is possible when building workshops. You can find examples of how to organize your content, what shortcodes are available, and the widgets available as a part of the `redhatgov` theme.

{{% alert success %}}
**This workshop is also expected to be used as a starting point for any new workshop.**

Pay special attention to the lab on how to copy this workshop and what changes are required to make your workshop show up in the menus.
{{% /alert %}}

# Labs

{{< labs example >}}

# Content Ideas

- How to use the \_index.md page
- How to display labs using shortcode
- List the available shortcodes with examples
    - built-in - https://gohugo.io/extras/shortcodes/#built-in-shortcodes
        - highlight
        - figure
        - ref, relref
        - tweet
        - youtube
        - vimeo
        - gist
        - speakerdeck
        - instagram
    - custom
        - alert
        - labs
- The difference between \{\{< shortcode >\}\} and \{\{% shortcode %\}\}
- How to use weight to define order of labs
- Describe how to change order of pages for each workshop it's part of

# Shortcode Ideas

- pficon
- fa icon

# Current Limitations

- Syntax highlighting not setup yet

{{< panel_group >}}
{{% panel "Panel 1" %}}
Content 1
{{% /panel %}}
{{% panel "Panel 2" %}}
Content 2
{{% /panel %}}
{{% panel "Panel 3" %}}
Content 3
{{% /panel %}}
{{< /panel_group >}}
