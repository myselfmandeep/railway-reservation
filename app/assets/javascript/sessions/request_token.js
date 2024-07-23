const requestBtn = document.getElementById("request_token");

requestBtn.addEventListener("click", function (e) { 
  const email   = document.getElementById("user_email").value;
  const fpEmail = document.querySelector(".forgot-password-email");
  
  fpEmail.value = email;

  $.ajax({
    url: "/api/v1/train_routes/password_reset_token",
    data: {email: email},
    dataType: "json",
    success: function (response) {
      const token = response.token;
      
      alert((token || "user not found"))
    }
  });
});