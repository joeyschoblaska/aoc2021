class String
  def big?
    self !~ /[a-z]/
  end

  def small?
    self !~ /[A-Z]/
  end
end
