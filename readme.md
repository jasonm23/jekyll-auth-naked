# Jekyll Auth Naked

A simple way to use GitHub OAuth to self-host a protected jekyll site
 to your GitHub organization

[![Gem Version](https://badge.fury.io/rb/jekyll-auth-naked.png)](http://badge.fury.io/rb/jekyll-auth-naked)
[![Build Status](https://travis-ci.org/jasonm23/jekyll-auth-naked.png?branch=master)](https://travis-ci.org/jasonm23/jekyll-auth-naked)

## The problem

[Jekyll](http://github.com/mojombo/jekyll) and
[GitHub Pages](http://pages.github.com) are awesome, right? Static
site, lightning fast, everything versioned in Git. What else could you
ask for?

But what if you only want to share that site with a select number of
people? Before, you were screwed...

Now, simply host the site, and whenever someone tries to access it, it
will oauth them against GitHub, and make sure they're a member of your
Team. Pretty cool, huh?!?

## Requirements

1. A GitHub account (one per user)
2. A GitHub Organization
3. A Team for your Github Organization (team members will have access to the Jekyll site)
3. A GitHub Application ([You can register one for free](https://github.com/settings/applications/new))

## Getting Started

### Create a GitHub Application

1. Navigate to [the GitHub app registration page](https://github.com/settings/applications/new)
2. Give your app a name
3. Tell GitHub the URL you want the app to eventually live at
4. The Callback Url is your apps's URL + `/auth/github/callback`
5. Hit Save, but leave the page open, you'll need some of the information in a moment

### Add Jekyll Auth Naked to your site

First, add `gem 'jekyll-auth-naked'` to your `Gemfile` or if you don't
already have a `Gemfile`, create a file called `Gemfile` in the root
of your site's repository with the following content:

```
source "https://rubygems.org"

gem 'jekyll-auth-naked'
```

Next, `cd` into your project's directory and run `bundle install`.

Finally, run `jekyll-auth-naked new` which will run you through
everything you need to set up your site with Jekyll Auth Naked.

### Whitelisting

Don't want to require authentication for every part of your site?
Fine! Add a whitelist to your Jekyll's *_config.yml_* file:

```yaml
jekyll_auth_naked:
  whitelist:
    - drafts?
```

`jekyll_auth-naked.whitelist` takes an array of regular expressions as
strings. The default auth behavior checks (and blocks) against root
(`/`). Any path defined in the whitelist won't require authentication
on your site.

What if you want to go the other way, and unauthenticate the entire
site _except_ for certain portions? You can define some regex magic
for that:

```yaml
jekyll_auth_naked:
  whitelist:
    - "^((?!draft).)*$"
```

## Requiring SSL

If you've got SSL set up simply add the following your your
`_config.yml` file to ensure SSL is enforced.

```yaml
jekyll_auth_naked:
  ssl: true
```

## Running locally

Want to run it locally? Just run `jekyll serve` as you would normally

### Locally with authentication

1. `export GITHUB_CLIENT_ID=[your github app client id]`
2. `export GITHUB_CLIENT_SECRET=[your github app client secret]`
3. `export GITHUB_ORG_ID=[org id]` or `export GITHUB_TEAM_ID=[team id]`
4. `jekyll-auth-naked serve`

*Pro-tip #1:* For sanity sake, and to avoid problems with your
 callback URL, you may want to have two apps, one with a local oauth
 callback, and one for production if you're going to be testing auth
 locally.

*Pro-tip #2*: Jekyll Auth Naked supports
 [dotenv](https://github.com/bkeepers/dotenv) out of the box. You can
 create a `.env` file in the root of site and add your configuration
 variables there. It's ignored by `.gitignore` if you use `jekyll-auth
 new`, but be sure not to accidentally commit your `.env` file. Here's
 what your `.env` file might look like:

```
GITHUB_CLIENT_SECRET=abcdefghijklmnopqrstuvwxyz0123456789
GITHUB_CLIENT_ID=qwertyuiop0001
GITHUB_TEAM_ID=12345
```

## Github Hooks

Every time you push to Github, you can send a webhook request to your
jekyll blog, and it will update.

### Setting up Github Hooks

TODO

### Serving with Nginx

TODO

## Jekyll Auth

Jekyll Auth Naked is a fork of Jekyll Auth, which provides Heroku
hosting support out of the box. If this is what you want, go there
now, you'll be happier.
