module Canard

  class << self
    # A string specifying the location that should be searched for ability
    # definitions. By default, Canard will attempt to load abilities from
    # Rails.root + /app/abilities/.
    attr_accessor :abilities_path
    
    def ability_definitions
      @ability_definitions ||= {}
    end
    
    def abilities_for(role, &block)
      ability_definitions[role] = block
    end
    
  end

  def self.find_abilities #:nodoc:
    
    absolute_abilities_path = File.expand_path(abilities_path)

    if File.directory? absolute_abilities_path
      Dir[File.join(absolute_abilities_path, '**', '*.rb')].sort.each do |file|
        self.class_eval File.read(file)
      end
    end

  end
  
end