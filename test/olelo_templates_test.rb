require 'olelo/fs'
require 'olelo/templates'
require 'haml'

class Bacon::Context
  include Olelo::Templates
end

describe 'Olelo::Templates' do
  before do
    Olelo::Templates.enable_caching
    Olelo::Templates.make_fs = proc { Olelo::InlineFS.new(__FILE__) }
  end

  after do
    Olelo::Templates.cache.clear
  end

  it 'should have #render' do
    render(:test, :locals => {:text => 'Hello, World!'}).should.equal "<h1>Hello, World!</h1>\n"
    Olelo::Templates.cache.size.should.equal 1
  end

  it 'should support haml options' do
    render(:test, :locals => {:text => '< bad characters >'}).should.equal "<h1>< bad characters ></h1>\n"
    render(:test, :escape_html => true, :locals => {:text => '< bad characters >'}).should.equal "<h1>&lt; bad characters &gt;</h1>\n"
  end
end

__END__

@@ test.haml  
%h1= text

