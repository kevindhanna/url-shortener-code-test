# Url Shortener Code Test
This app runs a web API that responds to `POST` with a json body  
containing a URL, which responds with a JSON repsonse containing  
a shortened version of the given url.
If a `GET` request is sent to a previously returned URL, it redirects
to the POSTed URL.
  
## Install
requires Ruby `~> 2.6.3`
  
- git clone https://github.com/kevindhanna/url-shortener-code-test
- run `bundle install`
  
## Run
### Localhost
  
- run `rackup -p 4000`
  
### In Docker
  
- run `docker build -t url_shortener .`
- run `docker run -d -p 4000:4000 url_shortener`

## Run tests
  
- run `bundle exec rspec`
- run `bundle exec rubocop`

## How to use
  
Create a new shortened URL:
- run `curl localhost:4000 -XPOST -d '{ "url": "https://www.google.com" }'`  
  => `{"short_url":"/google","url":"https://www.google.com"}`

Visit the shortened URL:
- run `curl -v localhost:4000/google`  
  => 
  ```
  ...
  < HTTP/1.1 301 Moved Permanently
  ...
  < Location: https://www.fubar.com
  ...
  ```
![URLShortener](https://i.imgur.com/EaWDGdW.png)
