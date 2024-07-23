//= require jquery

const collectValues  = (inputCollection) => Array.from(inputCollection).map((input) => input.value);
const checkEvery     = (val)             => Boolean(val) == true;

const submitButton   = document.querySelector("#submit-booking");
const makePayment    = document.querySelector(".booking-payment");
const newBooking     = $("#new-booking");

submitButton.addEventListener("click", function(event) {
  
  const ticketNames     = collectValues(document.querySelectorAll(".ticket-name"));
  const ticketNumbers   = collectValues(document.querySelectorAll(".ticket-age"));
  const ticketGenders   = collectValues(document.querySelectorAll(".ticket-gender"));
  const namesPresent    = ticketNames.every(checkEvery);
  const agesPresent     = ticketNumbers.every(checkEvery);
  const gendersPresent  = ticketGenders.every((val) => ["male", "female", "other"].includes(val));
  const madePayment     = !!makePayment.value

  // console.log(madePayment);
  
  if (!(namesPresent && agesPresent && gendersPresent && madePayment)) {
    event.preventDefault();        
    
    if (!!document.querySelector("#ticket-error")) { return };
    
    newBooking.prepend(`<div class='alert alert-danger' id='ticket-error'>Please ${!madePayment ? "make payment" : "fill all the fields"}</div>`)

    const ticketError = document.querySelector("#ticket-error");
    
    setTimeout(() => ticketError.remove(), 2500);

  };
});

