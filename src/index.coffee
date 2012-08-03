events = require 'events'
emitter = new events.EventEmitter()

class Englishy
  
  @HEAD_WHITE_SPACE = /^\s/
  @END_PERIOD = /\.$/
  @END_COLON  = /\:$/
  
  constructor: (str) ->
    @string = str.replace(/\t/, "  ").replace(/\r/, "")
    @lines = parse()
    
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
    return false if last_line?()
    return false if in_block?()
    l = last_line.strip
    period_index = l.index(@END_PERIOD) 
    return true if period_index?()
    !( period_index == (l.size - 1) )
  
  in_block: () ->
    !(last_block?())

  start_of_block: (line) ->
    l = line.strip
    l.index(@END_COLON) == (l.size - 1)

  full_sentence: (line) ->
    l = line.strip
    l.index(@END_PERIOD) == (l.size - 1)
    
  reset_indententation: (str) ->
    return "" if strip(str) is ""
    lines = strip_beginning_empty_lines(str).split("\n")
    indent_meta= @HEAD_WHITE_SPACE.exec(lines[0])
    if !indent_meta
      return lines.join("\n")
    indent = indent_meta[0]
    final = (l.replace(indent, "") for l in lines)
    final.join("\n")
    
  strip_beginning_empty_lines: (str) ->
    return "" if strip(str) is ""
    lines = str.split("\n")
    lines.shift() while lines[0] and ( strip(lines[0]) is "" )
    lines.join("\n")

  strip: (str) ->
    return "" if str.replace(/^\s+|\s+$/g, '') is ""
    
  strip_empty: (line) ->
    return line.length > 1
  
  parse: () ->
    
    raw_lines = remove_indentation(@string).split("\n")
    [l, null] for l in raw_lines


exports.Englishy = Englishy




