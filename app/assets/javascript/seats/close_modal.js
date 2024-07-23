(function() {
  const closeBtn = document.querySelectorAll(".close-modal");

  for(let element of closeBtn) {
    element.addEventListener("click", function (e) {
      const modal = document.getElementById("seats-modal");
      if (!modal) {return}
      modal.remove();
    })
  }
  
})()