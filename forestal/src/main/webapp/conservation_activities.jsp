<%-- 
    Document   : conservation_activities
    Created on : 12 may. 2025, 21:09:17
    Author     : Luis Sagnay
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Conservation Activities</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.1/flowbite.min.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.1/flowbite.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.css" />
    <link rel="icon" href="./assets/leave.png" type="image/x-icon">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body class="bg-gray-50 text-gray-900">

    <header class="sticky top-0 z-50 bg-white shadow">
        <nav class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between items-center py-4">
                <div class="text-2xl font-bold text-green-700">Run Forest, Run!</div>
                <ul class="flex space-x-8 text-sm font-medium">
                    <li><a href="#conservation-activities" class="hover:text-green-700">Conservation Activities</a></li>
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
                        <label class="block text-sm font-medium text-gray-700 mb-1">Date</label>
                        <div class="relative">
                            <i class="fas fa-calendar-alt absolute left-3 top-3 text-gray-400"></i>
                            <input type="datetime-local" name="date" id="activityDate" required 
                                   class="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500">
                        </div>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Forest Zone</label>
                        <div class="relative">
                            <i class="fas fa-tree absolute left-3 top-3 text-gray-400"></i>
                            <select name="forest_zone_uuid" id="activityZone" required 
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
                    <button onclick="downloadCSV()" class="bg-green-700 flex text-white px-4 py-2 rounded hover:bg-green-600 m-2">
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
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Date</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Zone</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Actions</th>
                    </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                    <c:forEach var="activity" items="${activities}">
                        <tr>
                            <td class="px-6 py-4">${activity.name}</td>
                            <td class="px-6 py-4">${activity.description}</td>
                            <td class="px-6 py-4">${activity.date}</td>
                            <td class="px-6 py-4">${activity.forestZone.name}</td>
                            <td class="px-6 py-4 space-x-2">
                                <button data-modal-target="modal-${activity.uuid}" data-modal-toggle="modal-${activity.uuid}" 
                                        class="bg-green-600 text-white px-3 py-1 rounded hover:bg-green-500">
                                    <i class="fas fa-eye"></i>
                                </button>

                                <button onclick="onEdit('${activity.uuid}', '${activity.name}', '${activity.description}', '${activity.date}', '${activity.forestZone.uuid}')" 
                                        class="bg-green-600 text-white px-3 py-1 rounded hover:bg-green-500">
                                    <i class="fas fa-edit"></i>
                                </button>

                                <button onclick="onDelete('${activity.uuid}')" 
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
                        <p><strong class="text-gray-700">Date:</strong> ${activity.date}</p>
                        <p><strong class="text-gray-700">Forest Zone:</strong> ${activity.forestZone.name}</p>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>

    <form action="/conservation/activities" id="deleteForm" method="post">
        <input type="hidden" name="uuid" id="uuidDelete">
        <input type="hidden" name="_method" value="DELETE">
    </form>

    <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"></script>
    <script>
        // Inicialización cuando el DOM está listo
        document.addEventListener('DOMContentLoaded', function() {
            initializeDateTime();
            initializeDataTable();
            setupFormValidation();
        });

        // 1. Configuración de fecha/hora actual para Ecuador
        function initializeDateTime() {
            const now = new Date();
            const ecuadorOffset = -5 * 60 * 60000; // UTC-5 para Ecuador (en milisegundos)
            const localTime = new Date(now.getTime() + ecuadorOffset);
            const formattedDateTime = localTime.toISOString().slice(0, 16);
            document.getElementById('activityDate').value = formattedDateTime;
        }

        // 2. Inicialización de DataTables
        let dataTable;
        function initializeDataTable() {
            const table = document.getElementById('activityTable');
            if (table) {
                dataTable = new simpleDatatables.DataTable(table, {
                    perPage: 5,
                    perPageSelect: [5, 10, 25, 50],
                    searchable: true,
                    sortable: true,
                    fixedHeight: false,
                    labels: {
                        placeholder: "Search activities...",
                        perPage: "{select} per page",
                        noRows: "No activities found",
                        info: "Showing {start} to {end} of {rows} entries"
                    }
                });
            }
        }

        // 3. Configuración de validación del formulario
        function setupFormValidation() {
            const form = document.getElementById('activityForm');
            
            form.addEventListener('submit', function(e) {
                e.preventDefault();
                
                const formData = new FormData(form);
                const errors = validateFormData(formData);
                
                if (errors.length > 0) {
                    showFormErrors(errors);
                    return;
                }
                
                submitFormData(formData);
            });
        }

        // 4. Validación de datos del formulario
        function validateFormData(formData) {
            const errors = [];
            
            if (!formData.get('name') || formData.get('name').trim().length < 3) {
                errors.push('Name must be at least 3 characters');
            }
            
            if (!formData.get('description') || formData.get('description').trim().length < 10) {
                errors.push('Description must be at least 10 characters');
            }
            
            if (!formData.get('date')) {
                errors.push('Date is required');
            }
            
            if (!formData.get('forest_zone_uuid')) {
                errors.push('Forest zone is required');
            }
            
            return errors;
        }

        // 5. Mostrar errores de validación
        function showFormErrors(errors) {
            Swal.fire({
                icon: 'error',
                title: 'Validation Error',
                html: errors.join('<br>'),
                confirmButtonColor: '#3085d6'
            });
        }

        // 6. Envío de datos del formulario
        function submitFormData(formData) {
            const uuid = formData.get('uuid');
            const action = uuid ? 'update' : 'create';
            const method = uuid ? 'PUT' : 'POST';
            
            fetch(`/conservation/activities?action=${action}`, {
                method: method,
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(Object.fromEntries(formData))
            })
            .then(response => {
                if (!response.ok) throw new Error('Network response was not ok');
                return response.json();
            })
            .then(data => {
                Swal.fire({
                    icon: 'success',
                    title: `Activity ${action}d successfully!`,
                    showConfirmButton: false,
                    timer: 1500
                }).then(() => {
                    window.location.reload();
                });
            })
            .catch(error => {
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: error.message
                });
            });
        }

        // 7. Función para abrir modal de edición
        function onEdit(uuid, name, description, date, zoneUuid) {
            document.getElementById('activityUuid').value = uuid;
            document.getElementById('activityName').value = name;
            document.getElementById('activityDescription').value = description;
            document.getElementById('activityDate').value = date;
            document.getElementById('activityZone').value = zoneUuid;
            document.getElementById('formMethod').value = 'UPDATE';
            
            const modal = document.getElementById('modalNewActivity');
            const modalInstance = new Modal(modal);
            modalInstance.show();
        }

        // 8. Función para eliminar actividad
        function onDelete(uuid) {
            Swal.fire({
                title: 'Delete Activity?',
                text: "You won't be able to revert this!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, delete it!'
            }).then((result) => {
                if (result.isConfirmed) {
                    document.getElementById('uuidDelete').value = uuid;
                    document.getElementById('deleteForm').submit();
                }
            });
        }

        // 9. Exportar a CSV
        function downloadCSV() {
            const rows = document.querySelectorAll("#activityTable tbody tr");
            if (!rows.length) {
                Swal.fire({
                    icon: 'warning',
                    title: 'No data',
                    text: 'No data available to download'
                });
                return;
            }

            let csv = "Name,Description,Date,Forest Zone\n";

            rows.forEach(row => {
                const cells = row.querySelectorAll("td");
                const values = Array.from(cells)
                        .slice(0, 4) // Tomar solo las primeras 4 columnas
                        .map(cell => {
                            const text = cell?.textContent?.trim() || "";
                            return `"\${text.replace(/"/g, '""')}"`;
                    });
                csv += values.join(",") + "\n";
            });

            const blob = new Blob([csv], {type: "text/csv;charset=utf-8;"});

            // Soporte para IE/Edge
            if (window.navigator && window.navigator.msSaveOrOpenBlob) {
                window.navigator.msSaveBlob(blob, "conservation_activities.csv");
            } else {
                // Para otros navegadores
                const link = document.createElement("a");
                const url = URL.createObjectURL(blob);
                link.setAttribute("href", url);
                link.setAttribute("download", "conservation_activities.csv");
                document.body.appendChild(link);
                link.click();
                
                // Limpieza
                setTimeout(() => {
                    document.body.removeChild(link);
                    URL.revokeObjectURL(url);
                }, 100);
            }
        }

        // 10. Función para abrir modal de vista
        function previewActivity(uuid) {
            const modal = document.getElementById(`modal-${uuid}`);
            if (modal) {
                const modalInstance = new Modal(modal);
                modalInstance.show();
            }
        }
    </script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.1/flowbite.min.js"></script>

</body>
</html>