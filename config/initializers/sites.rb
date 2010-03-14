require 'pathname'

ActiveSupport::Dependencies.load_once_paths << (Pathname.new(__FILE__).expand_path.parent.parent.parent + "app/models").to_s
Site.register Site.new("BigCo", "bigco", "http://localhost:9999/bigco")
