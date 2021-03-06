require 'olelo/extensions'

describe 'String extensions' do
  before { String.root_path = 'root' }
  after { String.root_path = nil }

  it 'should have unindent' do
    %{a
      b
      c}.unindent.should.equal "a\nb\nc"
  end

  it 'should have #begins_with?' do
    '123456789'.begins_with?('12').should.equal true
    '123456789'.begins_with?('23').should.not.equal true
  end

  it 'should have #ends_with?' do
    '123456789'.ends_with?('89').should.equal true
    '123456789'.ends_with?('98').should.not.equal true
  end

  it 'should have #cleanpath' do
    '/'.cleanpath.should.equal ''
    '/a/b/c/../'.cleanpath.should.equal 'a/b'
    '/a/./b/../c/../d/./'.cleanpath.should.equal 'a/d'
    '1///2'.cleanpath.should.equal '1/2'
    'root'.cleanpath.should.equal ''
    '///root/1/../2'.cleanpath.should.equal '2'
  end

  it 'should have #urlpath' do
    '/'.urlpath.should.equal '/'
    '/a/b/c/../'.urlpath.should.equal '/a/b'
    '/a/./b/../c/../d/./'.urlpath.should.equal '/a/d'
    '1///2'.urlpath.should.equal '/1/2'
    'root'.urlpath.should.equal '/'
    '///root/1/../2'.urlpath.should.equal '/2'
  end

  it 'should have #root_path' do
    'root'.cleanpath.should.equal ''
    String.root_path = 'test'
    'test'.cleanpath.should.equal ''
    'root'.cleanpath.should.equal 'root'
  end

  it 'should have #truncate' do
    'Annabel Lee It was many and many a year ago'.truncate(11).should.equal 'Annabel Lee...'
    'In a kingdom by the sea'.truncate(39).should.equal 'In a kingdom by the sea'
  end

  it 'should have #/' do
    (''/'').should.equal ''
    ('//a/b///'/'').should.equal 'a/b'
    ('a'/'x'/'..'/'b'/'c'/'.').should.equal 'a/b/c'
  end
end
