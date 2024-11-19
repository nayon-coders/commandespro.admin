// Retrieve the query parameter "data" from the URL
const params = new URLSearchParams(window.location.search);
const data = params.get("data");

if (data) {
  // Parse the JSON string into an object
  const invoiceData = JSON.parse(decodeURIComponent(data));

  // Populate invoice details
  document.querySelector("#invoiceNo").textContent = invoiceData.invoiceNo;
  document.querySelector("#invoiceDate").textContent = invoiceData.invoiceDate;
  document.querySelector("#orderNo").textContent = invoiceData.orderNo;
  document.querySelector("#orderDate").textContent = invoiceData.orderDate;

  // Populate billing address
  const billing = invoiceData.billingAddress;
  document.querySelector("#billingName").textContent = billing.name;
  document.querySelector("#billingStreet").textContent = billing.street;
  document.querySelector("#billingCity").textContent = `${billing.city}, ${billing.zip}`;
  document.querySelector("#billingEmail").textContent = billing.email;

  // Populate delivery address
  const delivery = invoiceData.deliveryAddress;
  document.querySelector("#deliveryName").textContent = delivery.name;
  document.querySelector("#deliveryStreet").textContent = delivery.street;
  document.querySelector("#deliveryCity").textContent = `${delivery.city}, ${delivery.zip}`;
  document.querySelector("#deliveryContact").textContent = delivery.contact;

  // Populate products table
  const productTableBody = document.querySelector("#productTableBody");
  invoiceData.products.forEach((product) => {
    const row = document.createElement("tr");
    row.innerHTML = `
      <td>${product.name}</td>
      <td>${product.quantity}</td>
      <td>${product.price.toFixed(2)} €</td>
      <td>${(product.quantity * product.price).toFixed(2)} €</td>
    `;
    productTableBody.appendChild(row);
  });

  // Populate totals
  document.querySelector("#subtotal").textContent = `${invoiceData.totals.subtotal.toFixed(2)} €`;
  document.querySelector("#vat").textContent = `${invoiceData.totals.vat.toFixed(2)} €`;
  document.querySelector("#total").textContent = `${invoiceData.totals.total.toFixed(2)} €`;
}
