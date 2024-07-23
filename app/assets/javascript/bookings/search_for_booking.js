const searchPnrBtn = document.getElementById("search-booking");

searchPnrBtn.addEventListener("click", function () {
  const getPnr = document.getElementById("pnr-number");
  const pnrNumber = getPnr.value;

  if (!Number(pnrNumber)) {
    alert("it should contains only  number")
    return;
  };

  $.ajax({
    url: "/api/v1/train_routes/pnr_details",
    data: {pnrNumber: pnrNumber},
    dataType: "json",
    success: function (response) {
      if (!response) {
        alert(`no booking found with number: ${pnrNumber}`)
      } else {
        const showTicket = confirm("See your booking?");

        if (showTicket) {
          location = `/bookings/${response.id}/ticket`
        }
      };
        
      console.log(response);
      getPnr.value = ""
    }
  });
})