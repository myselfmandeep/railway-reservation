
const filter  = document.querySelector(".trains-filter");
const trains  = document.querySelectorAll(".train");
const types   = {name: ".train-name", number: ".train-number"};
const options = document.querySelector("#options");

filter.addEventListener("keydown", function (event) {
  const value = filter.value;
  const type  = options.value;

  trains.forEach((card) => {
    const field     = card.querySelector(types[type]).innerHTML;
    const subStr    = eval(`/${value}/gi`);
    const hideOrNot = field.match(subStr);
    
    card.style.display = hideOrNot ? "" : "none";
    
  });
});

