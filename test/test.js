var assert = require('assert')
  , ep     = require('Englishy_Parser');

describe('Parsing sentences', function(){
  it('multiple sentences', function(){
    var str = "\nThis is a line.\nThis is another line.\n";
    var parser = new ep.Englishy(str);
    var lines  = parser.lines;
    var target = [ 
      [ "This is a line.", null],
      [ "This is another line.", null],
    ];
    assert.equal( lines.toString(), target.toString() );
  })
});
