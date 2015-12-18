#Kynigos
[![Build Status](https://travis-ci.org/vinnyoodles/kynigos.svg?branch=master)](https://travis-ci.org/vinnyoodles/kynigos)
[![Code Climate](https://codeclimate.com/github/vinnyoodles/kynigos/badges/gpa.svg)](https://codeclimate.com/github/vinnyoodles/kynigos)
[![Dependency Status](https://www.versioneye.com/user/projects/56749d1e10799700300007dc/badge.svg?style=flat)](https://www.versioneye.com/user/projects/56749d1e10799700300007dc)

###Overview
Explores reddit and subreddits for listings with specific keywords

###Installation
```
$ git clone git@github.com:vinnyoodles/kynigos.git
```
This can also be added to Rails applications as a gem.
```
$ gem install kynigos
```

###Getting started
First, update `lib/tasks/hunt.rake` to customize your reddit account and subreddit.
```
Kynigos.new(username: ENV["REDDIT_USERNAME"], password: ENV["REDDIT_PASSWORD"]).
      send_prize 'reddit_account', keywords, 'subreddit'
```
Also, update the `lib/keywords.yml` file to include your keywords.
```
keywords:
  - Foo
  - Bar
```
Finally, run the command in your terminal and reap the rewards in your reddit account.
```
$ rake send
```

###Contributing
Anyone is encouraged to contribute by either posting issues or submitting pull requests.


###License
Kynigos is released under the [MIT License](http://opensource.org/licenses/MIT).
