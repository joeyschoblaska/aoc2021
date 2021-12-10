class Array
  def before(e)
    self[index(e) - 1]
  end

  def after(e)
    self[index(e) + 1]
  end
end
