require 'openobject'

# by default you cannot retrive unset values
#
  o = oo
  begin; o.foo; rescue NameError; p NameError; end
 
#=> NameError

# but you can set anything
#
  o = oo
  o.foo = 42
  p o.foo
 
#=> 42

# blocks can extend openobjects
#
  o = oo{ def bar() 42 end }
  p o.bar
 
#=> 42

# you can set a default value which will be returned for anything
# missing value
#
  o = oo{ default 42 }
  p o.bar
 
#=> 42

# and the default value itself can be someting block/proc-like
#
  n = 40
  o = oo{ default{ n += 2 } }
  p o.foo
 
#=> 42
