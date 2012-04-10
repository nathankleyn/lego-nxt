class Module
  def attr_combined_accessor(sym, default = nil)
    define_method(sym) do |*args|
      if args.empty?
        instance_var = :"@#{sym}"
        if (value = self.instance_variable_get(instance_var))
          value
        else
          self.instance_variable_set(instance_var, default)
          default
        end
      else
        send(:"#{sym}=", *args)
      end
    end
  end
end
