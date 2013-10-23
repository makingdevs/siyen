<!DOCTYPE html>
<html>
  <head>
    <sec:ifLoggedIn>
      <meta name="layout" content="twitterBootstrapSiyenLogin"/>
      <r:require modules="vertx" />
      <r:script type="text/javascript">
        $(function() {
          var eventBus = null;
          if (!eventBus) {
            eventBus = new vertx.EventBus('http://localhost:9090/eventbus');
          }
          eventBus.onopen = function() {
            console.log("Event Bus connected");
            eventBus.registerHandler('cursoProgramado.save', function(message) {

              var section = $('section')
              $('<h3>').text(message).appendTo(section)

            });
          }
        });
      </r:script>
    </sec:ifLoggedIn>
    <sec:ifNotLoggedIn>
      <meta name="layout" content="twitterBootstrapSiyenLogout"/>
    </sec:ifNotLoggedIn>
    <title>Instituto de Educación Náutica y Portuaria</title>
  </head>

  <body>
  </body>

</html>