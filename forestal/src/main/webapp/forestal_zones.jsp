<%-- 
    Document   : forestal_zones
    Created on : May 11, 2025, 9:12:07 PM
    Author     : mateo
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Forest Zones</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.1/flowbite.min.css" rel="stylesheet" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.1/flowbite.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/flowbite/dist/flowbite.min.js"></script>
        <!-- Simple-DataTables CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" />

        <link rel="icon" href="./assets/leave.png" type="image/x-icon">
    </head>
    <body class="bg-gray-50 text-gray-900">

        <header class="sticky top-0 z-50 bg-white shadow">
            <nav class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex justify-between items-center py-4">
                    <div class="text-2xl font-bold text-green-700">Run Forest, Run!</div>
                    <ul class="flex space-x-8 text-sm font-medium">
                        <li><a href="#forest-zones" class="hover:text-green-700">Forest Zones</a></li>
                    </ul>
                </div>
            </nav>
        </header>

        <section class="max-w-7xl mx-auto py-16 px-4 sm:px-6 lg:px-8" id="forest-zones">
            <div class="flex justify-between items-center mb-4">
                <h2 class="text-3xl font-bold text-green-800">Forest Zones</h2>
                <div class="flex">

                  <button onclick="downloadCSV()" class="bg-green-700 flex text-white px-4 py-2 rounded hover:bg-green-600 m-2">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                      <path stroke-linecap="round" stroke-linejoin="round" d="M7.5 7.5h-.75A2.25 2.25 0 0 0 4.5 9.75v7.5a2.25 2.25 0 0 0 2.25 2.25h7.5a2.25 2.25 0 0 0 2.25-2.25v-7.5a2.25 2.25 0 0 0-2.25-2.25h-.75m-6 3.75 3 3m0 0 3-3m-3 3V1.5m6 9h.75a2.25 2.25 0 0 1 2.25 2.25v7.5a2.25 2.25 0 0 1-2.25 2.25h-7.5a2.25 2.25 0 0 1-2.25-2.25v-.75" />
                    </svg> Download CSV</button>


                  <button onclick="downloadCSV()" class="bg-red-700 flex text-white px-4 py-2 rounded hover:bg-green-600 m-2">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                      <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v6m3-3H9m12 0a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z" />
                    </svg>New</button>
                  </div>
            </div>

            

            <!--input type="text" id="searchInput" onkeyup="filterTable()" placeholder="Search zones..." class="mb-4 p-2 border border-gray-300 rounded w-full" />
-->
            <div class="overflow-x-auto">
                <table id="zonesTable" class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-gray-100">
                        <tr>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Name</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Description</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Area (ha)</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Register Date</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-gray-200">
                        <c:forEach var="currentZone" items="${zones}">
                            <tr>
                                <td class="px-6 py-4">${currentZone.name}</td>
                                <td class="px-6 py-4">${currentZone.description}</td>
                                <td class="px-6 py-4">${currentZone.area}</td>
                                <td class="px-6 py-4">${currentZone.registerDate}</td>
                                <td class="px-6 py-4">
                                    <button 
                                        data-modal-target="previewModal" 
                                        data-modal-toggle="previewModal" 
                                        class="bg-blue-600 text-white px-3 py-1 rounded hover:bg-blue-500"
                                        onclick="populateModal('${currentZone.name}', '${currentZone.description}', '${currentZone.area}', '${currentZone.registerDate}', '${currentZone.image}')">Preview
                                        </button>
                                </td>
                            </tr>
                        </c:forEach>
                        <!-- Repeatable Rows -->
                    </tbody>
                </table>
            </div>
        </section>

        <!-- Modal -->
        <div id="previewModal" tabindex="-1" class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 w-full h-modal h-full bg-white/10">
            <div class="relative p-4 w-full max-w-2xl h-full md:h-auto mx-auto">
                <div class="bg-white rounded-lg shadow p-6 relative">
                    <button type="button" class="absolute top-2 right-2 text-gray-400 hover:text-gray-900" data-modal-hide="previewModal">
                        <svg aria-hidden="true" class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 011.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd"></path>
                        </svg>
                    </button>
                    <h3 class="text-xl font-semibold text-green-700 mb-4">Zone Information</h3>
                    <img id="modalImage" alt="Zone Image" class="rounded-lg mb-4">
                    <div class="mb-4">
                        <p><strong>Name:</strong> <span id="modalName"></span></p>
                        <p><strong>Description:</strong> <span id="modalDescription"></span></p>
                        <p><strong>Area:</strong> <span id="modalArea"></span></p>
                        <p><strong>Register Date:</strong> <span id="modalRegisterDate"></span></p>
                    </div>
                    <h4 class="text-lg font-semibold text-gray-700 mb-2">Tree Species</h4>
                    <table class="min-w-full divide-y divide-gray-200 border">
                        <thead class="bg-gray-100">
                            <tr>
                                <th class="px-4 py-2 text-left text-sm font-medium text-gray-500">Species Name</th>
                                <th class="px-4 py-2 text-left text-sm font-medium text-gray-500">Scientific Name</th>
                            </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                            <tr>
                                <td class="px-4 py-2">Cedar</td>
                                <td class="px-4 py-2"><em>Cedrela odorata</em></td>
                            </tr>
                            <tr>
                                <td class="px-4 py-2">Mahogany</td>
                                <td class="px-4 py-2"><em>Swietenia macrophylla</em></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <script>
            const downloadCSV = () => {
                const rows = document.querySelectorAll("#zonesTable tbody tr");
                if (!rows.length) {
                    alert("No data available to download.");
                    return;
                }

                let csv = "Name,Description,Area,Register Date\n";

                rows.forEach(row => {
                    const cells = row.querySelectorAll("td");
                    const values = Array.from(cells)
                            .slice(0, 4)
                            .map(cell => {
                                const text = cell?.innerText?.trim() ?? "";
                                return `"\${text.replace(/"/g, '""')}"`;
                            });
                    csv += values.join(",") + "\n";
                });

                const blob = new Blob([csv], {type: "text/csv;charset=utf-8;"});

                if (window.navigator.msSaveOrOpenBlob) {
                    window.navigator.msSaveBlob(blob, "forest_zones.csv");
                } else {
                    const link = document.createElement("a");
                    const url = URL.createObjectURL(blob);
                    link.setAttribute("href", url);
                    link.setAttribute("download", "forest_zones.csv");
                    document.body.appendChild(link);
                    link.click();
                    document.body.removeChild(link);
                    URL.revokeObjectURL(url);
                }
            };





            const filterTable = () => {
                const input = document.getElementById("searchInput").value.toLowerCase();
                const rows = document.querySelectorAll("#zonesTable tbody tr");
                rows.forEach(row => {
                    row.style.display = row.innerText.toLowerCase().includes(input) ? "" : "none";
                });
            }

            const populateModal = (name, description, area, registerDate, img) => {
                document.getElementById('modalName').innerText = name;
                document.getElementById('modalDescription').innerText = description;
                document.getElementById('modalArea').innerText = area + " ha";
                document.getElementById('modalImage').src = img
                document.getElementById('modalRegisterDate').innerText = registerDate;
            }
        </script>
        
<script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" defer></script>
<script>
    document.addEventListener("DOMContentLoaded",  () => {
      const table = document.querySelector("#zonesTable");
      new simpleDatatables.DataTable(table, {
        perPage: 5,
        perPageSelect: [5, 10, 25, 50],
        searchable: true,
        sortable: true,
      });
    });
</script>


    </body>
</html>
