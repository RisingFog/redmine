require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module RedmineApp
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths += %W(#{config.root}/lib)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    config.active_record.store_full_sti_class = true
    config.active_record.default_timezone = :local

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    I18n.enforce_available_locales = true

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable the asset pipeline
    config.assets.enabled = false

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'

    config.action_mailer.perform_deliveries = false

    # Do not include all helpers
    config.action_controller.include_all_helpers = false

    # XML parameter parser removed from core in Rails 4.0
    # and extracted to actionpack-xml_parser gem
    config.middleware.insert_after ActionDispatch::ParamsParser, ActionDispatch::XmlParamsParser

    # Specific cache for search results, the default file store cache is not
    # a good option as it could grow fast. A memory store (32MB max) is used
    # as the default. If you're running multiple server processes, it's
    # recommended to switch to a shared cache store (eg. mem_cache_store).
    # See http://guides.rubyonrails.org/caching_with_rails.html#cache-stores
    # for more options (same options as config.cache_store).
    config.redmine_search_cache_store = :memory_store

    # Configure log level here so that additional environment file
    # can change it (environments/ENV.rb would take precedence over it)
    config.log_level = Rails.env.production? ? :info : :debug

    config.session_store :cookie_store, :key => '_redmine_session'

    if File.exists?(File.join(File.dirname(__FILE__), 'additional_environment.rb'))
      instance_eval File.read(File.join(File.dirname(__FILE__), 'additional_environment.rb'))
    end
  end
end
# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])
# = Redmine configuration file
#
# Each environment has it's own configuration options.  If you are only
# running in production, only the production block needs to be configured.
# Environment specific configuration options override the default ones.
#
# Note that this file needs to be a valid YAML file.
# DO NOT USE TABS! Use 2 spaces instead of tabs for identation.

# default configuration options for all environments
default:
  # Outgoing emails configuration
  # See the examples below and the Rails guide for more configuration options:
  # http://guides.rubyonrails.org/action_mailer_basics.html#action-mailer-configuration
  email_delivery:

  # ==== Simple SMTP server at localhost
  #
  #  email_delivery:
  #    delivery_method: :smtp
  #    smtp_settings:
  #      address: "localhost"
  #      port: 25
  #
  # ==== SMTP server at example.com using LOGIN authentication and checking HELO for foo.com
  #
  #  email_delivery:
  #    delivery_method: :smtp
  #    smtp_settings:
  #      address: "example.com"
  #      port: 25
  #      authentication: :login
  #      domain: 'foo.com'
  #      user_name: 'myaccount'
  #      password: 'password'
  #
  # ==== SMTP server at example.com using PLAIN authentication
  #
  #  email_delivery:
  #    delivery_method: :smtp
  #    smtp_settings:
  #      address: "example.com"
  #      port: 25
  #      authentication: :plain
  #      domain: 'example.com'
  #      user_name: 'myaccount'
  #      password: 'password'
  #
  # ==== SMTP server at using TLS (GMail)
  # This might require some additional configuration. See the guides at:
  # http://www.redmine.org/projects/redmine/wiki/EmailConfiguration
  #
  #  email_delivery:
  #    delivery_method: :smtp
  #    smtp_settings:
  #      enable_starttls_auto: true
  #      address: "smtp.gmail.com"
  #      port: 587
  #      domain: "smtp.gmail.com" # 'your.domain.com' for GoogleApps
  #      authentication: :plain
  #      user_name: "your_email@gmail.com"
  #      password: "your_password"
  #
  # ==== Sendmail command
  #
  #  email_delivery:
  #    delivery_method: :sendmail

  # Absolute path to the directory where attachments are stored.
  # The default is the 'files' directory in your Redmine instance.
  # Your Redmine instance needs to have write permission on this
  # directory.
  # Examples:
  # attachments_storage_path: /var/redmine/files
  # attachments_storage_path: D:/redmine/files
  attachments_storage_path:

  # Configuration of the autologin cookie.
  # autologin_cookie_name: the name of the cookie (default: autologin)
  # autologin_cookie_path: the cookie path (default: /)
  # autologin_cookie_secure: true sets the cookie secure flag (default: false)
  autologin_cookie_name:
  autologin_cookie_path:
  autologin_cookie_secure:

  # Configuration of SCM executable command.
  #
  # Absolute path (e.g. /usr/local/bin/hg) or command name (e.g. hg.exe, bzr.exe)
  # On Windows + CRuby, *.cmd, *.bat (e.g. hg.cmd, bzr.bat) does not work.
  #
  # On Windows + JRuby 1.6.2, path which contains spaces does not work.
  # For example, "C:\Program Files\TortoiseHg\hg.exe".
  # If you want to this feature, you need to install to the path which does not contains spaces.
  # For example, "C:\TortoiseHg\hg.exe".
  #
  # Examples:
  # scm_subversion_command: svn                                       # (default: svn)
  # scm_mercurial_command:  C:\Program Files\TortoiseHg\hg.exe        # (default: hg)
  # scm_git_command:        /usr/local/bin/git                        # (default: git)
  # scm_cvs_command:        cvs                                       # (default: cvs)
  # scm_bazaar_command:     bzr.exe                                   # (default: bzr)
  # scm_darcs_command:      darcs-1.0.9-i386-linux                    # (default: darcs)
  #
  scm_subversion_command:
  scm_mercurial_command:
  scm_git_command:
  scm_cvs_command:
  scm_bazaar_command:
  scm_darcs_command:

  # SCM paths validation.
  #
  # You can configure a regular expression for each SCM that will be used to
  # validate the path of new repositories (eg. path entered by users with the
  # "Manage repositories" permission and path returned by reposman.rb).
  # The regexp will be wrapped with \A \z, so it must match the whole path.
  # And the regexp is case sensitive.
  #
  # You can match the project identifier by using %project% in the regexp.
  #
  # You can also set a custom hint message for each SCM that will be displayed
  # on the repository form instead of the default one.
  #
  # Examples:
  # scm_subversion_path_regexp: file:///svnpath/[a-z0-9_]+
  # scm_subversion_path_info: SVN URL (eg. file:///svnpath/foo)
  #
  # scm_git_path_regexp: /gitpath/%project%(\.[a-z0-9_])?/
  #
  scm_subversion_path_regexp:
  scm_mercurial_path_regexp:
  scm_git_path_regexp:
  scm_cvs_path_regexp:
  scm_bazaar_path_regexp:
  scm_darcs_path_regexp:
  scm_filesystem_path_regexp:

  # Absolute path to the SCM commands errors (stderr) log file.
  # The default is to log in the 'log' directory of your Redmine instance.
  # Example:
  # scm_stderr_log_file: /var/log/redmine_scm_stderr.log
  scm_stderr_log_file:

  # Key used to encrypt sensitive data in the database (SCM and LDAP passwords).
  # If you don't want to enable data encryption, just leave it blank.
  # WARNING: losing/changing this key will make encrypted data unreadable.
  #
  # If you want to encrypt existing passwords in your database:
  # * set the cipher key here in your configuration file
  # * encrypt data using 'rake db:encrypt RAILS_ENV=production'
  #
  # If you have encrypted data and want to change this key, you have to:
  # * decrypt data using 'rake db:decrypt RAILS_ENV=production' first
  # * change the cipher key here in your configuration file
  # * encrypt data using 'rake db:encrypt RAILS_ENV=production'
  database_cipher_key:

  # Set this to false to disable plugins' assets mirroring on startup.
  # You can use `rake redmine:plugins:assets` to manually mirror assets
  # to public/plugin_assets when you install/upgrade a Redmine plugin.
  #
  #mirror_plugins_assets_on_startup: false

  # Your secret key for verifying cookie session data integrity. If you
  # change this key, all old sessions will become invalid! Make sure the
  # secret is at least 30 characters and all random, no regular words or
  # you'll be exposed to dictionary attacks.
  #
  # If you have a load-balancing Redmine cluster, you have to use the
  # same secret token on each machine.
  #secret_token: 'change it to a long random string'

  # Requires users to re-enter their password for sensitive actions (editing
  # of account data, project memberships, application settings, user, group,
  # role, auth source management and project deletion). Disabled by default.
  # Timeout is set in minutes.
  #
  #sudo_mode: true
  #sudo_mode_timeout: 15

  # Absolute path (e.g. /usr/bin/convert, c:/im/convert.exe) to
  # the ImageMagick's `convert` binary. Used to generate attachment thumbnails.
  #imagemagick_convert_command:

  # Configuration of RMagcik font.
  #
  # Redmine uses RMagcik in order to export gantt png.
  # You don't need this setting if you don't install RMagcik.
  #
  # In CJK (Chinese, Japanese and Korean),
  # in order to show CJK characters correctly,
  # you need to set this configuration.
  #
  # Because there is no standard font across platforms in CJK,
  # you need to set a font installed in your server.
  #
  # This setting is not necessary in non CJK.
  #
  # Examples for Japanese:
  #   Windows:
  #     rmagick_font_path: C:\windows\fonts\msgothic.ttc
  #   Linux:
  #     rmagick_font_path: /usr/share/fonts/ipa-mincho/ipam.ttf
  #
  rmagick_font_path:

  # Maximum number of simultaneous AJAX uploads
  #max_concurrent_ajax_uploads: 2

  # Configure OpenIdAuthentication.store
  #
  # allowed values: :memory, :file, :memcache
  #openid_authentication_store: :memory

# specific configuration options for production environment
# that overrides the default ones
production:

# specific configuration options for development environment
# that overrides the default ones
development:
# Default setup is given for MySQL with ruby1.9.
# Examples for PostgreSQL, SQLite3 and SQL Server can be found at the end.
# Line indentation must be 2 spaces (no tabs).

production:
  adapter: mysql2
  database: redmine
  host: localhost
  username: root
  password: ""
  encoding: utf8

development:
  adapter: mysql2
  database: redmine_development
  host: localhost
  username: root
  password: ""
  encoding: utf8

# Warning: The database defined as "test" will be erased and
# re-generated from your development database when you run "rake".
# Do not set this db to the same as development or production.
test:
  adapter: mysql2
  database: redmine_test
  host: localhost
  username: root
  password: ""
  encoding: utf8

# PostgreSQL configuration example
#production:
#  adapter: postgresql
#  database: redmine
#  host: localhost
#  username: postgres
#  password: "postgres"

# SQLite3 configuration example
#production:
#  adapter: sqlite3
#  database: db/redmine.sqlite3

# SQL Server configuration example
#production:
#  adapter: sqlserver
#  database: redmine
#  host: localhost
#  username: jenkins
#  password: jenkins
# Default setup is given for MySQL with ruby1.9.
# Examples for PostgreSQL, SQLite3 and SQL Server can be found at the end.
# Line indentation must be 2 spaces (no tabs).

production:
  adapter: mysql2
  database: redmine
  host: localhost
  username: root
  password: ""
  encoding: utf8

development:
  adapter: mysql2
  database: redmine_development
  host: localhost
  username: root
  password: ""
  encoding: utf8

# Warning: The database defined as "test" will be erased and
# re-generated from your development database when you run "rake".
# Do not set this db to the same as development or production.
test:
  adapter: mysql2
  database: redmine_test
  host: localhost
  username: root
  password: ""
  encoding: utf8

# PostgreSQL configuration example
#production:
#  adapter: postgresql
#  database: redmine
#  host: localhost
#  username: postgres
#  password: "postgres"

# SQLite3 configuration example
#production:
#  adapter: sqlite3
#  database: db/redmine.sqlite3

# SQL Server configuration example
#production:
#  adapter: sqlserver
#  database: redmine
#  host: localhost
#  username: jenkins
#  password: jenkins
# Load the Rails application
require File.expand_path('../application', __FILE__)

# Make sure there's no plugin in vendor/plugin before starting
vendor_plugins_dir = File.join(Rails.root, "vendor", "plugins")
if Dir.glob(File.join(vendor_plugins_dir, "*")).any?
  $stderr.puts "Plugins in vendor/plugins (#{vendor_plugins_dir}) are no longer allowed. " +
    "Please, put your Redmine plugins in the `plugins` directory at the root of your " +
    "Redmine directory (#{File.join(Rails.root, "plugins")})"
  exit 1
end

# Initialize the Rails application
Rails.application.initialize!
# Redmine - project management software
# Copyright (C) 2006-2015  Jean-Philippe Lang
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

Rails.application.routes.draw do
  root :to => 'welcome#index', :as => 'home'

  match 'login', :to => 'account#login', :as => 'signin', :via => [:get, :post]
  match 'logout', :to => 'account#logout', :as => 'signout', :via => [:get, :post]
  match 'account/register', :to => 'account#register', :via => [:get, :post], :as => 'register'
  match 'account/lost_password', :to => 'account#lost_password', :via => [:get, :post], :as => 'lost_password'
  match 'account/activate', :to => 'account#activate', :via => :get
  get 'account/activation_email', :to => 'account#activation_email', :as => 'activation_email'

  match '/news/preview', :controller => 'previews', :action => 'news', :as => 'preview_news', :via => [:get, :post, :put, :patch]
  match '/issues/preview/new/:project_id', :to => 'previews#issue', :as => 'preview_new_issue', :via => [:get, :post, :put, :patch]
  match '/issues/preview/edit/:id', :to => 'previews#issue', :as => 'preview_edit_issue', :via => [:get, :post, :put, :patch]
  match '/issues/preview', :to => 'previews#issue', :as => 'preview_issue', :via => [:get, :post, :put, :patch]

  match 'projects/:id/wiki', :to => 'wikis#edit', :via => :post
  match 'projects/:id/wiki/destroy', :to => 'wikis#destroy', :via => [:get, :post]

  match 'boards/:board_id/topics/new', :to => 'messages#new', :via => [:get, :post], :as => 'new_board_message'
  get 'boards/:board_id/topics/:id', :to => 'messages#show', :as => 'board_message'
  match 'boards/:board_id/topics/quote/:id', :to => 'messages#quote', :via => [:get, :post]
  get 'boards/:board_id/topics/:id/edit', :to => 'messages#edit'

  post 'boards/:board_id/topics/preview', :to => 'messages#preview', :as => 'preview_board_message'
  post 'boards/:board_id/topics/:id/replies', :to => 'messages#reply'
  post 'boards/:board_id/topics/:id/edit', :to => 'messages#edit'
  post 'boards/:board_id/topics/:id/destroy', :to => 'messages#destroy'

  # Misc issue routes. TODO: move into resources
  match '/issues/auto_complete', :to => 'auto_completes#issues', :via => :get, :as => 'auto_complete_issues'
  match '/issues/context_menu', :to => 'context_menus#issues', :as => 'issues_context_menu', :via => [:get, :post]
  match '/issues/changes', :to => 'journals#index', :as => 'issue_changes', :via => :get
  match '/issues/:id/quoted', :to => 'journals#new', :id => /\d+/, :via => :post, :as => 'quoted_issue'

  match '/journals/diff/:id', :to => 'journals#diff', :id => /\d+/, :via => :get
  match '/journals/edit/:id', :to => 'journals#edit', :id => /\d+/, :via => [:get, :post]

  get '/projects/:project_id/issues/gantt', :to => 'gantts#show', :as => 'project_gantt'
  get '/issues/gantt', :to => 'gantts#show'

  get '/projects/:project_id/issues/calendar', :to => 'calendars#show', :as => 'project_calendar'
  get '/issues/calendar', :to => 'calendars#show'

  get 'projects/:id/issues/report', :to => 'reports#issue_report', :as => 'project_issues_report'
  get 'projects/:id/issues/report/:detail', :to => 'reports#issue_report_details', :as => 'project_issues_report_details'

  match 'my/account', :controller => 'my', :action => 'account', :via => [:get, :post]
  match 'my/account/destroy', :controller => 'my', :action => 'destroy', :via => [:get, :post]
  match 'my/page', :controller => 'my', :action => 'page', :via => :get
  match 'my', :controller => 'my', :action => 'index', :via => :get # Redirects to my/page
  match 'my/reset_rss_key', :controller => 'my', :action => 'reset_rss_key', :via => :post
  match 'my/reset_api_key', :controller => 'my', :action => 'reset_api_key', :via => :post
  match 'my/api_key', :controller => 'my', :action => 'show_api_key', :via => :get
  match 'my/password', :controller => 'my', :action => 'password', :via => [:get, :post]
  match 'my/page_layout', :controller => 'my', :action => 'page_layout', :via => :get
  match 'my/add_block', :controller => 'my', :action => 'add_block', :via => :post
  match 'my/remove_block', :controller => 'my', :action => 'remove_block', :via => :post
  match 'my/order_blocks', :controller => 'my', :action => 'order_blocks', :via => :post

  resources :users do
    resources :memberships, :controller => 'principal_memberships'
    resources :email_addresses, :only => [:index, :create, :update, :destroy]
  end

  post 'watchers/watch', :to => 'watchers#watch', :as => 'watch'
  delete 'watchers/watch', :to => 'watchers#unwatch'
  get 'watchers/new', :to => 'watchers#new'
  post 'watchers', :to => 'watchers#create'
  post 'watchers/append', :to => 'watchers#append'
  delete 'watchers', :to => 'watchers#destroy'
  get 'watchers/autocomplete_for_user', :to => 'watchers#autocomplete_for_user'
  # Specific routes for issue watchers API
  post 'issues/:object_id/watchers', :to => 'watchers#create', :object_type => 'issue'
  delete 'issues/:object_id/watchers/:user_id' => 'watchers#destroy', :object_type => 'issue'

  resources :projects do
    member do
      get 'settings(/:tab)', :action => 'settings', :as => 'settings'
      post 'modules'
      post 'archive'
      post 'unarchive'
      post 'close'
      post 'reopen'
      match 'copy', :via => [:get, :post]
    end

    shallow do
      resources :memberships, :controller => 'members', :only => [:index, :show, :new, :create, :update, :destroy] do
        collection do
          get 'autocomplete'
        end
      end
    end

    resource :enumerations, :controller => 'project_enumerations', :only => [:update, :destroy]

    get 'issues/:copy_from/copy', :to => 'issues#new', :as => 'copy_issue'
    resources :issues, :only => [:index, :new, :create]
    # Used when updating the form of a new issue
    post 'issues/new', :to => 'issues#new'

    resources :files, :only => [:index, :new, :create]

    resources :versions, :except => [:index, :show, :edit, :update, :destroy] do
      collection do
        put 'close_completed'
      end
    end
    get 'versions.:format', :to => 'versions#index'
    get 'roadmap', :to => 'versions#index', :format => false
    get 'versions', :to => 'versions#index'

    resources :news, :except => [:show, :edit, :update, :destroy]
    resources :time_entries, :controller => 'timelog', :except => [:show, :edit, :update, :destroy] do
      get 'report', :on => :collection
    end
    resources :queries, :only => [:new, :create]
    shallow do
      resources :issue_categories
    end
    resources :documents, :except => [:show, :edit, :update, :destroy]
    resources :boards
    shallow do
      resources :repositories, :except => [:index, :show] do
        member do
          match 'committers', :via => [:get, :post]
        end
      end
    end
  
    match 'wiki/index', :controller => 'wiki', :action => 'index', :via => :get
    resources :wiki, :except => [:index, :new, :create], :as => 'wiki_page' do
      member do
        get 'rename'
        post 'rename'
        get 'history'
        get 'diff'
        match 'preview', :via => [:post, :put, :patch]
        post 'protect'
        post 'add_attachment'
      end
      collection do
        get 'export'
        get 'date_index'
      end
    end
    match 'wiki', :controller => 'wiki', :action => 'show', :via => :get
    get 'wiki/:id/:version', :to => 'wiki#show', :constraints => {:version => /\d+/}
    delete 'wiki/:id/:version', :to => 'wiki#destroy_version'
    get 'wiki/:id/:version/annotate', :to => 'wiki#annotate'
    get 'wiki/:id/:version/diff', :to => 'wiki#diff'
  end

  resources :issues do
    member do
      # Used when updating the form of an existing issue
      patch 'edit', :to => 'issues#edit'
    end
    collection do
      match 'bulk_edit', :via => [:get, :post]
      post 'bulk_update'
    end
    resources :time_entries, :controller => 'timelog', :except => [:show, :edit, :update, :destroy] do
      collection do
        get 'report'
      end
    end
    shallow do
      resources :relations, :controller => 'issue_relations', :only => [:index, :show, :create, :destroy]
    end
  end
  # Used when updating the form of a new issue outside a project
  post '/issues/new', :to => 'issues#new'
  match '/issues', :controller => 'issues', :action => 'destroy', :via => :delete

  resources :queries, :except => [:show]

  resources :news, :only => [:index, :show, :edit, :update, :destroy]
  match '/news/:id/comments', :to => 'comments#create', :via => :post
  match '/news/:id/comments/:comment_id', :to => 'comments#destroy', :via => :delete

  resources :versions, :only => [:show, :edit, :update, :destroy] do
    post 'status_by', :on => :member
  end

  resources :documents, :only => [:show, :edit, :update, :destroy] do
    post 'add_attachment', :on => :member
  end

  match '/time_entries/context_menu', :to => 'context_menus#time_entries', :as => :time_entries_context_menu, :via => [:get, :post]

  resources :time_entries, :controller => 'timelog', :except => :destroy do
    collection do
      get 'report'
      get 'bulk_edit'
      post 'bulk_update'
    end
  end
  match '/time_entries/:id', :to => 'timelog#destroy', :via => :delete, :id => /\d+/
  # TODO: delete /time_entries for bulk deletion
  match '/time_entries/destroy', :to => 'timelog#destroy', :via => :delete
  # Used to update the new time entry form
  post '/time_entries/new', :to => 'timelog#new'

  get 'projects/:id/activity', :to => 'activities#index', :as => :project_activity
  get 'activity', :to => 'activities#index'

  # repositories routes
  get 'projects/:id/repository/:repository_id/statistics', :to => 'repositories#stats'
  get 'projects/:id/repository/:repository_id/graph', :to => 'repositories#graph'

  get 'projects/:id/repository/:repository_id/changes(/*path)',
      :to => 'repositories#changes',
      :format => false

  get 'projects/:id/repository/:repository_id/revisions/:rev', :to => 'repositories#revision'
  get 'projects/:id/repository/:repository_id/revision', :to => 'repositories#revision'
  post   'projects/:id/repository/:repository_id/revisions/:rev/issues', :to => 'repositories#add_related_issue'
  delete 'projects/:id/repository/:repository_id/revisions/:rev/issues/:issue_id', :to => 'repositories#remove_related_issue'
  get 'projects/:id/repository/:repository_id/revisions', :to => 'repositories#revisions'
  get 'projects/:id/repository/:repository_id/revisions/:rev/:action(/*path)',
      :controller => 'repositories',
      :format => false,
      :constraints => {
            :action => /(browse|show|entry|raw|annotate|diff)/,
            :rev    => /[a-z0-9\.\-_]+/
          }

  get 'projects/:id/repository/statistics', :to => 'repositories#stats'
  get 'projects/:id/repository/graph', :to => 'repositories#graph'

  get 'projects/:id/repository/changes(/*path)',
      :to => 'repositories#changes',
      :format => false

  get 'projects/:id/repository/revisions', :to => 'repositories#revisions'
  get 'projects/:id/repository/revisions/:rev', :to => 'repositories#revision'
  get 'projects/:id/repository/revision', :to => 'repositories#revision'
  post   'projects/:id/repository/revisions/:rev/issues', :to => 'repositories#add_related_issue'
  delete 'projects/:id/repository/revisions/:rev/issues/:issue_id', :to => 'repositories#remove_related_issue'
  get 'projects/:id/repository/revisions/:rev/:action(/*path)',
      :controller => 'repositories',
      :format => false,
      :constraints => {
            :action => /(browse|show|entry|raw|annotate|diff)/,
            :rev    => /[a-z0-9\.\-_]+/
          }
  get 'projects/:id/repository/:repository_id/:action(/*path)',
      :controller => 'repositories',
      :action => /(browse|show|entry|raw|changes|annotate|diff)/,
      :format => false
  get 'projects/:id/repository/:action(/*path)',
      :controller => 'repositories',
      :action => /(browse|show|entry|raw|changes|annotate|diff)/,
      :format => false

  get 'projects/:id/repository/:repository_id', :to => 'repositories#show', :path => nil
  get 'projects/:id/repository', :to => 'repositories#show', :path => nil

  # additional routes for having the file name at the end of url
  get 'attachments/:id/:filename', :to => 'attachments#show', :id => /\d+/, :filename => /.*/, :as => 'named_attachment'
  get 'attachments/download/:id/:filename', :to => 'attachments#download', :id => /\d+/, :filename => /.*/, :as => 'download_named_attachment'
  get 'attachments/download/:id', :to => 'attachments#download', :id => /\d+/
  get 'attachments/thumbnail/:id(/:size)', :to => 'attachments#thumbnail', :id => /\d+/, :size => /\d+/, :as => 'thumbnail'
  resources :attachments, :only => [:show, :destroy]
  get 'attachments/:object_type/:object_id/edit', :to => 'attachments#edit', :as => :object_attachments_edit
  patch 'attachments/:object_type/:object_id', :to => 'attachments#update', :as => :object_attachments

  resources :groups do
    resources :memberships, :controller => 'principal_memberships'
    member do
      get 'autocomplete_for_user'
    end
  end

  get 'groups/:id/users/new', :to => 'groups#new_users', :id => /\d+/, :as => 'new_group_users'
  post 'groups/:id/users', :to => 'groups#add_users', :id => /\d+/, :as => 'group_users'
  delete 'groups/:id/users/:user_id', :to => 'groups#remove_user', :id => /\d+/, :as => 'group_user'

  resources :trackers, :except => :show do
    collection do
      match 'fields', :via => [:get, :post]
    end
  end
  resources :issue_statuses, :except => :show do
    collection do
      post 'update_issue_done_ratio'
    end
  end
  resources :custom_fields, :except => :show
  resources :roles do
    collection do
      match 'permissions', :via => [:get, :post]
    end
  end
  resources :enumerations, :except => :show
  match 'enumerations/:type', :to => 'enumerations#index', :via => :get

  get 'projects/:id/search', :controller => 'search', :action => 'index'
  get 'search', :controller => 'search', :action => 'index'


  get  'mail_handler', :to => 'mail_handler#new'
  post 'mail_handler', :to => 'mail_handler#index'

  match 'admin', :controller => 'admin', :action => 'index', :via => :get
  match 'admin/projects', :controller => 'admin', :action => 'projects', :via => :get
  match 'admin/plugins', :controller => 'admin', :action => 'plugins', :via => :get
  match 'admin/info', :controller => 'admin', :action => 'info', :via => :get
  match 'admin/test_email', :controller => 'admin', :action => 'test_email', :via => :post
  match 'admin/default_configuration', :controller => 'admin', :action => 'default_configuration', :via => :post

  resources :auth_sources do
    member do
      get 'test_connection', :as => 'try_connection'
    end
    collection do
      get 'autocomplete_for_new_user'
    end
  end

  match 'workflows', :controller => 'workflows', :action => 'index', :via => :get
  match 'workflows/edit', :controller => 'workflows', :action => 'edit', :via => [:get, :post]
  match 'workflows/permissions', :controller => 'workflows', :action => 'permissions', :via => [:get, :post]
  match 'workflows/copy', :controller => 'workflows', :action => 'copy', :via => [:get, :post]
  match 'settings', :controller => 'settings', :action => 'index', :via => :get
  match 'settings/edit', :controller => 'settings', :action => 'edit', :via => [:get, :post]
  match 'settings/plugin/:id', :controller => 'settings', :action => 'plugin', :via => [:get, :post], :as => 'plugin_settings'

  match 'sys/projects', :to => 'sys#projects', :via => :get
  match 'sys/projects/:id/repository', :to => 'sys#create_project_repository', :via => :post
  match 'sys/fetch_changesets', :to => 'sys#fetch_changesets', :via => [:get, :post]

  match 'uploads', :to => 'attachments#upload', :via => :post

  get 'robots.txt', :to => 'welcome#robots'

  Dir.glob File.expand_path("plugins/*", Rails.root) do |plugin_dir|
    file = File.join(plugin_dir, "config/routes.rb")
    if File.exists?(file)
      begin
        instance_eval File.read(file)
      rescue Exception => e
        puts "An error occurred while loading the routes definition of #{File.basename(plugin_dir)} plugin (#{file}): #{e.message}."
        exit 1
      end
    end
  end
end
# Redmine - project management software
# Copyright (C) 2006-2015  Jean-Philippe Lang
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.


# DO NOT MODIFY THIS FILE !!!
# Settings can be defined through the application in Admin -> Settings

app_title:
  default: Redmine
app_subtitle:
  default: Project management
welcome_text:
  default:
login_required:
  default: 0
self_registration:
  default: '2'
lost_password:
  default: 1
unsubscribe:
  default: 1
password_min_length:
  format: int
  default: 8
# Maximum password age in days
password_max_age:
  format: int
  default: 0
# Maximum number of additional email addresses per user
max_additional_emails:
  format: int
  default: 5
# Maximum lifetime of user sessions in minutes
session_lifetime:
  format: int
  default: 0
# User session timeout in minutes
session_timeout:
  format: int
  default: 0
attachment_max_size:
  format: int
  default: 5120
issues_export_limit:
  format: int
  default: 500
activity_days_default:
  format: int
  default: 30
per_page_options:
  default: '25,50,100'
search_results_per_page:
  default: 10
mail_from:
  default: redmine@example.net
bcc_recipients:
  default: 1
plain_text_mail:
  default: 0
text_formatting:
  default: textile
cache_formatted_text:
  default: 0
wiki_compression:
  default: ""
default_language:
  default: en
force_default_language_for_anonymous:
  default: 0
force_default_language_for_loggedin:
  default: 0
host_name:
  default: localhost:3000
protocol:
  default: http
feeds_limit:
  format: int
  default: 15
gantt_items_limit:
  format: int
  default: 500
# Maximum size of files that can be displayed
# inline through the file viewer (in KB)
file_max_size_displayed:
  format: int
  default: 512
diff_max_lines_displayed:
  format: int
  default: 1500
enabled_scm:
  serialized: true
  default:
  - Subversion
  - Darcs
  - Mercurial
  - Cvs
  - Bazaar
  - Git
autofetch_changesets:
  default: 1
sys_api_enabled:
  default: 0
sys_api_key:
  default: ''
commit_cross_project_ref:
  default: 0
commit_ref_keywords:
  default: 'refs,references,IssueID'
commit_update_keywords:
  serialized: true
  default: []
commit_logtime_enabled:
  default: 0
commit_logtime_activity_id:
  format: int
  default: 0
# autologin duration in days
# 0 means autologin is disabled
autologin:
  format: int
  default: 0
# date format
date_format:
  default: ''
time_format:
  default: ''
user_format:
  default: :firstname_lastname
  format: symbol
cross_project_issue_relations:
  default: 0
# Enables subtasks to be in other projects
cross_project_subtasks:
  default: 'tree'
parent_issue_dates:
  default: 'derived'
parent_issue_priority:
  default: 'derived'
parent_issue_done_ratio:
  default: 'derived'
link_copied_issue:
  default: 'ask'
issue_group_assignment:
  default: 0
default_issue_start_date_to_creation_date:
  default: 1
notified_events:
  serialized: true
  default:
  - issue_added
  - issue_updated
mail_handler_body_delimiters:
  default: ''
mail_handler_excluded_filenames:
  default: ''
mail_handler_api_enabled:
  default: 0
mail_handler_api_key:
  default:
issue_list_default_columns:
  serialized: true
  default:
  - tracker
  - status
  - priority
  - subject
  - assigned_to
  - updated_on
display_subprojects_issues:
  default: 1
issue_done_ratio:
  default: 'issue_field'
default_projects_public:
  default: 1
default_projects_modules:
  serialized: true
  default:
  - issue_tracking
  - time_tracking
  - news
  - documents
  - files
  - wiki
  - repository
  - boards
  - calendar
  - gantt
default_projects_tracker_ids:
  serialized: true
  default: 
# Role given to a non-admin user who creates a project
new_project_user_role_id:
  format: int
  default: ''
sequential_project_identifiers:
  default: 0
# encodings used to convert repository files content to UTF-8
# multiple values accepted, comma separated
repositories_encodings:
  default: ''
# encoding used to convert commit logs to UTF-8
commit_logs_encoding:
  default: 'UTF-8'
repository_log_display_limit:
  format: int
  default: 100
ui_theme:
  default: ''
emails_footer:
  default: |-
    You have received this notification because you have either subscribed to it, or are involved in it.
  To change your notification preferences, please click here: https://bugs.dolphin-emu.org/my/account
gravatar_enabled:
  default: 0
openid:
  default: 0
gravatar_default:
  default: ''
start_of_week:
  default: ''
rest_api_enabled:
  default: 0
jsonp_enabled:
  default: 0
default_notification_option:
  default: 'only_my_events'
emails_header:
  default: ''
thumbnails_enabled:
  default: 0
thumbnails_size:
  format: int
  default: 100
non_working_week_days:
  serialized: true
  default:
  - '6'
  - '7'
