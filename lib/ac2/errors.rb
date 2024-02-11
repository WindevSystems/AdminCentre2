class BadConfigException < StandardError
  def initialize(msg="AdminCentre configuration error")
    super
  end
end
