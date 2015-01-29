$(document).ready(function(){


var portal = parent.fission;

var widget = function(){
  portal.socket.emit('test', {data:'test'});
  portal.socket.on('test', function(data){
    console.log(data);
  });
};

widget();



var cpu, mem;

$('.cpu').easyPieChart({
  animate: 2000,
  easing: 'easeOutBounce',
  barColor: 'green',
  lineWidth: 10,
  lineCap: 'butt',
  trackColor: '#efefef',
  rotate: 180,
  //scaleColor: false,
  onStep: function(from, to, percent) {
    return $(this.el).find('.value').text(Math.round(percent)).css({
      color: 'green'
    });
  }
});

$('.mem').easyPieChart({
  animate: 2000,
  easing: 'easeOutBounce',
  barColor: 'red',
  lineWidth: 10,
  lineCap: 'butt',
  trackColor: '#efefef',
  rotate: 180,
  //scaleColor: false,
  onStep: function(from, to, percent) {
    return $(this.el).find('.value').text(Math.round(percent)).css({
      color: 'red'
    });
  }
});

cpu = window.chart = $('.cpu').data('easyPieChart');

mem = window.chart = $('.mem').data('easyPieChart');
cpu.update(100);
mem.update(100);

portal.socket.on('graphs', function(data){
  console.log(data);
  cpu.update(Number(data.process.cpu));
  mem.update(Number(data.process.mem));
});









});
