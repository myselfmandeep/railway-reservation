
const email     = document.querySelector(".email-input");
const password  = document.querySelector(".password-input");
const loginBtn  = document.querySelector(".login-btn");

loginBtn.addEventListener("click", function (event) {

  const emailPresent      = !!email.value;
  const passwordPresent   = !!password.value;
  const border            = "border-danger";
  
  if (!(emailPresent && passwordPresent)) {

    event.preventDefault();
    
    emailPresent    ? email.classList.remove(border)    : email.classList.add(border);
    passwordPresent ? password.classList.remove(border) : password.classList.add(border);
    
  };

})

