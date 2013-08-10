class CallResponder < ActionController::Responder

    attr_reader :controller, :request, :format, :resource, :resources, :options
    def initialize(controller, resources, options={})
        super
        @controller = controller
        @request = @controller.request
        @format = @controller.formats.first
        @formats = [ :report ]
        @config = YAML::load(File.open('config/responder.yml'))
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
