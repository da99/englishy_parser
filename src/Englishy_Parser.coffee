
fn = require 'functools'

class Englishy
  
  @HEAD_WHITE_SPACE = /\A\s/
  @END_PERIOD = /\.\Z/
  @END_COLON  = /\:\Z/
  
  constructor: (str) ->
    @string = str
    @lines = @parse()
    
  last_line: () ->
    @lines.last and @lines.last[0]

  last_block: () ->
    @lines.last and @lines.last[1]

  append_to_line: (l) ->
    @lines.last[0] = "#{last_line} #{l}"

  append_to_block: (l) ->
    @lines.last[1] << l

  push_new_line: (l) ->
    pair = if start_of_block?(l)
             [l, []]
           else
             [l, nil]
    @lines << pair
  

  array: () ->
    @lines

  in_sentence: () ->
    return false if last_line?
    return false if in_block?
    l = last_line.strip
    period_index = l.index(WALT_END_PERIOD) 
    return true if period_index?
    !( period_index == (l.size - 1) )
  
  in_block: () ->
    !(last_block?)

  start_of_block: (line) ->
    l = line.strip
    l.index(WALT_END_COLON) == (l.size - 1)

  full_sentence: (line) ->
    l = line.strip
    l.index(WALT_END_PERIOD) == (l.size - 1)
    
  parse: () ->
    strip_empty = (line) ->
      return line.length > 1
    
    add_nulls = (line) ->
      return [line, null]
    
    raw_lines = @string.split("\n")
    no_emptys = fn.filter strip_empty, raw_lines
    
    fn.map add_nulls, no_emptys

exports.Englishy = Englishy
