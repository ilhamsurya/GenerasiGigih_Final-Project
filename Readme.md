# Final Assigment Generasi Gigih

## Problem Description

* User Story:
  * Posting a text (max 1000 char) that might contain a hashtags ex: #generasigigih
  * See all posts that contain a certain hashtags (only one hashtag at a time)
  * See top 5 trending hashtags in the past 24 hours
  * Comment on a post, comment can contain hastags
  * Attach pictures(jpg,png,gif), video(mp4) and file

---

## Prerequisites to run the application

* Development
  * Ruby using Rbenv [installation](stackoverflow.com/questions/37405528/ddg#38909715)
  * MySQL :
    >   `sudo apt install mysql-server`
    >   `sudo apt-get install libmysqlclient-dev`
  * Bundler :
    >   `gem install bundler`
  * Sinatra (Gemfile) :
    >   `gem "sinatra"`
  * MySQL2 (Gemfile) :
    >   `gem "mysql2"`

* Testing
  * Rspec (Gemfile) :
    >   `gem "rspec"`
  * Simplecov (Gemfile) :
    >   `gem "simplecov"`

* Deployment
  * Vagrant :
    >   `vagrant init ubuntu/focal64`
  * Ansible :
    >   `sudo apt install ansible`
    >
---

## Run Application & Test Suite

* Application
  * Start MySQL :
    >   `sudo /etc/init.d/mysql start`
  * Start Application :
    >   `ruby app/index.rb`

* Test Suite
  * Run Test :
    >   `rspec app/index.rb`
  * Print Test Result :
    >   `rspec -f d app/index.rb`
    >
