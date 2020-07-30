# Primer

Service manager for ruby projects

## Installation

Add this line to your application's Gemfile:

    gem 'primer'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install primer

## Usage

Primer is a generalized runner for services you write in your ruby application.  
It allows you to start, stop and restart services you define.  
It also has the ability to return the status of your services and list available services to run

* Start a service

```sh
$ be primer start nginx
```

Output
```sh
∙ Starting nginx
✓ nginx started with pid <pid>.
```

* Stop a service

```sh
$ be primer stop nginx
```
Output
```sh
∙ Stopping nginx
✗ nginx is stopped
```

* Restart a service

```sh
$ be primer restart nginx
```
Output
```sh
∙ Restarting nginx
✓ nginx started with pid <pid>.
```

* Start 2 services

```sh
$ be primer start nginx faye
```
Output
```sh
∙ Starting nginx
✓ nginx started with pid <pid>.
∙ Starting faye
✓ faye started with pid <pid>.
```

* Start all registered services

```sh
$ be primer start
```
Output
```sh
∙ Starting nginx
✓ nginx started with pid <pid>.
∙ Starting faye
✓ faye started with pid <pid>.
∙ Starting service3
✓ service3 started with pid <pid>.
∙ Starting service4
✓ service4 started with pid <pid>.
```

* Check the status of existing services

```sh
$ be primer status
```
Output
```sh
✓ benchprep-instructor-dashboard started with pid 13020.
✓ benchprep-teachers started with pid 13035.
✓ benchprep-course-publisher started with pid 13050.
✓ sidekiq started with pid 13060.
✓ nginx started with pid 13068.
✓ benchprep-marketing started with pid 13085.
✓ benchprep-v2 started with pid 13099.
✓ benchprep_reporting_api started with pid 13117.
✓ benchprep-sso started with pid 13128.
✓ benchprep-webapp started with pid 13142.
✓ tenant-dashboard started with pid 13157.
✓ benchprep-user-manager started with pid 13170.
```

### Writing a service
* An nginx service

```ruby
module Services
  class NginxService < Primer::BaseService
    register "nginx" # Register this service so we can refer to it on the command line
    set_running_command "nginx: master process" # We use this to check nginx's running status
    
    def start
        nginx -c #{nginx_conf_file}
    end
    
    def stop
        nginx -s stop
    end
  end
end
```
### Tell primer where your services reside
* Include a .primerrc in your project root

Sample .primerrc file:
```ruby
--services=./lib/services
```
Primer will require all the files in this directory and register them as services if they call the 'register' method.
