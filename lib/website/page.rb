module Website
  class Page

    attr_reader :params

    def initialize(params)
      if params.instance_of?(Website::Parameters)
        @params = params
      else
        raise "#{params} must be an instance of Website::Parameters"
      end
    end
  end
end