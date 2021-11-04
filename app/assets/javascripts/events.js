document.addEventListener("turbolinks:load", () => {
    const tabElements = document.querySelectorAll('#nav-tab .tab');
    if(tabElements != null) {
        tabElements.forEach(function(tab) {
          tab.addEventListener('click', (event) => {
            onTabClick(event);
          });
        });
      }
    
    function onTabClick(event) {
      const activeTabs = document.querySelectorAll('.active');
  
      activeTabs.forEach(function(tab) {
        tab.classList.toggle('active');
      });
      event.preventDefault();
  
      event.target.parentElement.classList.add('active');

      // show and hide tab panels
      var tabPanel = document.getElementById(event.target.href.split("#")[1]);
      tabPanel.classList.toggle('active');
    }
  });