function handleErrors(errors) {

  const existingErrorContainer = document.querySelector("#errors-container");

  !!existingErrorContainer ? existingErrorContainer.remove() : ""

  errors = Array.isArray(errors) ? errors : [errors]
  
  const messages = `
    <ul>
      ${errors.map((error) => {
        `<li>${error}</li>`
      }).join()}
    </ul>
  `;

  const errorsList = errors.map(error => {
    return `<li class="text-danger">${error}</li>`
  }).join("");

  const errorsContainer = `
    <div class="col-3 alert alert-danger" id="errors-container">
      <ul>
        ${errorsList}
      </ul>
    </div>
  `;
  
  const chatContainer = document.querySelector("#chat-container");
  chatContainer.insertAdjacentHTML("afterbegin", errorsContainer);
}

export { handleErrors }