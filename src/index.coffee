events = require 'events'
emitter = new events.EventEmitter()

class Englishy
  
  constructor: (str) ->
    @HEAD_WHITE_SPACE = /^\s/
    @END_PERIOD = /\.$/
    @END_COLON  = /\:$/
    
    @string = str.replace(/\t/, "  ").replace(/\r/, "")
    @lines = []
    @error = null
    @parse()

  record_error: (msg) ->
    @lines = new Error(msg)
    @error = @lines
    
  last_error: () ->
    @error

  last_line: () ->
    @lines.last and @lines.last[0]

  last_block: () ->
    @lines.last and @lines.last[1]

  append_to_line: (l) ->
    @lines.last[0] = "#{@last_line()} #{l}"

  append_to_block: (l) ->
    @lines.last[1] << l

  push_new_line: (l) ->
    pair = if @start_of_block(l)
             [l, []]
           else
             [l, null]
    @lines.push pair
  

  array: () ->
    @lines

  in_sentence: () ->
    return false if @last_line()
    return false if @in_block()
    l = @last_line().strip
    period_index = l.index(@END_PERIOD) 
    return true if period_index
    !( period_index == (l.size - 1) )
  
  in_block: () ->
    !(@last_block())

  start_of_block: (line) ->
    @END_COLON.test @strip(line)

  full_sentence: (line) ->
    @END_PERIOD.test @strip(line)
    
  remove_indentation: (str) ->
    return "" if @strip(str) is ""
    lines = @strip_beginning_empty_lines(str).split("\n")
    indent_meta= @HEAD_WHITE_SPACE.exec(lines[0])
    if !indent_meta
      return lines.join("\n")
    indent = indent_meta[0]
    final = (l.replace(indent, "") for l in lines)
    final.join("\n")
    
  strip_beginning_empty_lines: (str) ->
    return "" if @strip(str) is ""
    lines = str.split("\n")
    lines.shift() while lines[0] and ( @strip(lines[0]) is "" )
    lines.join("\n")

  strip: (str) ->
    str.replace(/^\s+|\s+$/g, '')
    
  is_empty: (str) ->
    return( @strip(str).length is 0 )

  strip_empty: (line) ->
    return line.length > 1
  
  _process_line: (raw_l) ->
    l = @strip(raw_l)
    return null if @is_empty(l) and @in_block()
    begins_with_whitespace = @HEAD_WHITE_SPACE.test(l)
    
    if @in_block() and (begins_with_whitespace or @is_empty(l))
      @append_to_block l
      return l
    
    if !@in_sentence() and ( @start_of_block(l) or @full_sentence(l) )
      @push_new_line l
      return l
    
    # Are we continuing a previous sentence?
    if @in_sentence()

      # Error check: Start of block not allowed after incomplete sentence.
      if @start_of_block?(l)
        return @record_error("Incomplete sentence before block: #{@last_line()}")
        

      return @append_to_line(line)
      

    if !@in_block() and !@full_sentence(l)
      return @push_new_line( line )

    @record_error("Unknown fragment: #{line}")

  parse: () ->
    
    raw_lines = @remove_indentation(@string).split("\n")
    @_process_line(raw_lines.shift()) while (@error is null) and raw_lines.length > 0
    @lines

exports.Englishy = Englishy




