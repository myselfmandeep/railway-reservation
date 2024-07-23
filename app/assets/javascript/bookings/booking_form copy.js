

(function() {

  function errorMsg(element, message) {
    element.prepend(`<li class='text-danger'>${message}</li>`)
    setTimeout(() => element.empty(), 1500)
  }
  const closeBtn = document.querySelectorAll(".close-modal");
  
  for(let element of closeBtn) {
    element.addEventListener("click", function (e) {
      const modal = document.getElementById("train-booking") || document.getElementById("seats-modal");
      modal.remove();
    });
  };

  // const bookingForm = document.querySelector("#new-booking");
  // const submitBooking = document.querySelector("#submit-booking")
  const bookingSeats = document.querySelector(".booking-seats");
  const bookingDate = document.querySelector(".booking-date");
  const statusText = document.querySelector("#status");
  const coachClass = document.querySelector(".coach-class");
  const trainRoute = document.querySelector(".train-route-id");
  const bookingErrors = $("#booking-errors")
  // const bookingStatus = document.querySelector(".booking-status");

  
  bookingSeats.addEventListener("blur", function(e) {
    const routeId = document.querySelector(".train-route-id");
    
    $.ajax({
      url: "/api/v1/train_routes/booking_price",
      data: {seats: this.value, routeId: routeId.value},
      dataType: "json",
      success: function (response) {
        document.querySelector(".booking-amount").value = response
        // document.getElementById("booking_amount").value = response
        document.getElementById("amount").innerHTML = `${response} Rs`
      }
    });
  });
  
  const showAvailableSeats = function(event) {
    $.ajax({
      url: "/api/v1/train_routes/available_seats",
      data: {route_id: trainRoute.value, date: this.value, category: coachClass.value},
      dataType: "json",
      success: function (response) {
        // const seats  = response.unreserved_seats;
        // const status = seats > 0 && seats >= bookingSeats.value  ? "confirmed" : "waiting";
        // console.log("available seats: ", response);
        
        // bookingStatus.value = status;
        // statusText.innerHTML = status;
        statusText.innerHTML = ` ${response.unreserved_seats} seats available`;
      }
    });
  }

  bookingDate.addEventListener("change", showAvailableSeats)
  coachClass.addEventListener("change", showAvailableSeats)

  console.log(submitBooking);

  submitBooking.addEventListener("click", function(event) {
    event.preventDefault();

    // alert("prevent default");

    if (!bookingSeats.value || !bookingDate.value) {
      !!bookingErrors.children.length ? bookingErrors.empty() : "";
      errorMsg(bookingErrors, "Both seat and date must be present")
    } else {
      bookingForm.submit();
    }

  })
  
})();

