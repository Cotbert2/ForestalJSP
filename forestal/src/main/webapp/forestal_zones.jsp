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
                    <div class="text-2xl font-bold text-green-700">Run Forest, Run!</div>
                    <ul class="flex space-x-8 text-sm font-medium">
                        <li><a href="#forest-zones" class="hover:text-green-700">Forest Zones</a></li>
                    </ul>
                </div>
            </nav>
        </header>

        <!-- Modal New -->
        <div id="modalNew" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 hidden">
            <div class="bg-white rounded-lg w-full max-w-xl shadow-lg transform transition-all my-10 max-h-[90vh] overflow-hidden flex flex-col">
                <div class="flex justify-between items-center border-b px-6 py-4 flex-shrink-0">
                    <h3 class="text-xl font-semibold text-green-800">Add Forest Zone</h3>
                    <button class="text-gray-500 hover:text-green-600 text-xl" data-modal-target="modalNew" data-modal-toggle="modalNew">&times;</button>
                </div>

                <div class="p-6 overflow-y-auto flex-grow">
                    <form method="post" id="forestZoneForm" class="space-y-4">
                        <div>
                            <label for="zoneName" class="block text-sm font-medium text-gray-700 mb-1">Zone Name</label>
                            <div class="relative">
                                <i class="fas fa-tree absolute left-3 top-3 text-gray-400"></i>
                                <input type="text" id="zoneName" name="name" placeholder="Enter zone name"
                                       class="text-gray-400 w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500">
                            </div>
                        </div>

                        <div>
                            <label for="description" class="block text-sm font-medium text-gray-700 mb-1">Description</label>
                            <div class="relative">
                                <i class="fas fa-align-left absolute left-3 top-3 text-gray-400"></i>
                                <input type="text" id="description" name="description" placeholder="Enter description"
                                       class="text-gray-400 w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500">
                            </div>
                        </div>

                        <div>
                            <label for="area" class="block text-sm font-medium text-gray-700 mb-1">Area (HA)</label>
                            <div class="relative">
                                <i class="fas fa-ruler-combined absolute left-3 top-3 text-gray-400"></i>
                                <input type="number" id="area" name="area" placeholder="Enter area in hectares"
                                       class="text-gray-400 w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500">
                            </div>
                        </div>

                        <div>
                            <label for="image" class="block text-sm font-medium text-gray-700 mb-1">Image</label>
                            <div class="relative">
                                <i class="fa-solid fa-image absolute left-3 top-3 text-gray-400"></i>
                                <input type="text" id="image" name="image" placeholder="Enter URL image"
                                       class="text-gray-400 w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500">
                            </div>
                        </div>

                        <div>
                            <label for="registerDate" class="block text-sm font-medium text-gray-700 mb-1">Register Date</label>
                            <div class="relative">
                              <i class="fa-solid fa-calendar absolute left-3 top-3 text-gray-400"></i>
                              <input type="datetime-local" id="registerDate" name="register_date"
                                     class="text-gray-400 w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500"
                                     readonly>
                            </div>
                          </div>

                        <div>
                            <label for="map" class="block text-sm font-medium text-gray-700 mb-1">Select Area</label>
                            <div id="map" class="rounded border" style="height: 400px; width: 100%;"></div>
                            <input type="hidden" id="mapJson" name="map_json">
                        </div>
                    </form>
                </div>

                <div class="flex justify-end space-x-4 px-6 py-4 border-t flex-shrink-0">
                    <button data-modal-target="modalNew" data-modal-toggle="modalNew" type="button" id="cancelBtn"
                            class="px-4 py-2 bg-gray-200 text-gray-700 rounded hover:bg-gray-300">Cancel</button>
                    <button type="submit" form="forestZoneForm"
                            class="px-4 py-2 bg-green-600 text-white rounded hover:bg-green-700">Save Forest Zone</button>
                </div>
            </div>
        </div>


        <section class="max-w-7xl mx-auto py-16 px-4 sm:px-6 lg:px-8" id="forest-zones">
            <div class="flex justify-between items-center mb-4">
                <h2 class="text-3xl font-bold text-green-800">Forest Zones</h2>
                <div class="flex">

                    <button onclick="downloadCSV()" class="bg-green-700 flex text-white px-4 py-2 rounded hover:bg-green-600 m-2">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M7.5 7.5h-.75A2.25 2.25 0 0 0 4.5 9.75v7.5a2.25 2.25 0 0 0 2.25 2.25h7.5a2.25 2.25 0 0 0 2.25-2.25v-7.5a2.25 2.25 0 0 0-2.25-2.25h-.75m-6 3.75 3 3m0 0 3-3m-3 3V1.5m6 9h.75a2.25 2.25 0 0 1 2.25 2.25v7.5a2.25 2.25 0 0 1-2.25 2.25h-7.5a2.25 2.25 0 0 1-2.25-2.25v-.75" />
                        </svg> Download CSV</button>


                    <button data-modal-target="modalNew" data-modal-toggle="modalNew" class="bg-green-700 flex text-white px-4 py-2 rounded hover:bg-green-600 m-2">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v6m3-3H9m12 0a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z" />
                        </svg>New</button>
                </div>
            </div>

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
                                        data-modal-target="modal-${currentZone.uuid}"
                                        data-modal-toggle="modal-${currentZone.uuid}"
                                        class="bg-green-600 text-white px-3 py-1 rounded hover:bg-green-500">
                                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                                        <path stroke-linecap="round" stroke-linejoin="round" d="M2.036 12.322a1.012 1.012 0 0 1 0-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178Z" />
                                        <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
                                        </svg>

                                    </button>

                                    <button
                                        onclick="onDelete('${currentZone.uuid}')"
                                        class="bg-green-600 text-white px-3 py-1 rounded hover:bg-green-500"
                                        >
                                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                                        <path stroke-linecap="round" stroke-linejoin="round" d="m14.74 9-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 0 1-2.244 2.077H8.084a2.25 2.25 0 0 1-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 0 0-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 0 1 3.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 0 0-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 0 0-7.5 0" />
                                        </svg>


                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <c:forEach var="currentZone" items="${zones}">
                <div id="modal-${currentZone.uuid}" tabindex="-1" class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 w-full h-modal h-full bg-black/40">
                    <div class="relative p-4 w-full max-w-2xl max-h-[90vh] mx-auto overflow-y-auto">
                        <div class="bg-white rounded-lg shadow p-6 relative">
                            <div class="sticky top-0 z-20 bg-white p-4 border-b border-gray-200 flex justify-between items-center">
                                <h3 class="text-xl font-semibold text-green-700">Zone Information</h3>
                                <button data-modal-hide="modal-${currentZone.uuid}" onclick="makeReadOnly('${currentZone.uuid}')" type="button" class="text-gray-400 hover:text-gray-900">
                                  <svg aria-hidden="true" class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 011.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd"></path>
                                  </svg>
                                </button>
                              </div>
                              <div class="overflow-y-auto max-h-[75vh] p-6 space-y-4">
                                        <img src="${currentZone.image}" alt="Zone Image" class="rounded-lg mb-4 w-full h-60 object-cover">

                                       <div id="zone-info-${currentZone.uuid}" class="mb-4 space-y-2">
                                            <div class=" flex items-center gap-4">
                                              <strong class="w-32">Name:</strong>
                                              <i class="fas fa-tree  text-lg"></i>
                                              <input
                                                id="name-${currentZone.uuid}"
                                                readonly
                                                class="text-gray-400 pl-3 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 w-full"
                                                type="text"
                                                value="${currentZone.name}"
                                              />
                                            </div>

                                            <div class="flex items-center gap-4">
                                              <strong class="w-32">Description:</strong>
                                              <i class="fas fa-align-left  text-lg"></i>
                                              <input
                                                  id="description-${currentZone.uuid}"
                                                readonly
                                                class="text-gray-400 pl-3 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 w-full"
                                                type="text"
                                                value="${currentZone.description}"
                                              />
                                            </div>

                                            <div class="flex items-center gap-4">
                                              <strong class="w-32">Area (ha):</strong>
                                              <i class="fas fa-ruler-combined  text-lg"></i>
                                              <input
                                                  id="area-${currentZone.uuid}"
                                                readonly
                                                class="text-gray-400 pl-3 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 w-full"
                                                type="number"
                                                value="${currentZone.area}"
                                              />
                                            </div>

                                            <div class="flex items-center gap-4">
                                              <strong class="w-32">Register Date:</strong>
                                              <i class="fa-solid fa-calendar 0 text-lg"></i>
                                              <input
                                                  id="register-date-${currentZone.uuid}"
                                                readonly
                                                class="text-gray-400 pl-3 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 w-full"
                                                type="datetime-local"
                                                value="${currentZone.registerDate}"
                                              />
                                            </div>

                                          </div>




                                        <h4 class="text-lg font-semibold text-gray-700 mb-2">Tree Species</h4>

                                        <c:choose>
                                            <c:when test="${not empty currentZone.trees}">
                                                <table id="table-${currentZone.uuid}" class="min-w-full divide-y divide-gray-200 border">
                                                    <thead class="bg-gray-100">
                                                        <tr>
                                                            <th class="px-4 py-2 text-left text-sm font-medium text-gray-500">Species Name</th>
                                                            <th class="px-4 py-2 text-left text-sm font-medium text-gray-500">Scientific Name</th>
                                                            <th class="px-4 py-2 text-left text-sm font-medium text-gray-500">Actions</th>
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
                                                                        class="bg-green-600 text-white px-3 py-1 rounded hover:bg-green-500"
                                                                        >
                                                                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                                                                        <path stroke-linecap="round" stroke-linejoin="round" d="m14.74 9-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 0 1-2.244 2.077H8.084a2.25 2.25 0 0 1-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 0 0-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 0 1 3.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 0 0-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 0 0-7.5 0" />
                                                                        </svg>
                                                                    </button>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                               <div class="my-3 flex justify-between items-center">
                                                   <div class="flex gap-3">
                                                       <button onclick="makeEditable('${currentZone.uuid}')" class="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-500">
                                                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                                                             <path stroke-linecap="round" stroke-linejoin="round" d="m16.862 4.487 1.687-1.688a1.875 1.875 0 1 1 2.652 2.652L10.582 16.07a4.5 4.5 0 0 1-1.897 1.13L6 18l.8-2.685a4.5 4.5 0 0 1 1.13-1.897l8.932-8.931Zm0 0L19.5 7.125M18 14v4.75A2.25 2.25 0 0 1 15.75 21H5.25A2.25 2.25 0 0 1 3 18.75V8.25A2.25 2.25 0 0 1 5.25 6H10" />
                                                           </svg>
                                                    </button>
                                                       <button id="btn-save-${currentZone.uuid}" onclick="onUpdate('${currentZone.uuid}')" class="hidden flex gap-1 bg-green-600 text-white px-4 py-2 rounded hover:bg-green-500">
                                                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                                                                <path stroke-linecap="round" stroke-linejoin="round" d="M17.593 3.322c1.1.128 1.907 1.077 1.907 2.185V21L12 17.25 4.5 21V5.507c0-1.108.806-2.057 1.907-2.185a48.507 48.507 0 0 1 11.186 0Z" />
                                                              </svg>
                                                                Save
                                                            </button>
                                                   </div>
                                                                
                                                    <button id="addTreeBtn-${currentZone.uuid}" class="flex items-center gap-2 bg-green-600 text-white px-4 py-2 rounded hover:bg-green-500">
                                                        <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                                                            <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v6m3-3H9m12 0a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z" />
                                                        </svg>
                                                        Add Tree
                                                    </button> 
                                                </div>

                                                <div id="treeSelectContainer-${currentZone.uuid}" class="hidden opacity-0 transition-all duration-500 ease-in-out bg-white border border-gray-200 rounded-lg shadow-md p-4 mt-4 space-y-3">
                                                    <label for="tree" class="block text-sm font-medium text-gray-700">Select Tree</label>

                                                    <select id="treeSelect-${currentZone.uuid}" name="treeId" placeholder="Select a tree..."
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
                                                                <option value="${currentTree.uuid}">${currentTree.commonName}</option>
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
                                                       <button onclick="makeEditable('${currentZone.uuid}')" class="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-500">
                                                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                                                             <path stroke-linecap="round" stroke-linejoin="round" d="m16.862 4.487 1.687-1.688a1.875 1.875 0 1 1 2.652 2.652L10.582 16.07a4.5 4.5 0 0 1-1.897 1.13L6 18l.8-2.685a4.5 4.5 0 0 1 1.13-1.897l8.932-8.931Zm0 0L19.5 7.125M18 14v4.75A2.25 2.25 0 0 1 15.75 21H5.25A2.25 2.25 0 0 1 3 18.75V8.25A2.25 2.25 0 0 1 5.25 6H10" />
                                                           </svg>
                                                    </button>
                                                       <button id="btn-save-${currentZone.uuid}" onclick="onUpdate('${currentZone.uuid}')" class="hidden flex gap-1 bg-green-600 text-white px-4 py-2 rounded hover:bg-green-500">
                                                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                                                                <path stroke-linecap="round" stroke-linejoin="round" d="M17.593 3.322c1.1.128 1.907 1.077 1.907 2.185V21L12 17.25 4.5 21V5.507c0-1.108.806-2.057 1.907-2.185a48.507 48.507 0 0 1 11.186 0Z" />
                                                              </svg>
                                                                Save
                                                            </button>
                                                   </div>
                                                                
                                                    <button id="addTreeBtn-${currentZone.uuid}" class="flex items-center gap-2 bg-green-600 text-white px-4 py-2 rounded hover:bg-green-500">
                                                        <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                                                            <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v6m3-3H9m12 0a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z" />
                                                        </svg>
                                                        Add Tree
                                                    </button> 
                                                </div>

                                                <div id="treeSelectContainer-${currentZone.uuid}" class="hidden opacity-0 transition-all duration-500 ease-in-out bg-white border border-gray-200 rounded-lg shadow-md p-4 mt-4 space-y-3">
                                                    <label for="tree" class="block text-sm font-medium text-gray-700">Select Tree</label>

                                                    <select id="treeSelect-${currentZone.uuid}" name="treeId" placeholder="Select a tree..."
                                                            class="w-full px-4 py-2 border border-gray-300 rounded-md text-gray-700 focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500">
                                                        <option value="" selected disabled hidden></option>
                                                        <c:forEach var="currentTree" items="${trees}">
                                                            <option value="${currentTree.uuid}">${currentTree.commonName}</option>
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
       
