import "@hotwired/turbo-rails"
/* import "rails-ujs" */
import "controllers"

function headerHeightControl() {
    var headerHeight = document.querySelector('header').offsetHeight;
    headerHeight += 24;
    document.getElementById('hero').style.marginTop = headerHeight + 'px';
}

document.addEventListener("turbo:load", headerHeightControl);

window.addEventListener("resize", function() {
    headerHeightControl();
});

document.addEventListener('DOMContentLoaded', function() {
    const recentEntities = document.getElementById('recent-entities');
    const ancientEntities = document.getElementById('ancient-entities');
    const allEntities = document.getElementById('all-entities');
    const toggleButtons = document.getElementById('toggle-buttons');

    toggleButtons.addEventListener('click', function(event) {
      if (event.target.id === 'recent-toggle') {
        recentEntities.style.display = 'block';
        ancientEntities.style.display = 'none';
        allEntities.style.display = 'none';
        document.getElementById('recent-toggle').style.textDecoration = 'underline';
        document.getElementById('ancient-toggle').style.textDecoration = 'none';
        document.getElementById('all-toggle').style.textDecoration = 'none';
      } else if (event.target.id === 'ancient-toggle') {
        recentEntities.style.display = 'none';
        ancientEntities.style.display = 'block';
        allEntities.style.display = 'none';
        document.getElementById('recent-toggle').style.textDecoration = 'none';
        document.getElementById('ancient-toggle').style.textDecoration = 'underline';
        document.getElementById('all-toggle').style.textDecoration = 'none';
      } else if (event.target.id === 'all-toggle') {
        recentEntities.style.display = 'none';
        ancientEntities.style.display = 'none';
        allEntities.style.display = 'block';
        document.getElementById('recent-toggle').style.textDecoration = 'none';
        document.getElementById('ancient-toggle').style.textDecoration = 'none';
        document.getElementById('all-toggle').style.textDecoration = 'underline';
      }
    });
  });

