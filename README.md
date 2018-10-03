
# DrgResourcesPlugin
This is DRG CMS plugin which can be used for internal resources reservation. I am using it for keeping record of company autopark, but it can be used for any kind of resource reservation.
Resorces have category field, to distinct different kind of resources. Resources categories must be defined in Big Table under 'resource-categories' key.

## Usage
Add this line to your application's Gemfile:

```ruby
gem 'drg_resources_plugin'
```
and run bundle to add new gem to application.

Create page with resources link, set design to Portal design and set site to your portal name.
Create new top menu option in site menu and link it to Resources page.

Refresh browser and click Resources menu option.

## Contributing
Fork this repository on GitHub and issue a pull request 

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
