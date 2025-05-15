  
const onUpdate = (uuid) => {
    let isValid = true;
    const name = document.getElementById('name-' + uuid);
    const description = document.getElementById('description-' + uuid);
    const area = document.getElementById('area-' + uuid);
    const registerDate = document.getElementById('register-date-' + uuid);
    if (name.value.trim() === "") {
        isValid = false;
        name.classList.add('border-red-500');
    }

    if (description.value.trim() === "") {
        isValid = false;
        description.classList.add('border-red-500');
    }

    if (isNaN(area.value.trim()) || area.value.trim() <= 0) {
        isValid = false;
        area.classList.add('border-red-500');
    }

    if (registerDate.value.trim() === "") {
        isValid = false;
        registerDate.classList.add('border-red-500');
    }

    if (!isValid) {
        console.error("Please fill in all required fields.");
        onWarningToast("Please fill in all required fields.");        
        return;
    }
    Swal.fire({
    title: "Are you sure?",
    text: "You won't be able to revert this!",
    icon: "warning",
    showCancelButton: true,
    confirmButtonColor: "#3085d6",
    cancelButtonColor: "#d33",
    confirmButtonText: "Yes, update it!"
}).then((result) => {
    if (result.isConfirmed) {
        document.getElementById('uuidUpdate').value = uuid;
        document.getElementById('nameUpdate').value = name.value;
        document.getElementById('descriptionUpdate').value = description.value;
        document.getElementById('areaUpdate').value = area.value;
        document.getElementById('registerDateUpdate').value = registerDate.value;
        document.getElementById('updateForm').submit();
    }
});
    
    
    
    
};
 
  

const activeEdit = false;

const makeEditable = (uuid) => {
    const inputs = document.querySelectorAll("#zone-info-" + uuid + " input");
    const saveBtn = document.querySelector("#btn-save-" + uuid);
    saveBtn.classList.toggle("hidden");

    if (inputs.length > 0) {
        inputs.forEach((input, index) => {
            if (index !== inputs.length - 1) {
                input.toggleAttribute("readonly");
                input.classList.toggle("text-gray-400");
            }
        });
        inputs[0].focus();
    } else {
        console.log("error xd");
    }
};

