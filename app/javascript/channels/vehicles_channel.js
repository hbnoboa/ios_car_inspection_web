import consumer from "./consumer";

consumer.subscriptions.create("VehiclesChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Connected to VehiclesChannel");
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log("Received data:", data);
    // Update the page with the new data
    updateVehiclesTable(data);
  },
});

function updateVehiclesTable(data) {
  const tbody = document.querySelector("table tbody");
  tbody.innerHTML = ""; // Clear existing rows

  data.vehicles.forEach((vehicle) => {
    const row = document.createElement("tr");
    row.innerHTML = `
      <td class="text-center">${vehicle.chassis}</td>
      <td class="text-center">${vehicle.model}</td>
      <td class="text-center">${vehicle.location}</td>
      <td class="text-center">${vehicle.ship}</td>
      <td class="text-center">${vehicle.situation}</td>
      <td class="text-center">${vehicle.nonconformity}</td>
      <td class="text-center">${vehicle.updated_at}</td>
      <td class="justify-content-center d-flex">
        <a href="/vehicles/${vehicle.id}" class="btn btn-link px-1">
          <img src="/assets/see.png" alt="sair" class="img-fluid" width="12" height="12">
        </a>
        ${
          vehicle.nonconformity != 0
            ? `<a href="/vehicles/show_pdf/${vehicle.id}" target="_blank" class="btn btn-link px-1">
          <img src="/assets/pdf.png" alt="sair" class="img-fluid" width="12" height="12">
        </a>`
            : ""
        }
      </td>
    `;
    tbody.appendChild(row);
  });
}
