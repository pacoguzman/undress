unless Object.new.respond_to?(:tap)

  class Object #:nodoc:
    def tap
      yield self
      self
    end
  end

end