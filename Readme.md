# Final Assigment Generasi Gigih

## Problem Description

* User Story:
  * [✓] Posting a text (max 1000 char) that might contain a hashtags ex: #generasigigih
  * [✓] See all posts that contain a certain hashtags (only one hashtag at a time)
  * [✓] See top 5 trending hashtags in the past 24 hours
  * [✓] Comment on a post, comment can contain hastags
  * [✓] Attach pictures(jpg,png,gif), video(mp4) and file to the post and comment

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
## API Documentation
More about API Implementation, explained in postman collection:
[API Documentation](https://github.com/ilhamsurya/GenerasiGigih_Final-Project/tree/main/postman)

---

## Run Application & Test Suite

* Application
  * Start MySQL :
    >   `sudo /etc/init.d/mysql start`
  * Start Application :
    >   `ruby index.rb`

* Test Suite
  * Run Single Test :
    >   `rspec ./spec/{controller/model}/{file_spec.rb}`
  * Run All Test :
    >   `rspec -f d`

