---
title: Hugo Shortcodes
workshops: example
workshop_weight: 40
layout: lab
toc: true
---

Hugo uses Markdown for its simple content format. However, there are a lot
of things that Markdown doesn’t support well.

We are unwilling to accept being constrained by our simple format. Also
unacceptable is writing raw HTML in our Markdown every time we want to include
unsupported content such as a video. To do so is in complete opposition to the
intent of using a bare-bones format for our content and utilizing templates to
apply styling for display.

To avoid both of these limitations, Hugo created shortcodes.

A shortcode is a simple snippet inside a content file that Hugo will render
using a predefined template. Note that shortcodes will not work in template
files---if you need a functionality like that in a template, you most likely
want a [partial template](/templates/partials/) instead.

Another benefit is, you can update your shortcode with any related new classes or
techniques, and upon generation, Hugo will easily merge in your changes. You
avoid a possibly complicated search and replace operation.

## Using a shortcode

In your content files, a shortcode can be called by using the `{{%/* name parameters
*/%}}` form. Shortcode parameters are space delimited.  Parameters with spaces
can be quoted.

The first word is always the name of the shortcode. Parameters follow the name.
Depending upon how the shortcode is defined, the parameters may be named,
positional or both (although you can't mix parameter types in a single call).
The format for named parameters models that of HTML with the format
`name="value"`.

Some shortcodes use or require closing shortcodes. Like HTML, the opening and closing
shortcodes match (name only), the closing being prepended with a slash.

Example of a paired shortcode:

```bash
{{</* highlight go */>}} A bunch of code here {{</* /highlight */>}}
```

The examples above use two different delimiters, the difference being the `%` and the `<` character:

### Shortcodes with Markdown

The `%` characters indicates that the shortcode's inner content needs further processing by the page's rendering processor (i.e. Markdown), needed to get the **bold** text in the example below:

```bash
{{%/* myshortcode */%}}Hello **World!**{{%/* /myshortcode */%}}
```

### Shortcodes without Markdown

The `<` character indicates that the shortcode's inner content doesn't need any further rendering, this will typically be pure HTML:

```bash
{{</* myshortcode */>}}<p>Hello <strong>World!</strong></p>{{</* /myshortcode */>}}
```


## Built-in Shortcodes

Hugo ships with a set of predefined shortcodes.

### Highlight

This shortcode will convert the source code provided into syntax highlighted HTML.

#### Dependencies

1. Install Python from python.org. Version 2.7.x is already sufficient.
2. Run `pip install Pygments` in order to install Pygments. Once installed, Pygments gives you a command pygmentize. Make sure it sits in your PATH, otherwise Hugo cannot find it.


#### Usage

`highlight` takes exactly one required parameter of _language_ and requires a
closing shortcode.

#### Example

```bash
{{</* highlight javascript */>}}
//  OpenShift sample Node application
var express = require('express'),
    fs      = require('fs'),
    app     = express(),
    eps     = require('ejs'),
    morgan  = require('morgan');
    
Object.assign=require('object-assign')

app.engine('html', require('ejs').renderFile);
app.use(morgan('combined'))

var port = process.env.PORT || process.env.OPENSHIFT_NODEJS_PORT || 8080,
    ip   = process.env.IP   || process.env.OPENSHIFT_NODEJS_IP || '0.0.0.0',
    mongoURL = process.env.OPENSHIFT_MONGODB_DB_URL || process.env.MONGO_URL,
    mongoURLLabel = "";
{{</* /highlight */>}}
```

#### Example Output

{{< highlight javascript >}}
//  OpenShift sample Node application
var express = require('express'),
    fs      = require('fs'),
    app     = express(),
    eps     = require('ejs'),
    morgan  = require('morgan');
    
Object.assign=require('object-assign')

app.engine('html', require('ejs').renderFile);
app.use(morgan('combined'))

var port = process.env.PORT || process.env.OPENSHIFT_NODEJS_PORT || 8080,
    ip   = process.env.IP   || process.env.OPENSHIFT_NODEJS_IP || '0.0.0.0',
    mongoURL = process.env.OPENSHIFT_MONGODB_DB_URL || process.env.MONGO_URL,
    mongoURLLabel = "";
{{< /highlight >}}


### Figure

`figure` is simply an extension of the image capabilities present with Markdown.
`figure` provides the ability to add captions, CSS classes, alt text, links etc.

#### Usage

`figure` can use the following named parameters:

 * src
 * link
 * title
 * caption
 * class
 * attr (attribution)
 * attrlink
 * alt

#### Example

```bash
{{</* figure src="../images/lab1_oc_coolstore_dev1.png" title="OpenShift Coolstore" */>}}
```

#### Example output

{{< figure src="../images/lab1_oc_coolstore_dev1.png" title="OpenShift Coolstore" >}}


### Twitter

You want to include a single tweet into your blog post? Everything you need is the URL of the tweet, e.g.:

* https://twitter.com/rhatdan/status/870339796383805440

Pass the tweet's ID from the URL as parameter to the shortcode as shown below:

```bash
{{</* tweet 870339796383805440 */>}}
```

{{< tweet 870339796383805440 >}}

### YouTube

This shortcode embeds a responsive video player for [YouTube](https://www.youtube.com/) videos. Only the ID of the video is required, e.g.:

* https://www.youtube.com/watch?v=kDJveLN5UOs

Copy the ID from behind `v=` and pass it to the shortcode:

```bash
{{</* youtube kDJveLN5UOs */>}}
```

{{< youtube kDJveLN5UOs >}}


Furthermore, you can autostart the embedded video by setting the `autostart` parameter to true. Remember that you can't mix named an unamed parameters. Assign the yet unamed video id to the parameter `id` like below too.

```bash
{{</* youtube id="kDJveLN5UOs" autoplay="true" */>}}
```

### Vimeo

Adding a video from [Vimeo](https://vimeo.com/) is equivalent to the YouTube shortcode above. Extract the ID from the URL, e.g.:

* https://vimeo.com/channels/staffpicks/164267733

and pass it to the shortcode:

```bash
{{</* vimeo 164267733 */>}}
```

{{< vimeo 164267733 >}}

### GitHub gists

Including code snippets with GitHub gists while writing a tutorial is common situation bloggers face. With a given URL of the gist, e.g.:

* https://gist.github.com/christian-posta/04303c08625a7cc39b2626e964a49d79

pass the owner and the ID of the gist to the shortcode:

```bash
{{</* gist dischord01 f43dbb1b2cdfc4c3802f */>}}
```

If the gist contains several files and you want to quote just one of them, you can pass the filename (quoted) as an optional third argument.

```bash
{{</* gist dischord01 f43dbb1b2cdfc4c3802f "img.html" */>}}
```

{{< gist dischord01 f43dbb1b2cdfc4c3802f >}}

### Speaker Deck

To embed slides from [Speaker Deck](https://speakerdeck.com/), click on "&lt;&#8239;/&gt;&nbsp;Embed" (under Share right next to the template on Speaker Deck) and copy the URL, e.g.:

```html
<script async class="speakerdeck-embed" data-id="d1900e50eb564917a49200bf690d1644" data-ratio="1.33333333333333" src="//speakerdeck.com/assets/embed.js"></script>
```


Extract the value from the field `data-id` and pass it to the shortcode:

```bash
{{</* speakerdeck d1900e50eb564917a49200bf690d1644 */>}}
```

{{< speakerdeck d1900e50eb564917a49200bf690d1644 >}}


### Instagram

If you'd like to embed photo from [Instagram](https://www.instagram.com/), all you need is photo ID from the URL, e. g.:

* https://www.instagram.com/p/BTonNFFA7QJ/

Pass it to the shortcode:

    {{</* instagram BTonNFFA7QJ */>}}

Optionally, hide caption:

    {{</* instagram BTonNFFA7QJ hidecaption */>}}


{{< instagram BTonNFFA7QJ >}}

## Creating your own shortcodes

To create a shortcode, place a template in the layouts/shortcodes directory. The
template name will be the name of the shortcode.

In creating a shortcode, you can choose if the shortcode will use _positional
parameters_, or _named parameters_, or _both_. A good rule of thumb is that if a
shortcode has a single required value in the case of the `youtube` example below,
then positional works very well. For more complex layouts with optional
parameters, named parameters work best.  Allowing both types of parameters is
useful for complex layouts where you want to set default values that can be
overridden.

**Inside the template**

To access a parameter by position, the `.Get` method can be used:

```bash
{{ .Get 0 }}
```

To access a parameter by name, the `.Get` method should be utilized:

```bash
{{ .Get "class" }}
```

`with` is great when the output depends on a parameter being set:

```bash
{{ with .Get "class"}} class="{{.}}"{{ end }}
```

`.Get` can also be used to check if a parameter has been provided. This is
most helpful when the condition depends on either one value or another...
or both:

```bash
{{ or .Get "title" | .Get "alt" | if }} alt="{{ with .Get "alt"}}{{.}}{{else}}{{.Get "title"}}{{end}}"{{ end }}
```

If a closing shortcode is used, the variable `.Inner` will be populated with all
of the content between the opening and closing shortcodes. If a closing
shortcode is required, you can check the length of `.Inner` and provide a warning
to the user.

A shortcode with `.Inner` content can be used without the inline content, and without the closing shortcode, by using the self-closing syntax:

```bash
{{</* innershortcode /*/>}}
```

The variable `.Params` contains the list of parameters in case you need to do
more complicated things than `.Get`.  It is sometimes useful to provide a
flexible shortcode that can take named or positional parameters.  To meet this
need, Hugo shortcodes have a `.IsNamedParams` boolean available that can be used
such as `{{ if .IsNamedParams }}...{{ else }}...{{ end }}`.  See the
`Single Flexible Example` below for an example.

You can also use the variable `.Page` to access all the normal [Page Variables](/templates/variables/).

A shortcodes can be nested. In a nested shortcode you can access the parent shortcode context with `.Parent`. This can be very useful for inheritance of common shortcode parameters from the root.

## Single Positional Example: youtube

```bash
{{</* youtube 09jf3ow9jfw */>}}
```

Would load the template /layouts/shortcodes/youtube.html


```bash
<div class="embed video-player">
<iframe class="youtube-player" type="text/html" width="640" height="385" src="httwww.youtube.com/embed/{{ index .Params 0 }}" allowfullscreen frameborder="0">
</iframe>
</div>
```

This would be rendered as:

```bash
<div class="embed video-player">
<iframe class="youtube-player" type="text/html"
    width="640" height="385"
    src="http://www.youtube.com/embed/09jf3ow9jfw"
    allowfullscreen frameborder="0">
    </iframe>
</div>
```


## Single Named Example: image with caption

```bash
{{</* img src="/media/spf13.jpg" title="Steve Francia" */>}}
```

Would load the template /layouts/shortcodes/img.html

```bash
<!-- image -->
<figure {{ with .Get "class" }}class="{{.}}"{{ end }}>
    {{ with .Get "link"}}<a href="{{.}}">{{ end }}
        <img src="{{ .Get "src" }}" {{ if or (.Get "alt") (.Get "caption") }}alt=with .Get "alt"}}{{.}}{{else}}{{ .Get "caption" }}{{ end }}"{{ end }} />
    {{ if .Get "link"}}</a>{{ end }}
    {{ if or (or (.Get "title") (.Get "caption")) (.Get "attr")}}
    <figcaption>{{ if isset .Params "title" }}
        <h4>{{ .Get "title" }}</h4>{{ end }}
        {{ if or (.Get "caption") (.Get "attr")}}<p>
        {{ .Get "caption" }}
        {{ with .Get "attrlink"}}<a href="{{.}}"> {{ end }}
            {{ .Get "attr" }}
        {{ if .Get "attrlink"}}</a> {{ end }}
        </p> {{ end }}
    </figcaption>
    {{ end }}
</figure>
<!-- image -->
```


Would be rendered as:

```bash
<figure >
    <img src="/media/spf13.jpg"  />
    <figcaption>
        <h4>Steve Francia</h4>
    </figcaption>
</figure>
```

## Single Flexible Example: vimeo with defaults

```bash
{{</* vimeo 49718712 */>}}
{{</* vimeo id="49718712" class="flex-video" */>}}
```

Would load the template /layouts/shortcodes/vimeo.html

```bash
{{ if .IsNamedParams }}
  <div class="{{ if .Get "class" }}{{ .Get "class" }}{{ else }}vimeo-container{{ }}">
    <iframe src="//player.vimeo.com/video/{{ .Get "id" }}" allowfullscreen></iframe>
  </div>
{{ else }}
  <div class="{{ if len .Params | eq 2 }}{{ .Get 1 }}{{ else }}vimeo-container{{ }}">
    <iframe src="//player.vimeo.com/video/{{ .Get 0 }}" allowfullscreen></iframe>
  </div>
{{ end }}
```

Would be rendered as:

```bash
<div class="vimeo-container">
  <iframe src="//player.vimeo.com/video/49718712" allowfullscreen></iframe>
</div>
<div class="flex-video">
  <iframe src="//player.vimeo.com/video/49718712" allowfullscreen></iframe>
</div>
```

## Paired Example: Highlight
*Hugo already ships with the `highlight` shortcode*

```bash
{{</* highlight html */>}}
<html>
    <body> This HTML </body>
</html>
{{</* /highlight */>}}
```

The template for this utilizes the following code (already included in Hugo)

```bash
{{ .Get 0 | highlight .Inner  }}
```

And will be rendered as:

```bash
<div class="highlight" style="background: #272822"><pre style="line-height: 125%"><sstyle="color: #f92672">&lt;html&gt;</span>
    <span style="color: #f92672">&lt;body&gt;</span> This HTML <span style="col#f92672">&lt;/body&gt;</span>
<span style="color: #f92672">&lt;/html&gt;</span>
</pre></div>
```

Please notice that this template makes use of a Hugo-specific template function
called `highlight` which uses Pygments to add the highlighting code.

## Simple Single-word Example: Year

Let's assume you would like to have a shortcode to be replaced by the current year in your Markdown content files, for a license or copyright statement. Calling a shortcode like this:

```bash
{{</* year */>}}
```

... would load your one-line template ``/layouts/shortcodes/year.html``, which contains:

```bash
{{ .Page.Now.Year }}
```

More shortcode examples can be found at [spf13.com](https://github.com/spf13/spf13.com/tree/master/layouts/shortcodes).