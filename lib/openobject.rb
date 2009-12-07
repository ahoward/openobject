require 'fattr'

class OpenObject
  Version = '1.0.0' unless defined?(OpenObject::Version)
  def OpenObject.version() OpenObject::Version end

# setup a super blank slate
#
  alias_method "__inspect__", "inspect"
  alias_method "__to_s__", "to_s"
  alias_method "__instance_eval__", "instance_eval"

    instance_methods.each{|m| undef_method m unless m[%r/__/]}

  alias_method "instance_eval", "__instance_eval__"
  alias_method "inspect", "__inspect__"
  alias_method "to_s", "__to_s__"

# method missing is contrcuted to raise an error if a property is read that
# was never set
#
  def method_missing(m, *a, &b)
    if(a.empty? and b.nil?)
      return((
        if defined?(@default)
          value = @default.respond_to?(:call) ? @default.call(m, *a) : @default
          __fattr__(m => value)
          value
        else
          super
        end
      ))
    end
    m = m.to_s
    setter = m.delete!('=') || a.first || b
    if setter
      if a.empty?
        __fattr__(m, &b)
      else
        __fattr__(m => a.shift)
      end
    else
      nil
    end
  end

# the default method can be used to force missing attribute calls to return a
# value -
#
  def default(*value, &block)
    @default = (( value.empty? ? block : value.first ))
  end

# configure is used to set key/val pairs via a hash AND/OR to to evaluate code
# in the instance
#
  def configure(kvs = {}, &b)
    kvs.each{|k,v| __fattr__(k => v)}
    __instance_eval__(&b) if b
  end
  alias_method "initialize", "configure"
  alias_method "eval", "configure"

# return the singleton_class or evaluate code inside of it
#
  def __singleton_class__(&b)
    sc =
      class << self
        self
      end
    b ? sc.module_eval(&b) : sc
  end
  alias_method "singleton_class", "__singleton_class__"

# override extend to to the 'normal' thang or extend the instance via a block
# of code - evaluated in the singleton class
#
  def extend(*a, &b)
    if b
      __singleton_class__(&b)
      self
    else
      super
    end
  end
  alias_method "extending", "extend"

# pollute the namespace a little...
#
  def fattrs(*a, &b)
    __fattrs__(*a, &b)
  end
  alias_method "fattr", "fattrs"

  def to_hash
    __fattrs__.inject(Hash.new){|h,a| h.update(a => __send__(a))}
  end
  alias_method "to_h", "to_hash"

  def respond_to?(*a, &b)
    true
  end
end

Openobject = OpenObject

class Object
  def Open *a, &b
    OpenObject.new(*a, &b)
  end

  def openobject(*a, &b)
    OpenObject.new(*a, &b)
  end

  def oo *a, &b
    OpenObject.new(*a, &b)
  end
end
