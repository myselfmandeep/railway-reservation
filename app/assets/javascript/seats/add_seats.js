console.log('add seats');

const addSeatBtn = document.querySelector("#add-one-more-seat");
let presentSeatFields = 0;

addSeatBtn.addEventListener("click", function(event) {
  console.log("add seat button has been clicked...");
  presentSeatFields += 1
  const addNewSeatField = `
                          <div class="single-seat d-flex m-2">
                            <input class="form-control" type="number" name="seat[seats][seat_${presentSeatFields}][number]" id="seat_seats_seats_${presentSeatFields}_number" placeholder="seat no." ">
                          
                            <select class="form-control" name="seat[seats][seat_${presentSeatFields}][berth]" id="seat_seats_seats_${presentSeatFields}_berth">
                              <option value="UB">UB</option>
                              <option value="MB">MB</option>
                              <option value="LB">LB</option>
                            </select>
                            <select class="form-control" name="seat[seats][seat_${presentSeatFields}][position]" id="seat_seats_seats_${presentSeatFields}_position">
                              <option value="window">window</option>
                              <option value="middle">middle</option>
                              <option value="aisle">aisle</option>
                            </select>
                          </div>
  `;

  $("#add-seat-here").append(addNewSeatField)

});
