
const selectAllDaysBtn = document.querySelector("#select-all-days")
const selectAllCoachesBtn = document.querySelector("#select-all-coaches")

selectAllDaysBtn.addEventListener("click", (e) => {
  const checkDays = Array.from(document.querySelectorAll(".select-working-days"));
  
  checkDays.forEach((e)=> {
    e.checked = true
  })
})

selectAllCoachesBtn.addEventListener("click", (e) => {
  console.log("coach btn has been clicked...");
  const checkCoaches = Array.from(document.querySelectorAll(".select-coaches"));
  
  checkCoaches.forEach((e)=> {
    e.checked = true
  })
})
