const bookNow = document.querySelectorAll(".train-routes")

bookNow.forEach(function(element) {
  element.addEventListener("click", function(e) {
    const trainId = this.dataset.trainId;
    
    $.ajax({
      url: "/api/v1/train_routes/",
      data: {trainId: trainId},
      dataType: "json",
      success: function (response) {
        console.log(response);
      }
    });
  })
})
