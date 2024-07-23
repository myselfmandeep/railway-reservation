
const source              = document.querySelector(".select_source_station");
const destination         = document.querySelector(".select_destination_station");
const sourceStations      = Array.from(source);
const destinationStations = Array.from(destination);
const swapStation         = document.querySelector("#swap-stations");

source.addEventListener("change", function(event) {

  const selectedElmValue = this.selectedOptions[0].value;
  destinationStations.forEach((e) => e.style.display = e.value == selectedElmValue ? "none" : "");
});

destination.addEventListener("change", function(event) {

  const selectedElmValue = this.selectedOptions[0].value
  sourceStations.forEach((e) => e.style.display = e.value == selectedElmValue ? "none" : ""); 
});

swapStation.addEventListener("click", function (event) { 

  const sourceStation       = source.selectedOptions[0].value
  const destinationStation  = destination.selectedOptions[0].value

  for(let x of source) {
    if (x.value == destinationStation) {
      x.selected = true;
      break;
    };
  };

  for(let x of destination) {
    if (x.value == sourceStation) {
      x.selected = true;
      break;
    };
  };
  
})


