    config.generators do |g|
      g.stylesheets false
      g.template_engine :haml
      g.test_framework :shoulda
      g.fallbacks[ :shoulda ] = :test_unit 
    end
