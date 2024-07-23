const cancelBookingBtns = document.querySelectorAll(".cancel-booking");
const csrfToken = document.querySelector("[name=\"csrf-token\"]").content

for(const element of cancelBookingBtns) {
  element.addEventListener("click", function (event) {

    const bookingId = this.dataset.bookingId;
    const status    = $(`#status-${bookingId}`);
    const url       = `/bookings/${bookingId}`;
    const seats     = $(`#seats-${bookingId}`);

    $.ajax({
      type: "PATCH",
      data: {authenticity_token: csrfToken},
      url: url,
      dataType: "json",
      success: function (response) {
        
        status.removeClass("table-success")
        status.addClass("table-danger")
        status.text("canceled")
        seats.text("[]")
        console.log(response);
      },
      error: function (xhr, status, error) {
        // console.error("Error:", error);
        console.log(error);
      }
    });
  })
}


