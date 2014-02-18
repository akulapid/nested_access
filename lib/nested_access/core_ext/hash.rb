class Hash

  def nested_map key_lambda=nil, value_lambda=nil, &blk
    raise StandardError if block_given? and !(key_lambda.nil? and value_lambda.nil?)
    value_lambda = blk if block_given?
    value_lambda = lambda { |s| s } if value_lambda.nil?
    inject({}) do |hash, (key, value)|
      new_key = key_lambda ? key_lambda.call(key) : key
      hash[new_key] = case value
                        when Array, Hash
                          value.nested_map key_lambda, value_lambda
                        else
                          value_lambda.call value
                      end
      hash
    end
  end

end
