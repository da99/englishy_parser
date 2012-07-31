
Englishy_Parser
================

A npm module providing simple line and blockquote parsing (w/o paragraphs):

    This is a line.
    This is a 2-line
      line.
    This is a line with a block:
      
      I am a block.
      I am also part of a block.

    # -->
    [ 
      [ "This is a line", nil],
      [ "This is a 2-line line", nil],
      [ "This is a line with a block", "  I am a block.\n  I am also part of a block."]
    ]

The following raises `Englishy\_Parser::Error`:

          Bad indentation.
          
    # -----------------------
    
    Multi-line with an
      
      an empty line in between.

    # -----------------------
    
    A block without:
      surrounding blank lines.
      


Installation
------------

    npm install Englishy_Parser

Usage
------

    var ep = require("Englishy_Parser");
    
    ep.parse(my_str)


Run Tests
---------

    git clone git@github.com:da99/Walt.git
    cd Englishy_Parser
    mocha

Know of a better way?
-----------------------------

If you know of existing software that makes the above redundant,
please tell me.