<script src="https://cdn.jsdelivr.net/npm/tom-select@2.3.1/dist/js/tom-select.complete.min.js"></script>


<form action="/forestal/forestal_zone" id="updateForm" method="post">
    <input type="hidden" name="uuid" id="uuidUpdate">
    <input type="hidden" name="name" id="nameUpdate">
    <input type="hidden" name="description" id="descriptionUpdate">
    <input type="hidden" name="area" id="areaUpdate">
    <input type="hidden" name="register_date" id="registerDateUpdate">
    <input type="hidden" name="_method" value="UPDATE">
</form>

<script>
    const onUpdate = (uuid) => {
        const name = document.getElementById('name-'+uuid).value;
        const description = document.getElementById('description-'+uuid).value;
        const area = document.getElementById('area-'+uuid).value;
        const registerDate = document.getElementById('register-date-'+uuid).value;
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
                document.getElementById('nameUpdate').value = name;
                document.getElementById('descriptionUpdate').value = description;
                document.getElementById('areaUpdate').value = area;
                document.getElementById('registerDateUpdate').value = registerDate;
                document.getElementById('updateForm').submit();
            }
        });
    };
</script>

<form action="/forestal/forestal_zone" id="deleteTreeForm" method="post">
    <input type="hidden" name="uuidForestal" id="uuidForestal">
    <input type="hidden" name="uuidTree" id="uuidTree">
    <input type="hidden" name="_method" value="DELETE_TREE">
