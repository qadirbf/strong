# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
StrongSystem::Application.initialize!
$CLIENT_EXPIRE_MINUTES = 60
require 'class_ext'
require 'file_manager'
require 'sql_logic'
