

(function() {

  const closeBtn = document.querySelectorAll(".close-modal");
  
  for(let element of closeBtn) {
    element.addEventListener("click", function (e) {
      (document.getElementById("train-booking") || document.getElementById("seats-modal")).remove();
    });
  };

  const bookingSeats     = document.querySelector(".booking-seats");
  const bookingDate      = document.querySelector(".booking-date");
  const statusText       = document.querySelector(".available-seats");
  const coachClass       = document.querySelector(".coach-class");
  const trainRoute       = document.querySelector(".train-route-id");
  const initiateBooking  = document.querySelector("#initiate-booking");
  const routeId          = document.querySelector(".train-route-id");
  
  const showAvailableSeats = function(event) {

    // const routeId = document.querySelector(".train-route-id");

    // fetch booking price
    $.ajax({
      url: "/api/v1/train_routes/booking_price",
      data: {coach_class: coachClass.value, routeId: routeId.value},
      dataType: "json",
      success: function (response) {
        document.querySelector(".booking-amount").value = response
        document.getElementById("amount").innerHTML = `${response} Rs`
      }
    });
    
    // fetch available seats
    $.ajax({
      url: "/api/v1/train_routes/available_seats",
      data: {route_id: trainRoute.value, date: bookingDate.value, category: coachClass.value},
      dataType: "json",
      success: function (response) {
        console.log(response);
        statusText.innerHTML = ` ${response.unreserved_seats} seats available`;
      }
    });
  };

  bookingDate.addEventListener("change", showAvailableSeats);
  coachClass.addEventListener("change", showAvailableSeats);

  initiateBooking.addEventListener("click", function(event) {
    if (!bookingSeats.value || !coachClass.value) {
      event.preventDefault();
      alert("seat and class must be selected...")
    }
  })
  
})();

