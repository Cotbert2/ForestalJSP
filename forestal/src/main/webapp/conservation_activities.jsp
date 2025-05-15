<%-- 
    Document   : conservation_activities
    Created on : 12 may. 2025, 21:09:17
    Author     : Luis Sagnay
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Conservation Activities</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.1/flowbite.min.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.1/flowbite.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/flowbite/dist/flowbite.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.7.1/leaflet.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/leaflet.draw/1.0.4/leaflet.draw.css" />
    <link href="https://cdn.jsdelivr.net/npm/tom-select@2.3.1/dist/css/tom-select.css" rel="stylesheet" />

    <link rel="icon" href="./assets/leave.png" type="image/x-icon">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body class="bg-gray-50 text-gray-900">

    <header class="sticky top-0 z-50 bg-white shadow">
        <nav class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div class="flex justify-between items-center py-4">
            <div class="text-2xl font-bold text-green-700">
              <a href="/forestal/">
                Run Forest, Run!</div>
              </a>
            <ul class="flex space-x-8 text-sm font-medium">
              <li><a href="forestal_zone" class="hover:text-green-700">Forest Zones</a></li>
              <li><a href="tree_species" class="hover:text-green-700">Tree species</a></li>
              <li><a href="conservation_activities" class="hover:text-green-700">Conservation activities</a></li>
            </ul>
          </div>
        </nav>
      </header>
    

    <!-- Modal: New Activity -->
        <div id="modalNewActivity" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 hidden">
        <div class="bg-white rounded-lg w-full max-w-xl shadow-lg transform transition-all my-10 max-h-[90vh] overflow-hidden flex flex-col">
            <div class="flex justify-between items-center border-b px-6 py-4 flex-shrink-0">
                <h3 class="text-xl font-semibold text-green-800">Add Conservation Activity</h3>
                <button data-modal-target="modalNewActivity" data-modal-toggle="modalNewActivity" class="text-gray-500 hover:text-green-600 text-xl">&times;</button>
            </div>
            
            <div class="p-6 overflow-y-auto flex-grow">
                <form id="activityForm" method="post" class="space-y-4">
                    <input type="hidden" name="uuid" id="activityUuid">
                    <input type="hidden" name="_method" id="formMethod" value="CREATE">
                    <input type="hidden" name="_method" id="activityMethod" value="POST">

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Name</label>
                        <div class="relative">
                            <i class="fas fa-tag absolute left-3 top-3 text-gray-400"></i>
                            <input type="text" name="name" id="activityName" required 
                                   class="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500">
                        </div>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Description</label>
                        <div class="relative">
                            <i class="fas fa-align-left absolute left-3 top-3 text-gray-400"></i>
                            <textarea name="description" id="activityDescription" required 
                                   class="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500"></textarea>
                        </div>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Start Date</label>
                        <div class="relative">
                            <i class="fas fa-calendar-alt absolute left-3 top-3 text-gray-400"></i>
                            <input type="datetime-local" name="start_date" id="activityStartDate" required 
                                   class="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500">
                        </div>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">End Date</label>
                        <div class="relative">
                            <i class="fas fa-calendar-alt absolute left-3 top-3 text-gray-400"></i>
                            <input type="datetime-local" name="end_date" id="activityEndDate" required 
                                   class="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500">
                        </div>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Register Date</label>
                        <div class="relative">
                            <i class="fas fa-calendar-alt absolute left-3 top-3 text-gray-400"></i>
                            <input type="datetime-local" name="register_date" id="registerDate" required 
                                   class="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500">
                        </div>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Forest Zone</label>
                        <div class="relative">
                            <i class="fas fa-tree absolute left-3 top-3 text-gray-400"></i>
                            <select name="uuidd_forestal_zone" id="activityZone" required 
                                    class="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500">
                                <option value="" selected disabled>Select a zone...</option>
                                <c:forEach var="zone" items="${zones}">
                                    <option value="${zone.uuid}">${zone.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="flex justify-end space-x-4 px-6 py-4 border-t flex-shrink-0">
                <button data-modal-target="modalNewActivity" data-modal-toggle="modalNewActivity" 
                        class="px-4 py-2 bg-gray-200 text-gray-700 rounded hover:bg-gray-300">Cancel</button>
                <button type="submit" form="activityForm" 
                        class="px-4 py-2 bg-green-600 text-white rounded hover:bg-green-700">Save Activity</button>
            </div>
        </div>
    </div>


    <section class="max-w-7xl mx-auto py-16 px-4 sm:px-6 lg:px-8" id="conservation-activities">
        <div class="flex justify-between items-center mb-4">
            <h2 class="text-3xl font-bold text-green-800">Conservation Activities</h2>
            <div class="flex">
                <button onclick="downloadActivitiesCSV()" class="bg-green-700 flex text-white px-4 py-2 rounded hover:bg-green-600 m-2">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M7.5 7.5h-.75A2.25 2.25 0 0 0 4.5 9.75v7.5a2.25 2.25 0 0 0 2.25 2.25h7.5a2.25 2.25 0 0 0 2.25-2.25v-7.5a2.25 2.25 0 0 0-2.25-2.25h-.75m-6 3.75 3 3m0 0 3-3m-3 3V1.5m6 9h.75a2.25 2.25 0 0 1 2.25 2.25v7.5a2.25 2.25 0 0 1-2.25 2.25h-7.5a2.25 2.25 0 0 1-2.25-2.25v-.75" />
                    </svg> Download CSV</button>

                <button data-modal-target="modalNewActivity" data-modal-toggle="modalNewActivity" class="bg-green-700 flex text-white px-4 py-2 rounded hover:bg-green-600 m-2">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v6m3-3H9m12 0a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z" />
                    </svg>New</button>
            </div>
        </div>

        <div class="overflow-x-auto">
            <table class="min-w-full divide-y divide-gray-200" id="activityTable">
                <thead class="bg-gray-100">
                    <tr>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Name</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Description</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Start Date</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">End Date</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Register Date</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Zone</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Actions</th>
                    </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                    <c:forEach var="activity" items="${activities}">
                        <tr>
                            <td class="px-6 py-4">${activity.name}</td>
                            <td class="px-6 py-4">${activity.description}</td>
                            <td class="px-6 py-4">
                                <fmt:formatDate value="${activity.startDate}" pattern="yyyy-MM-dd HH:mm" />
                            </td>
                            <td class="px-6 py-4">
                                <fmt:formatDate value="${activity.endDate}" pattern="yyyy-MM-dd HH:mm" />
                            </td>
                            <td class="px-6 py-4">
                                <fmt:formatDate value="${activity.registerDate}" pattern="yyyy-MM-dd HH:mm" />
                            </td>
                            <td class="px-6 py-4">
                                <c:forEach var="zone" items="${zones}">
                                    <c:if test="${zone.uuid == activity.forestalZoneUuid}">
                                        ${zone.name}
                                    </c:if>
                                </c:forEach>
                            </td>
                            <td class="px-6 py-4 space-x-2 flex">
                                <button data-modal-target="modal-${activity.uuid}" data-modal-toggle="modal-${activity.uuid}" 
                                        class="bg-green-600 text-white px-3 py-1 rounded hover:bg-green-500">
                                    <i class="fas fa-eye"></i>
                                </button>
                                        
                                <button onclick="onDeleteActivity('${activity.uuid}')" 
                                        class="bg-green-600 text-white px-3 py-1 rounded hover:bg-green-500">
                                    <i class="fas fa-trash-alt"></i>
                                </button>

                            </td>
                        </tr>

                    </c:forEach>
                </tbody>
            </table>
        </div>
    </section>

    <c:forEach var="activity" items="${activities}">
        <div id="modal-${activity.uuid}" tabindex="-1" class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 w-full h-modal h-full bg-black/40">
            <div class="relative p-4 w-full max-w-2xl h-full md:h-auto mx-auto">
                <div class="bg-white rounded-lg shadow p-6 relative">
                    <button type="button" class="absolute top-2 right-2 text-gray-400 hover:text-gray-900" data-modal-hide="modal-${activity.uuid}">
                        <svg aria-hidden="true" class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 011.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd"></path>
                        </svg>
                    </button>
                    <h3 class="text-xl font-semibold text-green-700 mb-4">Activity Details</h3>
                    <div class="mb-4 space-y-3">
                        <p><strong class="text-gray-700">Name:</strong> ${activity.name}</p>
                        <p><strong class="text-gray-700">Description:</strong> ${activity.description}</p>
                        <p><strong class="text-gray-700">Start Date:</strong> ${activity.startDate}</p>
                        <p><strong class="text-gray-700">End Date:</strong> ${activity.endDate}</p>
                        <p><strong class="text-gray-700">Register Date:</strong> ${activity.registerDate}</p>
                        <p><strong class="text-gray-700">Forest Zone:</strong> ${activity.forestalZoneUuid}</p>
                    </div>
                    <button onclick="onEditActivity('${activity.uuid}', '${activity.name}', '${activity.description}', '${activity.startDate}', '${activity.endDate}', '${activity.forestalZoneUuid}')" 
                            class="bg-green-600 text-white px-3 py-1 rounded hover:bg-green-500">
                        <i class="fas fa-edit"></i>
                    </button>
                </div>
                    
            </div>
        </div>
    </c:forEach>

    <!-- SimpleDataTables -->
    <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"></script>
    <!-- Flowbite -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.1/flowbite.min.js"></script>

    <script>
        const downloadActivitiesCSV = () => {
            const rows = document.querySelectorAll("#activityTable tbody tr");
            if (!rows.length) {
                alert("No hay datos disponibles para descargar.");
                return;
            }

            let csv = "Name,Description,Start Date,End Date,Register Date,Zone\n";

            rows.forEach(row => {
                const cells = row.querySelectorAll("td");
                const values = Array.from(cells)
                    .slice(0, 6) 
                    .map(cell => {
                        const text = cell?.innerText?.trim() ?? "";
                        return `"\${text.replace(/"/g, '""')}"`;
                    });
                csv += values.join(",") + "\n";
            });

            const blob = new Blob([csv], { type: "text/csv;charset=utf-8;" });

            if (window.navigator.msSaveOrOpenBlob) {
                window.navigator.msSaveBlob(blob, "conservation_activities.csv");
            } else {
                const link = document.createElement("a");
                const url = URL.createObjectURL(blob);
                link.setAttribute("href", url);
                link.setAttribute("download", "conservation_activities.csv");
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);
                URL.revokeObjectURL(url);
            }
        };
    </script>

    <form action="/forestal/conservation_activities" id="deleteForm" method="post">
        <input type="hidden" name="uuid" id="uuid">
        <input type="hidden" name="_method" value="DELETE">
    </form>

    <script>
        const onDeleteActivity = (uuid) => {
            Swal.fire({
                title: "¿Estás seguro?",
                text: "¡No podrás revertir esta acción!",
                icon: "warning",
                showCancelButton: true,
                confirmButtonColor: "#3085d6",
                cancelButtonColor: "#d33",
                confirmButtonText: "Sí, eliminar",
                cancelButtonText: "Cancelar"
            }).then((result) => {
                if (result.isConfirmed) {
                    document.getElementById("uuid").value = uuid;
                    document.getElementById("deleteForm").submit();
                }
            });
        };
    </script>

    <script>
    // Función para hacer editable los campos de una actividad
    const makeActivityEditable = (uuid) => {
        const inputs = document.querySelectorAll(`#activity-info-${uuid} input, #activity-info-${uuid} textarea`);
        const saveBtn = document.querySelector(`#btn-save-${uuid}`);
        
        saveBtn?.classList.toggle("hidden");
        inputs?.forEach(input => {
            input.toggleAttribute("readonly");
            input.classList.toggle("bg-gray-100");
            input.classList.toggle("text-gray-700");
        });
        
        if (inputs.length > 0) {
            inputs[0].focus();
        }
    };

    // Función para hacer los campos de solo lectura
    const makeActivityReadOnly = (uuid) => {
        const inputs = document.querySelectorAll(`#activity-info-${uuid} input, #activity-info-${uuid} textarea`);
        const saveBtn = document.querySelector(`#btn-save-${uuid}`);
        
        saveBtn?.classList.add("hidden");
        inputs?.forEach(input => {
            input.setAttribute("readonly", "");
            input.classList.add("bg-gray-100", "text-gray-700");
        });
    };

    // Inicialización de fechas
    document.addEventListener('DOMContentLoaded', () => {
        // Configurar fecha de registro
        const now = new Date();
        const ecuadorOffset = -5 * 60; // UTC-5 para Ecuador
        const localTime = new Date(now.getTime() + (ecuadorOffset - now.getTimezoneOffset()) * 60000);
        document.getElementById('registerDate').value = localTime.toISOString().slice(0, 16);
        
        // Configurar fechas de inicio y fin por defecto
        document.getElementById('activityStartDate').value = localTime.toISOString().slice(0, 16);
        
        const endTime = new Date(localTime.getTime() + 3600000); // 1 hora después
        document.getElementById('activityEndDate').value = endTime.toISOString().slice(0, 16);
        
        // Inicializar DataTable
        new simpleDatatables.DataTable(document.getElementById('activityTable'), {
            perPage: 5,
            perPageSelect: [5, 10, 25, 50],
            searchable: true,
            sortable: true,
            labels: {
                placeholder: "Buscar...",
                perPage: "{select} por página",
                noRows: "No hay registros",
                info: "Mostrando {start} a {end} de {rows} entradas"
            }
        });
    });

    // Validación del formulario
    document.getElementById('activityForm')?.addEventListener('submit', function(e) {
        e.preventDefault();
        
        const form = e.target;
        const errors = [];
        
        // Validar campos
        if (!form.name.value.trim()) errors.push("El nombre es requerido");
        if (!form.description.value.trim()) errors.push("La descripción es requerida");
        if (!form.start_date.value) errors.push("La fecha de inicio es requerida");
        if (!form.end_date.value) errors.push("La fecha de fin es requerida");
        if (new Date(form.end_date.value) <= new Date(form.start_date.value)) {
            errors.push("La fecha de fin debe ser posterior a la de inicio");
        }
        //if (!form.uuidd_forestal_zone.value) errors.push("Debe seleccionar una zona forestal");
        
        if (errors.length > 0) {
            Swal.fire({
                icon: "error",
                title: "Error de validación",
                html: errors.join("<br>")
            });
            return;
        }
        
        // Enviar formulario si es válido
        form.submit();
    });

    // Función para editar actividad (abrir modal con datos)
    const onEditActivity = (uuid, name, description, startDate, endDate, zoneUuid) => {
        document.getElementById('activityUuid').value = uuid;
        document.getElementById('activityName').value = name;
        document.getElementById('activityDescription').value = description;
        document.getElementById('activityStartDate').value = startDate.replace(' ', 'T').slice(0, 16);
        document.getElementById('activityEndDate').value = endDate.replace(' ', 'T').slice(0, 16);
        document.getElementById('activityZone').value = zoneUuid;
        document.getElementById('formMethod').value = 'UPDATE';
        
        // Abrir modal
        const modal = new Modal(document.getElementById('modalNewActivity'));
        modal.show();
    };

    function onEditActivity(uuid, name, description, startDate, endDate, zone) {
        const modal = document.getElementById("modalNewActivity");
        const form = document.getElementById("activityForm");
        
        if (form) {
            form.action = "/conservation/activities"; // o tu endpoint de actualización
            form.uuid.value = uuid;
            form.name.value = name;
            form.description.value = description;
            form.start_date.value = new Date(startDate).toISOString().slice(0, 16);
            form.end_date.value = new Date(endDate).toISOString().slice(0, 16);
            form.forestal_zone_uuid.value = zone;
            
            // Asegúrate de establecer el método de actualización
            document.getElementById("activityMethod").value = "PUT";
            
            // Mostrar modal
            modal.classList.remove("hidden");
        }
    }

</script>



<script>
    document.addEventListener("DOMContentLoaded", function () {
        const tabla = document.querySelector("#activityTable");
        if (tabla) {
            new simpleDatatables.DataTable(tabla);
        }
    });
</script>


<!-- Dependencias necesarias -->
<script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.7.1/leaflet.js"></script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- DataTables JS -->
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <!-- DataTables CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
</body>
</html>