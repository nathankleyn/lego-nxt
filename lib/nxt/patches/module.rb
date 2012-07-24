class Module
  # Creates an invariant accessor that allows getting and setting from the same
  # endpoint. It will operate in getter mode if you don't pass any arguments
  # when calling it, otherwise it will work in setter mode. Useful when needing
  # to chain methods (you can't chain standard attr_writer methods because
  # of the `= something` part).
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
