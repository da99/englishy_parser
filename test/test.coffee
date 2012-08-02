assert = require 'assert'
ep     = require 'Englishy_Parser'

describe 'Parsing sentences', () ->
  it 'multiple sentences', () ->
    str = "\nThis is a line.\nThis is another line.\n"
    parser = new ep.Englishy(str)
    lines  = parser.lines
    target = [ 
      [ "This is a line.", null],
      [ "This is another line.", null],
    ]
    assert.equal lines.toString(), target.toString() 
