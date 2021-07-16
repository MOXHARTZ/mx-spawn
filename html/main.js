$(function() {
     window.addEventListener('message', function(event) {
          
          if (event.data.type == 'open') {
               $('body').fadeIn(600);
          }
     });
     $('.spawnlocation').click(function() {
          var self = $(this);
          var offset = self.offset();
          $('#information-container').css({
               left: offset.left + 4,
               top: offset.top - 35
          });
          $('#information-container').fadeIn(400);
          $('#name').html(self.data('name').charAt(0).toUpperCase() + self.data('name').slice(1))
     });
     $('#information-container').click(function() {
          $.post('https://mx-spawn/Spawn', JSON.stringify({
               spawnLoc: $('#name').html()
          }));
          $('body').fadeOut(400);
     });
     $('#lastlocation-container').click(function() {
          $.post('https://mx-spawn/Spawn', JSON.stringify({
               spawnLoc: 'lastlocation'
          }));
          $('body').fadeOut(400);
     });
})