
fn = require 'functools'

class Englishy
  constructor: (str) ->
    @string = str
    @lines = @parse()
    
  parse: () ->
    strip_empty = (line) ->
      return line.length > 1
    
    add_nulls = (line) ->
      return [line, null]
    
    raw_lines = @string.split("\n")
    no_emptys = fn.filter strip_empty, raw_lines
    
    fn.map add_nulls, no_emptys

exports.Englishy = Englishy
