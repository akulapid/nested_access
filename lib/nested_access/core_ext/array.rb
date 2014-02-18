class Array

  def nested_map key_lambda=nil, value_lambda=nil, &blk
    raise StandardError if block_given? and !(key_lambda.nil? and value_lambda.nil?)
    value_lambda = blk if block_given?
    inject([]) do |array, s|
      case s
        when Array, Hash
          array << s.nested_map(key_lambda, value_lambda)
        else
          array << value_lambda.call(s)
      end
      array
    end
  end

end
