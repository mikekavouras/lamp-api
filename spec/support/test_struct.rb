class TestStruct < OpenStruct
  def responds_to?(symbol, include_private = false)
    true
  end

  def as_json(options = nil)
    @table.as_json(options)
  end

  def attributes
    self
  end
end
