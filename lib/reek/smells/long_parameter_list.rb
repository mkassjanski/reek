$:.unshift File.dirname(__FILE__)

require 'reek/smells/smell_detector'

module Reek
  module Smells

    #
    # A Long Parameter List occurs when a method has more than one
    # or two parameters, or when a method yields more than one or
    # two objects to an associated block.
    #
    # Currently +LongParameterList+ reports any method with more
    # than +MAX_ALLOWED+ parameters.
    #
    class LongParameterList < SmellDetector

      @@max_params = 3
      
      #
      # Checks whether the given conditional statement relies on a control couple.
      # Any smells found are added to the +report+; returns true in that case,
      # and false otherwise.
      #
      def self.examine_context(ctx, report)
        num_params = ctx.parameters.length
        return false if num_params <= @@max_params
        report << LongParameterListReport.new(ctx, num_params)
      end

      def self.set_default_values(hash)      # :nodoc:
        update(:max_params, hash)
      end
    end

    class LongParameterListReport < SmellReport
      
      def initialize(context, num_params)
        super(context)
        @num_params = num_params
      end

      def warning
        "has #{@num_params} parameters"
      end
    end
  end
end
