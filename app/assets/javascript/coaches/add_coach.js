const selectBar = document.querySelector("#coach_category");

selectBar.addEventListener("change", function(event) {
  const slugName = document.querySelector("#coach_slug_name");

  slugName.value = event.target.selectedOptions[0].innerText
})
