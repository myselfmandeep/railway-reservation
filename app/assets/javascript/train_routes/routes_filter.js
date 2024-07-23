
const filter  = document.querySelector(".filter-routes");
const routes  = document.querySelectorAll(".route");
const options = document.querySelector("#options");

filter.addEventListener("keydown", function (event) { 
  const types = {name: ".train-name", source: ".source", destination: ".destination"};
  const value = filter.value;
  const type  = options.value

  routes.forEach((row) => {
    const field     = row.querySelector(types[type]).innerHTML;
    const subStr    = eval(`/${value}/gi`);
    const hideOrNot = field.match(subStr);

    row.style.display = hideOrNot ? "" : "none";
  })
  
});