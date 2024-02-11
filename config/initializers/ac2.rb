# Fail to start if HUB_API_TOKEN is not set
if ENV["HUB_API_TOKEN"] == "ChangeMe12345"
  require 'ac2/errors'
  raise BadConfigException, "Config error: HUB_API_TOKEN set to default value, change it to a secure value."
end
