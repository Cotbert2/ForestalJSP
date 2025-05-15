<%-- Document : forestal_zones Created on : May 11, 2025, 9:12:07 PM Author : mateo --%>

    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@page contentType="text/html" pageEncoding="UTF-8" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <title>Forest Zones</title>
                <script src="https://cdn.tailwindcss.com"></script>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.1/flowbite.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/flowbite/dist/flowbite.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
                <script src="https://cdn.jsdelivr.net/npm/tom-select@2.3.1/dist/js/tom-select.complete.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" defer></script>

                <script src="https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.7.1/leaflet.js"></script>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/leaflet.draw/1.0.4/leaflet.draw.js"></script>

                <link href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.1/flowbite.min.css" rel="stylesheet" />
                <link rel="stylesheet" href="./styles/scrollbar.css">
                <link rel="stylesheet"
                    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" />
                <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" />
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.7.1/leaflet.css" />
                <link rel="stylesheet"
                    href="https://cdnjs.cloudflare.com/ajax/libs/leaflet.draw/1.0.4/leaflet.draw.css" />
                <link href="https://cdn.jsdelivr.net/npm/tom-select@2.3.1/dist/css/tom-select.css" rel="stylesheet" />

                <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/notyf@3/notyf.min.css">


                <link rel="icon" href="./assets/leave.png" type="image/x-icon">

            </head>

            <body class="bg-gray-50 text-gray-900 scroll-container">

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
                

                <!-- Modal New -->
                <div id="modalNew"
                    class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 hidden">
                    <div
                        class="bg-white rounded-lg w-full max-w-xl shadow-lg transform transition-all my-10 max-h-[90vh] overflow-hidden flex flex-col">
                        <div class="flex justify-between items-center border-b px-6 py-4 flex-shrink-0">
                            <h3 class="text-xl font-semibold text-green-800">Add Forest Zone</h3>
                            <button class="text-gray-500 hover:text-green-600 text-xl" data-modal-target="modalNew"
                                data-modal-toggle="modalNew">&times;</button>
                        </div>

                        <div class="p-6 overflow-y-auto flex-grow">
                            <form method="post" id="forestZoneForm" class="space-y-4">
                                <div>
                                    <label for="zoneName" class="block text-sm font-medium text-gray-700 mb-1">Zone
                                        Name</label>
                                    <div class="relative">
                                        <i class="fas fa-tree absolute left-3 top-3 text-gray-400"></i>
                                        <input type="text" id="zoneName" name="name" placeholder="Enter zone name"
                                            class="text-gray-400 w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500">
                                    </div>
                                </div>

                                <div>
                                    <label for="description"
                                        class="block text-sm font-medium text-gray-700 mb-1">Description</label>
                                    <div class="relative">
                                        <i class="fas fa-align-left absolute left-3 top-3 text-gray-400"></i>
                                        <input type="text" id="description" name="description"
                                            placeholder="Enter description"
                                            class="text-gray-400 w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500">
                                    </div>
                                </div>

                                <div>
                                    <label for="area" class="block text-sm font-medium text-gray-700 mb-1">Area
                                        (HA)</label>
                                    <div class="relative">
                                        <i class="fas fa-ruler-combined absolute left-3 top-3 text-gray-400"></i>
                                        <input type="number" id="area" name="area" placeholder="Enter area in hectares"
                                            class="text-gray-400 w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500">
                                    </div>
                                </div>

                                <div>
                                    <label for="image"
                                        class="block text-sm font-medium text-gray-700 mb-1">Image</label>
                                    <div class="relative">
                                        <i class="fa-solid fa-image absolute left-3 top-3 text-gray-400"></i>
                                        <input type="text" id="image" name="image" placeholder="Enter URL image"
                                            class="text-gray-400 w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500">
                                    </div>
                                </div>

                                <div>
                                    <label for="registerDate"
                                        class="block text-sm font-medium text-gray-700 mb-1">Register Date</label>
                                    <div class="relative">
                                        <i class="fa-solid fa-calendar absolute left-3 top-3 text-gray-400"></i>
                                        <input type="datetime-local" id="registerDate" name="register_date"
                                            class="text-gray-400 w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500"
                                            readonly>
                                    </div>
                                </div>

                                <div>
                                    <label for="map" class="block text-sm font-medium text-gray-700 mb-1">Select
                                        Area (This field cannot be edited)</label>
                                    <div id="map" class="rounded border" style="height: 400px; width: 100%;"></div>
                                    <input type="hidden" id="mapJson" name="map_json">
                                </div>
                            </form>
                        </div>

                        <div class="flex justify-end space-x-4 px-6 py-4 border-t flex-shrink-0">
                            <button data-modal-target="modalNew" data-modal-toggle="modalNew" type="button"
                                id="cancelBtn"
                                class="px-4 py-2 bg-gray-200 text-gray-700 rounded hover:bg-gray-300">Cancel</button>
                            <button type="submit" form="forestZoneForm"
                                class="px-4 py-2 bg-green-600 text-white rounded hover:bg-green-700">Save Forest
                                Zone</button>
                        </div>
                    </div>
                </div>


                <section class="max-w-7xl mx-auto py-16 px-4 sm:px-6 lg:px-8" id="forest-zones">
                    <div class="flex justify-between items-center mb-4">
                        <h2 class="text-3xl font-bold text-green-800">Forest Zones</h2>
                        <div class="flex">

                            <button onclick="downloadCSVFileFromTable('zonesTable', 'forestal_zones')"
                                class="bg-green-700 flex text-white px-4 py-2 rounded hover:bg-green-600 m-2">
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                                    stroke-width="1.5" stroke="currentColor" class="size-6">
                                    <path stroke-linecap="round" stroke-linejoin="round"
                                        d="M7.5 7.5h-.75A2.25 2.25 0 0 0 4.5 9.75v7.5a2.25 2.25 0 0 0 2.25 2.25h7.5a2.25 2.25 0 0 0 2.25-2.25v-7.5a2.25 2.25 0 0 0-2.25-2.25h-.75m-6 3.75 3 3m0 0 3-3m-3 3V1.5m6 9h.75a2.25 2.25 0 0 1 2.25 2.25v7.5a2.25 2.25 0 0 1-2.25 2.25h-7.5a2.25 2.25 0 0 1-2.25-2.25v-.75" />
                                </svg> Download CSV</button>


                            <button data-modal-target="modalNew" data-modal-toggle="modalNew"
                                class="bg-green-700 flex text-white px-4 py-2 rounded hover:bg-green-600 m-2">
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                                    stroke-width="1.5" stroke="currentColor" class="size-6">
                                    <path stroke-linecap="round" stroke-linejoin="round"
                                        d="M12 9v6m3-3H9m12 0a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z" />
                                </svg>New</button>
                        </div>
                    </div>

                    <div class="overflow-x-auto">
                        <table id="zonesTable" class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-gray-100">
                                <tr>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Name
                                    </th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                                        Description</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Area
                                        (ha)</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Register
                                        Date</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Actions
                                    </th>
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
                                            <button onclick='renderMap(`${currentZone.mapJson}`)'
                                                data-modal-target="modal-${currentZone.uuid}"
                                                data-modal-toggle="modal-${currentZone.uuid}"
                                                class="bg-green-600 text-white px-3 py-1 rounded hover:bg-green-500">
                                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                                                    stroke-width="1.5" stroke="currentColor" class="size-6">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        d="M2.036 12.322a1.012 1.012 0 0 1 0-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178Z" />
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
                                                </svg>

                                            </button>

                                            <button onclick="onDelete('${currentZone.uuid}')"
                                                class="bg-green-600 text-white px-3 py-1 rounded hover:bg-green-500">
                                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                                                    stroke-width="1.5" stroke="currentColor" class="size-6">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        d="m14.74 9-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 0 1-2.244 2.077H8.084a2.25 2.25 0 0 1-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 0 0-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 0 1 3.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 0 0-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 0 0-7.5 0" />
                                                </svg>


                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <c:forEach var="currentZone" items="${zones}">
                        <div id="modal-${currentZone.uuid}" tabindex="-1"
                            class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 w-full h-modal h-full bg-black/40">
                            <div class="relative p-4 w-full max-w-2xl max-h-[90vh] mx-auto overflow-y-auto">
                                <div class="bg-white rounded-lg shadow p-6 relative">
                                    <div
                                        class="sticky top-0 z-20 bg-white p-4 border-b border-gray-200 flex justify-between items-center">
                                        <h3 class="text-xl font-semibold text-green-700">Zone Information</h3>
                                        <button data-modal-hide="modal-${currentZone.uuid}"
                                            onclick="makeReadOnly('${currentZone.uuid}')" type="button"
                                            class="text-gray-400 hover:text-gray-900">
                                            <svg aria-hidden="true" class="w-6 h-6" fill="currentColor"
                                                viewBox="0 0 20 20">
                                                <path fill-rule="evenodd"
                                                    d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 011.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
                                                    clip-rule="evenodd"></path>
                                            </svg>
                                        </button>
                                    </div>
                                    <div class="
                              overflow-y-auto max-h-[75vh] p-6 space-y-4">
                                        <img src="${currentZone.image}" alt="Zone Image"
                                            class="rounded-lg mb-4 w-full h-60 object-cover">

                                        <div>
                                            <label for="mapView"
                                                class="block text-sm font-medium text-gray-700 mb-1">Location: </label>
                                            <div id="mapView" class="rounded border"
                                                style="height: 400px; width: 100%;"></div>
                                            <input type="hidden" id="mapViewJson" name="mapViewJson">
                                        </div>

                                        <div id="zone-info-${currentZone.uuid}" class="mb-4 space-y-2">
                                            <div class=" flex items-center gap-4">
                                                <strong class="w-32">Name:</strong>
                                                <i class="fas fa-tree  text-lg"></i>
                                                <input id="name-${currentZone.uuid}" readonly
                                                    class="text-gray-400 pl-3 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 w-full"
                                                    type="text" value="${currentZone.name}" />
                                            </div>

                                            <div class="flex items-center gap-4">
                                                <strong class="w-32">Description:</strong>
                                                <i class="fas fa-align-left  text-lg"></i>
                                                <input id="description-${currentZone.uuid}" readonly
                                                    class="text-gray-400 pl-3 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 w-full"
                                                    type="text" value="${currentZone.description}" />
                                            </div>

                                            <div class="flex items-center gap-4">
                                                <strong class="w-32">Area (ha):</strong>
                                                <i class="fas fa-ruler-combined  text-lg"></i>
                                                <input id="area-${currentZone.uuid}" readonly
                                                    class="text-gray-400 pl-3 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 w-full"
                                                    type="number" value="${currentZone.area}" />
                                            </div>

                                            <div class="flex items-center gap-4">
                                                <strong class="w-32">Register Date:</strong>
                                                <i class="fa-solid fa-calendar 0 text-lg"></i>
                                                <input id="register-date-${currentZone.uuid}" readonly
                                                    class="text-gray-400 pl-3 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 w-full"
                                                    type="datetime-local" value="${currentZone.registerDate}" />
                                            </div>

                                        </div>




                                        <h4 class="text-lg font-semibold text-gray-700 mb-2">Tree Species</h4>

                                        <c:choose>
                                            <c:when test="${not empty currentZone.trees}">
                                                <table id="table-${currentZone.uuid}"
                                                    class="min-w-full divide-y divide-gray-200 border">
                                                    <thead class="bg-gray-100">
                                                        <tr>
                                                            <th
                                                                class="px-4 py-2 text-left text-sm font-medium text-gray-500">
                                                                Species Name</th>
                                                            <th
                                                                class="px-4 py-2 text-left text-sm font-medium text-gray-500">
                                                                Scientific Name</th>
                                                            <th
                                                                class="px-4 py-2 text-left text-sm font-medium text-gray-500">
                                                                Actions</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody class="bg-white divide-y divide-gray-200">
                                                        <c:forEach var="tree" items="${currentZone.trees}">
                                                            <tr>
                                                                <td class="px-4 py-2">${tree.name}</td>
                                                                <td class="px-4 py-2">${tree.commonName}</td>
                                                                <td class="px-4 py-2">
                                                                    <button
                                                                        onclick="onDeleteTree('${currentZone.uuid}','${tree.uuid}')"
                                                                        class="bg-green-600 text-white px-3 py-1 rounded hover:bg-green-500">
                                                                        <svg xmlns="http://www.w3.org/2000/svg"
                                                                            fill="none" viewBox="0 0 24 24"
                                                                            stroke-width="1.5" stroke="currentColor"
                                                                            class="size-6">
                                                                            <path stroke-linecap="round"
                                                                                stroke-linejoin="round"
                                                                                d="m14.74 9-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 0 1-2.244 2.077H8.084a2.25 2.25 0 0 1-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 0 0-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 0 1 3.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 0 0-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 0 0-7.5 0" />
                                                                        </svg>
                                                                    </button>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                                <div class="my-3 flex justify-between items-center">
                                                    <div class="flex gap-3">
                                                        <button onclick="makeEditable('${currentZone.uuid}')"
                                                            class="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-500">
                                                            <svg xmlns="http://www.w3.org/2000/svg" fill="none"
                                                                viewBox="0 0 24 24" stroke-width="1.5"
                                                                stroke="currentColor" class="size-6">
                                                                <path stroke-linecap="round" stroke-linejoin="round"
                                                                    d="m16.862 4.487 1.687-1.688a1.875 1.875 0 1 1 2.652 2.652L10.582 16.07a4.5 4.5 0 0 1-1.897 1.13L6 18l.8-2.685a4.5 4.5 0 0 1 1.13-1.897l8.932-8.931Zm0 0L19.5 7.125M18 14v4.75A2.25 2.25 0 0 1 15.75 21H5.25A2.25 2.25 0 0 1 3 18.75V8.25A2.25 2.25 0 0 1 5.25 6H10" />
                                                            </svg>
                                                        </button>
                                                        <button id="btn-save-${currentZone.uuid}"
                                                            onclick="onUpdate('${currentZone.uuid}')"
                                                            class="hidden flex gap-1 bg-green-600 text-white px-4 py-2 rounded hover:bg-green-500">
                                                            <svg xmlns="http://www.w3.org/2000/svg" fill="none"
                                                                viewBox="0 0 24 24" stroke-width="1.5"
                                                                stroke="currentColor" class="size-6">
                                                                <path stroke-linecap="round" stroke-linejoin="round"
                                                                    d="M17.593 3.322c1.1.128 1.907 1.077 1.907 2.185V21L12 17.25 4.5 21V5.507c0-1.108.806-2.057 1.907-2.185a48.507 48.507 0 0 1 11.186 0Z" />
                                                            </svg>
                                                            Save
                                                        </button>
                                                    </div>

                                                    <button id="addTreeBtn-${currentZone.uuid}"
                                                        class="flex items-center gap-2 bg-green-600 text-white px-4 py-2 rounded hover:bg-green-500">
                                                        <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5"
                                                            fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                                                            stroke="currentColor">
                                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                                d="M12 9v6m3-3H9m12 0a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z" />
                                                        </svg>
                                                        Add Tree
                                                    </button>
                                                </div>

                                                <div id="treeSelectContainer-${currentZone.uuid}"
                                                    class="hidden opacity-0 transition-all duration-500 ease-in-out bg-white border border-gray-200 rounded-lg shadow-md p-4 mt-4 space-y-3">
                                                    <label for="tree"
                                                        class="block text-sm font-medium text-gray-700">Select
                                                        Tree</label>

                                                    <select id="treeSelect-${currentZone.uuid}" name="treeId"
                                                        placeholder="Select a tree..."
                                                        class="w-full px-4 py-2 border border-gray-300 rounded-md text-gray-700 focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500">
                                                        <option value="" selected disabled hidden></option>
                                                        <c:forEach var="currentTree" items="${trees}">
                                                            <c:set var="isAlreadyInZone" value="false" />

                                                            <c:forEach var="tree" items="${currentZone.trees}">
                                                                <c:if test="${currentTree.uuid == tree.uuid}">
                                                                    <c:set var="isAlreadyInZone" value="true" />
                                                                </c:if>
                                                            </c:forEach>

                                                            <c:if test="${!isAlreadyInZone}">
                                                                <option value="${currentTree.uuid}">
                                                                    ${currentTree.commonName}</option>
                                                            </c:if>
                                                        </c:forEach>
                                                    </select>

                                                    <div class="my-3 flex justify-end">
                                                        <button onclick="addNewTree('${currentZone.uuid}')"
                                                            class="px-4 py-2 bg-green-600 text-white rounded hover:bg-green-700 transition-colors duration-200">
                                                            Save
                                                        </button>
                                                    </div>

                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <p class="text-sm text-gray-500 italic">No trees added yet.</p>

                                                <div class="my-3 flex justify-between items-center">
                                                    <div class="flex gap-3">
                                                        <button onclick="makeEditable('${currentZone.uuid}')"
                                                            class="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-500">
                                                            <svg xmlns="http://www.w3.org/2000/svg" fill="none"
                                                                viewBox="0 0 24 24" stroke-width="1.5"
                                                                stroke="currentColor" class="size-6">
                                                                <path stroke-linecap="round" stroke-linejoin="round"
                                                                    d="m16.862 4.487 1.687-1.688a1.875 1.875 0 1 1 2.652 2.652L10.582 16.07a4.5 4.5 0 0 1-1.897 1.13L6 18l.8-2.685a4.5 4.5 0 0 1 1.13-1.897l8.932-8.931Zm0 0L19.5 7.125M18 14v4.75A2.25 2.25 0 0 1 15.75 21H5.25A2.25 2.25 0 0 1 3 18.75V8.25A2.25 2.25 0 0 1 5.25 6H10" />
                                                            </svg>
                                                        </button>
                                                        <button id="btn-save-${currentZone.uuid}"
                                                            onclick="onUpdate('${currentZone.uuid}')"
                                                            class="hidden flex gap-1 bg-green-600 text-white px-4 py-2 rounded hover:bg-green-500">
                                                            <svg xmlns="http://www.w3.org/2000/svg" fill="none"
                                                                viewBox="0 0 24 24" stroke-width="1.5"
                                                                stroke="currentColor" class="size-6">
                                                                <path stroke-linecap="round" stroke-linejoin="round"
                                                                    d="M17.593 3.322c1.1.128 1.907 1.077 1.907 2.185V21L12 17.25 4.5 21V5.507c0-1.108.806-2.057 1.907-2.185a48.507 48.507 0 0 1 11.186 0Z" />
                                                            </svg>
                                                            Save
                                                        </button>
                                                    </div>

                                                    <button id="addTreeBtn-${currentZone.uuid}"
                                                        class="flex items-center gap-2 bg-green-600 text-white px-4 py-2 rounded hover:bg-green-500">
                                                        <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5"
                                                            fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                                                            stroke="currentColor">
                                                            <path stroke-linecap="round" stroke-linejoin="round"
                                                                d="M12 9v6m3-3H9m12 0a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z" />

                                                        </svg>
                                                        Add Tree
                                                    </button>
                                                </div>


                                                <div id="treeSelectContainer-${currentZone.uuid}"
                                                    class="hidden opacity-0 transition-all duration-500 ease-in-out bg-white border border-gray-200 rounded-lg shadow-md p-4 mt-4 space-y-3">
                                                    <label for="tree"
                                                        class="block text-sm font-medium text-gray-700">Select
                                                        Tree</label>


                                                    <select id="treeSelect-${currentZone.uuid}" name="treeId"
                                                        placeholder="Select a tree..."
                                                        class="w-full px-4 py-2 border border-gray-300 rounded-md text-gray-700 focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500">
                                                        <option value="" selected disabled hidden></option>
                                                        <c:forEach var="currentTree" items="${trees}">
                                                            <option value="${currentTree.uuid}">
                                                                ${currentTree.commonName}</option>
                                                        </c:forEach>
                                                    </select>

                                                    <div class="my-3 flex justify-end">
                                                        <button onclick="addNewTree('${currentZone.uuid}')"
                                                            class="px-4 py-2 bg-green-600 text-white rounded hover:bg-green-700 transition-colors duration-200">
                                                            Save
                                                        </button>
                                                    </div>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>



                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    </table>
                    </div>
                </section>



                <form action="/forestal/forestal_zone" id="updateForm" method="post">
                    <input type="hidden" name="uuid" id="uuidUpdate">
                    <input type="hidden" name="name" id="nameUpdate">
                    <input type="hidden" name="description" id="descriptionUpdate">
                    <input type="hidden" name="area" id="areaUpdate">
                    <input type="hidden" name="register_date" id="registerDateUpdate">
                    <input type="hidden" name="_method" value="UPDATE">
                </form>

 

                <form action="/forestal/forestal_zone" id="deleteTreeForm" method="post">
                    <input type="hidden" name="uuidForestal" id="uuidForestal">
                    <input type="hidden" name="uuidTree" id="uuidTree">
                    <input type="hidden" name="_method" value="DELETE_TREE">
                </form>


                <form action="/forestal/forestal_zone" id="addNewTreeForm" method="post">
                    <input type="hidden" name="uuidForestal" id="uuidForestalAdd">
                    <input type="hidden" name="uuidTree" id="uuidTreeAdd">
                    <input type="hidden" name="_method" value="ADD_TREE">
                </form>

               



                <form action="/forestal/forestal_zone" id="deleteForm" method="post">
                    <input type="hidden" name="uuid" id="uuid">
                    <input type="hidden" name="_method" value="DELETE">
                </form>


            </body>
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/notyf@3/notyf.min.css">
            <script src="https://cdn.jsdelivr.net/npm/notyf@3/notyf.min.js"></script>

            <script src="./scripts/forestalZone.js"></script>
            <script src="./scripts/downloadCSV.js"></script>
            <script src="./scripts/toastrService.js"></script>


            </html>