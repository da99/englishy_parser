Obsolete:
================
This project has been replaced by: [englishy](https://github.com/da99/englishy)

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

      


Installation
------------

    npm install englishy_parser

Usage
------

    var ep = require("englishy_parser");
    var parsed = new ep.Englishy(str);
    parsed.lines; 
    // => [ ... ]


Run Tests
---------

    git clone git@github.com:da99/englishy_parser.git
    cd englishy_parser
    
    sudo npm link
    npm link englishy_parser
    npm install

    sudo npm install -g mocha
    mocha  --watch --compilers coffee:coffee-script 

Know of a better way?
-----------------------------

If you know of existing software that makes the above redundant,
please tell me.

