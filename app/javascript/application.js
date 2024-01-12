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

document.addEventListener("turbo:load", function() {
    const recentEntities = document.getElementById('recent-entities');
    const ancientEntities = document.getElementById('ancient-entities');
    const toggleButtons = document.getElementById('toggle-buttons');

    toggleButtons.addEventListener('click', function(event) {
      if (event.target.id === 'recent-toggle') {
        recentEntities.style.display = 'block';
        ancientEntities.style.display = 'none';
        document.getElementById('recent-toggle').classList.add('short-line');
        document.getElementById('ancient-toggle').classList.remove('short-line');
      } else if (event.target.id === 'ancient-toggle') {
        recentEntities.style.display = 'none';
        ancientEntities.style.display = 'block';
        document.getElementById('recent-toggle').classList.remove('short-line');
        document.getElementById('ancient-toggle').classList.add('short-line');
      }
    });
  });

