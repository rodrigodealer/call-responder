class CallResponder < ActionController::Responder

    attr_reader :controller, :request, :format, :resource, :resources, :options
    
    RESPONDER_FILE = "config/responder.yml"
    
    def initialize(controller, resources, options={})
        super
        @controller = controller
        @request = @controller.request
        @format = @controller.formats.first
        @formats = [ :report ]
        raise LoadError.new("You must have the file #{RESPONDER_FILE} with 'url: URL' string") unless File.exists?(RESPONDER_FILE)
        @config = YAML::load(File.open(RESPONDER_FILE))
    end

    def to_format
        to_pdf if @format == 'pdf'
        super
    end

    def to_pdf
      stream = RestClient.post(@config["url"], 
        { 
          :file => controller.render_to_string(:formats => @formats) 
        }
      )

      controller.send_data( stream, :filename => @request.fullpath.gsub("/","") )
    end
end
