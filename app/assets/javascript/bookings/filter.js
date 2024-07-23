
const filter   = document.querySelector(".booking-filter");
const bookings = document.querySelectorAll(".booking-record");
const types    = {name: "#b-train", pnr: "#b-pnr", number: "#b-train-no"};
const options  =  document.querySelector("#options");

const doFilteration = function(event) {
  const value = filter.value;
  const type  = options.value;

  bookings.forEach((row) => {
    const field     = row.querySelector(types[type]).innerHTML;
    const subStr    = eval(`/${value}/gi`);
    const hideOrNot = field.match(subStr);

    row.style.display = hideOrNot ? "" : "none";
  });

}

filter.addEventListener("keydown", doFilteration);
filter.addEventListener("paste"  , doFilteration);