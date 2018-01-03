# Not Wikipedia

Like Wikipedia, Not Wikipedia is a user-maintained encyclopedia. Anyone can view the information on the site, however, to get involved with creating and maintaining wikis, a user needs to create a free account. From there, a user can upgrade to a paid membership, allowing the creation of private wikis, which can be shared with individuals the user wishes to collaborate with.

The app is deployed on Heroku: https://not-wikipedia-heroku.herokuapp.com/

The source code is available at GitHub: https://github.com/baka-san/not-wikipedia

# Features
- Anyone can view public wikis by browsing the site.
- Users can create, edit, delete, and maintain any public wiki using [Markdown syntax](https://en.wikipedia.org/wiki/Markdown).
- Users can pay to upgrade to a premium account, allowing the creation of private wikis. 
- Premium users can invite other users to collaborate on private wikis they have created.
- Premium users can cancel their subscription.
- When a user downgrades their account, their private wikis will automatically be made public.

# Setup and Configuration

**Languages and Frameworks**: Ruby on Rails and Bootstrap

**Ruby version 2.4.0**

**Rails 5.1.4**

**Databases**: SQLite (Test, Development), PostgreSQL (Production)

**Development Tools and Gems include**:

- [Devise](https://github.com/plataformatec/devise) for user authentication
- [Redcarpet](https://github.com/vmg/redcarpet) for Markdown formatting
- [Markdown-js](https://github.com/evilstreak/markdown-js) for live Markdown formatting
- [Pundit](https://github.com/elabs/pundit) for authorization
- [Stripe](https://stripe.com/) for payments
- [Rspec](https://github.com/rspec/rspec-rails) and [FactoryGirl](https://github.com/thoughtbot/factory_bot) for tests

**Setup:**

- Environment variables were set using Figaro and are stored in `config/application.yml` (ignored by git). `config/application.example.yml` demonstrates how to store environment variables.

**To run Not Wikipedia locally:**

- [Clone the repository](https://help.github.com/articles/cloning-a-repository/)
- Run `bundle install` on command line
- Create and migrate the SQLite database with `rake db:create` and `rake db:migrate`
- Start the server using `rails server`
- Run the app on `localhost:3000`