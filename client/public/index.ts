const soap = require("soap");

const wsdlUrl = "http://localhost:8080/forestal/ForestalSOAP?wsdl";

const getForestalZones = async () => {
  try {
    const client = await soap.createClientAsync(wsdlUrl);

    client.ForestalSOAP.ForestalServicePort.getForestalZones(
      {},
      function (err, result) {
        if (err) {
          console.error("Error while geting zones", err);
        } else {
          const zones = Array.isArray(result.return)
            ? result.return
            : result.return
            ? [result.return]
            : [];

          console.log("Zones:", zones);
          renderTable(zones);
          return zones;
        }
      }
    );
  } catch (error) {
    console.error("Error:", error);
    return [];
  }
};



const getTreeSpecies = () => {
  return new Promise((resolve, reject) => {
    soap.createClient(wsdlUrl, (err, client) => {
      if (err) {
        console.error("Failed to create SOAP client:", err);
        return reject([]);
      }

      if (
        client.ForestalSOAP &&
        client.ForestalSOAP.ForestalServicePort &&
        typeof client.ForestalSOAP.ForestalServicePort.getTreeeSpecies ===
          "function"
      ) {
        client.ForestalSOAP.ForestalServicePort.getTreeeSpecies(
          {},
          (err, result) => {
            if (err) {
              console.error("Error fetching tree species:", err);
              return reject([]);
            }

            const species = Array.isArray(result.return)
              ? result.return
              : result.return
              ? [result.return]
              : [];

              const select = document.getElementById("speciesSelect");
      select.innerHTML = ""; 

      species.forEach(s => {
        const option = document.createElement("option");
        option.value = s.uuid;
        option.textContent = `${s.name} - ${s.commonName}`;
        select.appendChild(option);
      });

      new TomSelect("#speciesSelect", {
        create: false,
        sortField: {
          field: "text",
          direction: "asc"
        }
      });

            resolve(species);
          }
        );
      } else {
        console.error("Method getTreeeSpecies not found in SOAP client.");
        reject([]);
      }
    });
  });
};

getTreeSpecies();
const deleteTreeSpecies = (uuid) => {
  return new Promise((resolve, reject) => {
    soap.createClient(wsdlUrl, (err, client) => {
      if (err) {
        console.error("Failed to create SOAP client:", err);
        return reject(false);
      }

      if (
        client.ForestalSOAP &&
        client.ForestalSOAP.ForestalServicePort &&
        typeof client.ForestalSOAP.ForestalServicePort.deleteTreeSpecie ===
          "function"
      ) {
        const args = { uuid: uuid };

        client.ForestalSOAP.ForestalServicePort.deleteTreeSpecie(
          args,
          (err, result) => {
            if (err) {
              console.error("Error deleting tree species:", err);
              return reject(false);
            }

            resolve(result);
          }
        );
      } else {
        console.error("Method deleteTreeSpecie not found in SOAP client.");
        reject(false);
      }
    });
  });
};

const createForestalZone = ({
  name,
  description,
  area,
  image,
  registerDate,
  mapJson,
}) => {
  return new Promise((resolve, reject) => {
    soap.createClient(wsdlUrl, (err, client) => {
      if (err) {
        console.error("Failed to create SOAP client:", err);
        return reject(false);
      }

      if (
        client.ForestalSOAP &&
        client.ForestalSOAP.ForestalServicePort &&
        typeof client.ForestalSOAP.ForestalServicePort.createForestalZone ===
          "function"
      ) {
        const args = {
          name,
          description,
          area,
          image,
          registerDate,
          mapJson,
        };

        client.ForestalSOAP.ForestalServicePort.createForestalZone(
          args,
          (err, result) => {
            if (err) {
              console.error("Error creating forestal zone:", err);
              return reject(false);
            }
            resolve(result);
          }
        );
      } else {
        console.error("Method createForestalZone not found in SOAP client.");
        reject(false);
      }
    });
  });
};
async function handleCreateZone(event) {
    event.preventDefault();
    const name = document.getElementById("zoneName").value.trim();
    const description = document.getElementById("zoneDescription").value.trim();
    const area = parseFloat(document.getElementById("zoneArea").value);
    const image = document.getElementById("zoneImage").value.trim();
    const registerDate = formatToSqlTimestamp(document.getElementById("zoneRegisterDate").value);
    const mapJson = document.getElementById("zoneMapJson").value.trim();

    if (!name || !description || isNaN(area) || !registerDate) {
      alert("Por favor complete todos los campos obligatorios correctamente.");
      return;
    }

    const client = await soap.createClientAsync(wsdlUrl);
    client.ForestalSOAP.ForestalServicePort.createForestalZone({
      name,
      description,
      area,
      image,
      registerDate,
      mapJson
    }, (err, result) => {

        console.log('all data', {
            name,
            description,
            area,
            image,
            registerDate,
            mapJson
        });
      if (err) {

        alert("Error creating zone");
        return;
      }
      document.getElementById("modal").classList.add("hidden");
      getForestalZones();
    });
  }

const renderTable = (data) => {
    console.log("Data to render:", data);
    const tableBody = document.getElementById("table-body");
    tableBody.innerHTML = "";
    data.forEach((zone) => {
      const row = document.createElement("tr");
      row.innerHTML = `
        <td class="px-4 py-2">${zone.name}</td>
        <td class="px-4 py-2">${zone.description}</td>
        <td class="px-4 py-2">${zone.area}</td>
        <td class="px-4 py-2 text-sm text-ellipsis max-w-xs overflow-hidden">${zone.mapJson}</td>
        <td class="px-4 py-2"><img src="${zone.image}" alt="imagen" class="w-16 h-16 object-cover rounded" /></td>
      `;
      tableBody.appendChild(row);
    });
  }

  const deleteSelectedSpecies = () => {
    const select = document.getElementById("speciesSelect");
    const selectedSpecies = select.value;

    if (selectedSpecies) {
      deleteTreeSpecies(selectedSpecies)
        .then((result) => {
          console.log("Species deleted:", result);
          getTreeSpecies();
        })
        .catch((error) => {
          console.error("Error deleting species:", error);
        });
    } else {
      alert("Please select a species to delete.");
    }
  }

  document.addEventListener("DOMContentLoaded", loadTreeSpecies);
  document.getElementById("deleteSpeciesBtn").addEventListener("click", () => {
    alert("delete");
  });


  function formatToSqlTimestamp(input) {
    console.log("Valor recibido en formatToSqlTimestamp:", input); // 👈 clave
    const date = new Date(input);

    if (isNaN(date.getTime())) throw new Error("Fecha inválida");

    const pad = n => n < 10 ? '0' + n : n;
    return `${date.getFullYear()}-${pad(date.getMonth() + 1)}-${pad(date.getDate())} ${pad(date.getHours())}:${pad(date.getMinutes())}:${pad(date.getSeconds())}`;
  }
  