</form>

<script>
    
    const activeEdit = false;

    const makeEditable = (uuid) => {
        const inputs = document.querySelectorAll("#zone-info-" + uuid + " input");
        
        const saveBtn = document.querySelector("#btn-save-" + uuid);
        saveBtn.classList.toggle("hidden");
        if(inputs){
            inputs.forEach(input => {
                input.toggleAttribute("readonly");
                input.classList.toggle("text-gray-400");
            });
            inputs[0].focus();
        }else{
            console.log("error xd");
        }
    };
    
    const makeReadOnly = (uuid) => {
        const inputs = document.querySelectorAll("#zone-info-" + uuid + " input");
        const saveBtn = document.querySelector("#btn-save-" + uuid);
        saveBtn.classList.toggle("hidden");
        if(inputs){
            inputs.forEach(input => {
                if(!input.hasAttribute("readonly")){
                    input.setAttribute("readonly","");
                    input.classList.toggle("text-gray-400");
                    input.focus();
                }
            });
            inputs[0].focus();
        }else{
            console.log("error xd");
        }
    };
</script>

<script>
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
</script>

<form action="/forestal/forestal_zone" id="addNewTreeForm" method="post">
    <input type="hidden" name="uuidForestal" id="uuidForestalAdd">
    <input type="hidden" name="uuidTree" id="uuidTreeAdd">
    <input type="hidden" name="_method" value="ADD_TREE">