const makeReadOnly = (uuid) => {
    const inputs = document.querySelectorAll("#zone-info-" + uuid + " input");
    const saveBtn = document.querySelector("#btn-save-" + uuid);
    saveBtn.classList.toggle("hidden");
    if (inputs) {
        inputs.forEach(input => {
            if (!input.hasAttribute("readonly")) {
                input.setAttribute("readonly", "");
                input.classList.toggle("text-gray-400");
                input.focus();
            }
        });
        inputs[0].focus();
    } else {
        console.log("error xd");
    }
};
 



  
const onDeleteTree = (uuidForestal, uuidTree) => {
    Swal.fire({
        title: "Are you sure?",
        text: "You won't be able to revert this!",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "Yes, delete it!"
    }).then((result) => {
        if (result.isConfirmed) {
            document.getElementById("uuidForestal").value = uuidForestal;
            document.getElementById("uuidTree").value = uuidTree;
            document.getElementById("deleteTreeForm").submit();
        }
    });
}
 



  
 const addNewTree = (uuidForestal) => {
    const select = document.getElementById(`treeSelect-` + uuidForestal);
    if (!select) {
        console.error(`No se encontró el select para la zona con UUID: ${uuidForestal}`);
        return;
    }
    const uuidTree = select.value;
    Swal.fire({
        title: "Are you sure?",
        text: "You won't be able to revert this!",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "Yes, save it!"
    }).then((result) => {
        if (result.isConfirmed) {
            document.getElementById("uuidForestalAdd").value = uuidForestal;
            document.getElementById("uuidTreeAdd").value = uuidTree;
            document.getElementById("addNewTreeForm").submit();
        }
    });
}
 


  
document.addEventListener('DOMContentLoaded', () => {
    const now = new Date();

    const ecuadorOffset = -5 * 60;
    const localTime = new Date(now.getTime() + (ecuadorOffset - now.getTimezoneOffset()) * 60000);

    const formatted = localTime.toISOString().slice(0, 16);

    const input = document.getElementById('registerDate');
    input.value = formatted;
    input.readOnly = true;
});
                 


  
document.addEventListener("DOMContentLoaded", () => {
    document.querySelectorAll('[id^="treeSelect-"]').forEach(selectElement => {
        new TomSelect(selectElement, {
            create: false,
            allowEmptyOption: true,
            maxOptions: 100
        });
    });

    document.querySelectorAll('[id^="addTreeBtn-"]').forEach(btn => {
        btn.addEventListener('click',  () =>  {
            const zoneId = btn.id.replace('addTreeBtn-', '');
            const treeSelectContainer = document.getElementById(`treeSelectContainer-` + zoneId);
            console.log(treeSelectContainer);
            if (treeSelectContainer) {
                if (treeSelectContainer.classList.contains('hidden')) {
                    treeSelectContainer.classList.remove('hidden');
                    setTimeout(() => {
                        treeSelectContainer.classList.add('opacity-100');
                    }, 10);
                } else {
                    treeSelectContainer.classList.remove('opacity-100');
                    setTimeout(() => {
                        treeSelectContainer.classList.add('hidden');
                    }, 500);
                }
            } else {
                console.error(`El contenedor para la zona con ID ${zoneId} no se encontró.`);
            }
        });
    });
});

 

 

  
document.addEventListener("DOMContentLoaded", () => {
    const table = document.querySelector("#zonesTable");
    new simpleDatatables.DataTable(table, {
        perPage: 5,
        perPageSelect: [5, 10, 25, 50],
        searchable: true,
        sortable: true,
    });
});
 



  
document.getElementById('forestZoneForm').addEventListener('submit',  (e) => {
    e.preventDefault();

    let isValid = true;
    const form = e.target;

    const zoneName = form.zoneName.value.trim();
    const description = form.description.value.trim();
    const area = parseFloat(form.area.value);
    const image = form.image.value.trim();
    const registerDate = form.registerDate.value.trim();
    const mapJson = form.mapJson.value.trim();

    [...form.elements].forEach(el => el.classList.remove('border-red-500'));

    if (zoneName === "") {
        isValid = false;
        form.zoneName.classList.add('border-red-500');
    }

    if (description === "") {
        isValid = false;
        form.description.classList.add('border-red-500');
    }

    if (isNaN(area) || area <= 0) {
        isValid = false;
        form.area.classList.add('border-red-500');
    }

    if (image === "") {
        isValid = false;
        form.image.classList.add('border-red-500');
    }

    if (registerDate === "") {
        isValid = false;
        form.registerDate.classList.add('border-red-500');
    }
    
    if (!mapJson) {
        isValid = false;
        form.mapJson.classList.add('border-red-500');
    }
    

    if (!isValid) {
        console.error("Please fill in all required fields.");
        onWarningToast("Please fill in all required fields.");        
        return;
    }



    form.submit();
});



  
const onDelete = (uuid) => {
    Swal.fire({
        title: "Are you sure?",
        text: "You won't be able to revert this!",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "Yes, delete it!"
    }).then((result) => {
        if (result.isConfirmed) {
            document.getElementById('uuid').value = uuid;
            document.getElementById('deleteForm').submit();
        }
    });
}
 


  
let map;
let mapInitialized = false;

document.querySelectorAll('[data-modal-toggle="modalNew"]').forEach(btn => {
    btn.addEventListener("click", () => {
        setTimeout(() => {
            const mapContainer = document.getElementById('map');

            if (!mapInitialized) {
                map = L.map('map').setView([-0.1807, -78.4678], 13);

                L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png').addTo(map);

                const drawnItems = new L.FeatureGroup();
                map.addLayer(drawnItems);

                const drawControl = new L.Control.Draw({
                    edit: { featureGroup: drawnItems },
                    draw: {
                        polygon: true,
                        marker: false,
                        circle: false,
                        rectangle: false,
                        polyline: false
                    }
                });
                map.addControl(drawControl);

                map.on('draw:created',  (event) => {
                    const layer = event.layer;
                    drawnItems.addLayer(layer);

                    const geoJsonData = layer.toGeoJSON();
                    console.log("Nuevo polígono dibujado:", geoJsonData);
                  
                    document.getElementById('mapJson').value = JSON.stringify(geoJsonData);
                });

                mapInitialized = true;
            } else {
                map.invalidateSize();
            }
        }, 300);
    });
});
 



  

const renderMap = (mapJson, uuid) => {
    console.log("Renderizando mapa...");
    console.log("mapJson", mapJson);
    setTimeout(() => {

        console.log("Renderizando mapa...");
        const parsedGeoJSON = JSON.parse(mapJson);
        const map = L.map("mapView-" + uuid).setView([-0.420, -78.49], 13);

        L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
            attribution: "© OpenStreetMap contributors"
        }).addTo(map);

        const geoJsonLayer = L.geoJSON(parsedGeoJSON).addTo(map);

        map.fitBounds(geoJsonLayer.getBounds());
    }, 1000);

}
 
