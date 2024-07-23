
const filter  = document.querySelector(".trains-filter");

const performFilter = function (event) {
  const trains  = document.querySelectorAll(".train");
  const types   = {"Train-name": ".train-name", "Train-no.": ".train-number"};
  const options = document.querySelector("#options");
  const value = filter.value;
  const type  = options.value;
  
  console.log(trains);
  
  trains.forEach((card) => {
    const field     = card.querySelector(types[type]).innerHTML;
    const subStr    = eval(`/${value}/gi`);
    const hideOrNot = field.match(subStr);

    console.log([field, subStr, hideOrNot]);
    
    card.style.display = hideOrNot ? "" : "none";
  });
}

filter.addEventListener("keydown", performFilter);
filter.addEventListener("paste", performFilter);
