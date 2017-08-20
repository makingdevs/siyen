$(function() {
  Ember.Handlebars.registerBoundHelper('date', function(date) {
    return moment(date, "YYYY-MM-DD").format("DD/MMMM/YYYY");
  });

});
