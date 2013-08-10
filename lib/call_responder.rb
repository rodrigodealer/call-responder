class CallResponder < ActionController::Responder

    attr_reader :controller, :request, :format, :resource, :resources, :options
    def initialize(controller, resources, options={})
        super
        @controller = controller
        @request = @controller.request
        @format = @controller.formats.first
        @formats = [ :report ]
    end

    def to_format
        to_pdf if @format == 'pdf'
        super
    end

    def to_pdf
      stream = RestClient.post("http://198.199.91.129:9292/generate", 
        { 
          :file => controller.render_to_string(:formats => @formats) 
        }
      )

      controller.send_data( stream, :filename => @request.fullpath.gsub("/","") )
    end
end
