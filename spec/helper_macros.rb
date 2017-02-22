module HelperMacros
  def json_resp
    ActiveSupport::JSON.decode(@response.body)
  end
end
