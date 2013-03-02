require_relative './db_credentials'

ActiveRecord::Base.logger = Padrino.logger
ActiveRecord::Base.mass_assignment_sanitizer = :strict
ActiveRecord::Base.auto_explain_threshold_in_seconds = 0.5
ActiveRecord::Base.include_root_in_json = false
ActiveRecord::Base.store_full_sti_class = true
ActiveSupport.use_standard_json_time_format = true
ActiveSupport.escape_html_entities_in_json = false
ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations[Padrino.env])
