# coding: utf-8


module JYRon

module CLI

  module Exiter

    EXIT_MAP= {

       # context execution
       :not_root => {:message => "This operation need to be run as root (use sudo or rvmsudo)", :code => 10},
       :options_incompatibility => {:message => "Options incompatibility", :code => 40},
       :option_needed => {:message => "Option requiered", :code => 40},

       # config
       :specific_config_required => {:message => "Specific configuration required", :code => 30},
       :configuration_error => {:message => "Configuration Error", :code => 50},


       # global
       :quiet_exit => {:code => 0},
       :error_exit => {:code => 99, :message => "Operation failure"},

       # events
       :interrupt => {:message => "Operation interrupted", :code => 33},

       # request
       :not_found => {:message => "Object not found", :code => 44},
       :already_exist => {:message => "Object already exist", :code => 48},

       # daemon
       :status_ok => {:message => "Status OK", :code => 0},
       :status_ko => {:message => "Status KO", :code => 31}

    }

    # exiter wrapper
    # @param [Hash] options
    # @option options [Symbol] :case an exit case
    # @option options [String] :more a complementary string to display
    def cli_exit(options = {})

      mess = ""
      mess = EXIT_MAP[options[:case]][:message] if EXIT_MAP[options[:case]].include? :message
      mess << " : " unless mess.empty? or not options[:more]
      mess << "#{options[:more]}" if options[:more]
      if  EXIT_MAP[options[:case]][:code] == 0 then
        puts mess unless mess.empty?
        exit 0
      else
        puts "FATAL : #{mess}" unless mess.empty?
        exit EXIT_MAP[options[:case]][:code]
      end
    end



  end
end
