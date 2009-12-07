require 'openobject'

oo = openobject :foo => 42

oo.bar = 'forty-two' 

oo.extend do
  fattr :foobar => 42.0

  def barfoo 
    [ foo, bar, foobar ] 
  end
end

p oo.foobar
p oo.barfoo
