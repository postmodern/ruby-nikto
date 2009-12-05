require 'nikto/task'

require 'rprogram/program'

module Nikto
  class Program < RProgram::Program

    name_program 'nikto'
    alias_program 'nikto.pl'

    #
    # Perform a Nikto scan using the given _options_ and _block_.
    # If a _block_ is given, it will be passed a newly created
    # Nikto Task object.
    #
    def self.scan(options={},&block)
      self.find.scan(options,&block)
    end

    #
    # Perform a Nikto scan using the given _options_ and _block_.
    # If a _block_ is given, it will be passed a newly created
    # Nikto Task object.
    #
    def scan(options={},&block)
      run_task(Task.new(options,&block))
    end

  end
end
