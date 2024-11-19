// Retrieve the query parameter "data" from the URL
const params = new URLSearchParams(window.location.search);
const data = params.get("data");

if (data) {
  // Parse the JSON string into an object
  const ordersData = JSON.parse(decodeURIComponent(data));

  // Populate the header information
  document.querySelector(".header h1").textContent = ordersData.title;
  document.querySelector(".header p:nth-of-type(1)").textContent = ordersData.dateTime;
  document.querySelector(".header .printed-by").textContent = `Printed by ${ordersData.printedBy}`;

  // Populate the orders table
  const tableBody = document.querySelector("table tbody");
  ordersData.orders.forEach((order) => {
    const row = document.createElement("tr");
    row.innerHTML = `
      <td>${order.product}</td>
      <td>${order.lastPrice} €</td>
      <td>${order.quantityOrdered}</td>
      <td>${order.commandedUnit}</td>
      <td>${order.knownStock}</td>
      <td>${order.stockUnit}</td>
    `;
    tableBody.appendChild(row);
  });
}