</form>

<script>
  function addNewTree(uuidForestal) {
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
</script>

<script>
  document.addEventListener('DOMContentLoaded', () => {
    const now = new Date();

    const ecuadorOffset = -5 * 60; 
    const localTime = new Date(now.getTime() + (ecuadorOffset - now.getTimezoneOffset()) * 60000);

    const formatted = localTime.toISOString().slice(0, 16);

    const input = document.getElementById('registerDate');
    input.value = formatted;
    input.readOnly = true;
  });
</script>


<script>
  document.addEventListener("DOMContentLoaded", () => {
    document.querySelectorAll('[id^="treeSelect-"]').forEach(selectElement => {
        new TomSelect(selectElement, {
            create: false,
            allowEmptyOption: true,
            maxOptions: 100
        });
    });

    document.querySelectorAll('[id^="addTreeBtn-"]').forEach(btn => {
        btn.addEventListener('click', function() {
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

</script>

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

</script>

<script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" defer></script>
<script>
    document.addEventListener("DOMContentLoaded", () => {
        const table = document.querySelector("#zonesTable");
        new simpleDatatables.DataTable(table, {
            perPage: 5,
            perPageSelect: [5, 10, 25, 50],
            searchable: true,
            sortable: true,
        });
    });
</script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.7.1/leaflet.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/leaflet.draw/1.0.4/leaflet.draw.js"></script>



<script>
    document.getElementById('forestZoneForm').addEventListener('submit', function (e) {
        e.preventDefault();

        let isValid = true;
        const form = e.target;

        const zoneName = form.zoneName.value.trim();
        const description = form.description.value.trim();
        const area = parseFloat(form.area.value);
        const image = form.image.value.trim();
        const registerDate = form.registerDate.value.trim();
        const mapJson = form.mapJson.value.trim();

        [...form.elements].forEach(el => el.classList.remove('border-green-500'));

        if (zoneName === "") {
            isValid = false;
            form.zoneName.classList.add('border-green-500');
        }

        if (description === "") {
            isValid = false;
            form.description.classList.add('border-green-500');
        }

        if (isNaN(area) || area <= 0) {
            isValid = false;
            form.area.classList.add('border-green-500');
        }

        if (image === "") {
            isValid = false;
            form.image.classList.add('border-green-500');
        }

        if (registerDate === "") {
            isValid = false;
            form.registerDate.classList.add('border-green-500');
        }

        if (!isValid) {
            alert('Please correct the highlighted fields.');
            return;
        }

        if (!isValid) {
            alert("Formulario válido. Enviar datos...");
            return;
        }

        form.submit();
    });
</script>

<form action="/forestal/forestal_zone" id="deleteForm" method="post">
    <input type="hidden" name="uuid" id="uuid">
    <input type="hidden" name="_method" value="DELETE">
</form>

<script>
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
</script>


<script>
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

                map.on('draw:created', function (event) {
                    const layer = event.layer;
                    drawnItems.addLayer(layer);

                    const geoJsonData = layer.toGeoJSON();
                    document.getElementById('mapJson').value = JSON.stringify(geoJsonData);
                });

                mapInitialized = true;
            } else {
                map.invalidateSize(); // recalcula tamaño si ya existe
            }
        }, 300); // Espera que el modal se abra visualmente
    });
});
</script>


</body>
</html>
