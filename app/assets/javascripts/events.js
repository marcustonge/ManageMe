/*
  JavaScript for the events_landing page, allows the nav bar to show/hide panels.
  It listens for the turbolinks 'load' trigger then toggles the 'active' state
  of the tabs, so currently active tabs will be made inactive and inactive tabs
  will become active (as there are only 2 tabs this will not cause any conflictions with
  multiple panels being displayed).
*/
document.addEventListener("turbolinks:load", () => {
    const tabElements = document.querySelectorAll('#nav-tab .tab');
    if(tabElements != null) {
        tabElements.forEach(function(tab) {
          tab.addEventListener('click', (event) => {
            onTabClick(event);
          });
        });
      }
    
    //toggles active and inactive panels
    function onTabClick(event) {
      const activeTabs = document.querySelectorAll('.active');
  
      activeTabs.forEach(function(tab) {
        tab.classList.toggle('active');
      });
      event.preventDefault();
  
      event.target.parentElement.classList.add('active');

      //shows and hides tab panels
      var tabPanel = document.getElementById(event.target.href.split("#")[1]);
      tabPanel.classList.toggle('active');
    }
  });