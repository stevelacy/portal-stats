'use strict';

var fission = parent.fission;


var simple = function() {
  console.log(fission);
  fission.socket.emit('test');
};



simple();
