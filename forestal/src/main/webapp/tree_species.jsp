<%--
Document   : tree\_species
Created on : May 12, 2025, 2:44:03 PM
Author     : jeffersonyepez
\--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Tree Species</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.1/flowbite.min.css" rel="stylesheet" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.1/flowbite.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/flowbite/dist/flowbite.min.js"></script>

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.7.1/leaflet.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/leaflet.draw/1.0.4/leaflet.draw.css" />
        <link href="https://cdn.jsdelivr.net/npm/tom-select@2.3.1/dist/css/tom-select.css" rel="stylesheet" />

        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/notyf@3/notyf.min.css">

        <link rel="icon" href="./assets/leave.png" type="image/x-icon">
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

        <h1 class="text-3xl md:text-4xl font-bold text-green-700 tracking-tight text-center mb-6">
            ${user.roleUsers} Panel
        </h1>
        <section class="max-w-7xl mx-auto py-16 px-4 sm:px-6 lg:px-8" id="tree-species">
            <div class="flex justify-between items-center mb-4">
                <h2 class="text-3xl font-bold text-green-800">Tree Species</h2>
                <div class="flex">
                    <button onclick="downloadCSVFileFromTable('treesTable', 'tree_species')" class="bg-green-700 flex text-white px-4 py-2 rounded hover:bg-green-600 m-2">

                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M7.5 7.5h-.75A2.25 2.25 0 0 0 4.5 9.75v7.5a2.25 2.25 0 0 0 2.25 2.25h7.5a2.25 2.25 0 0 0 2.25-2.25v-7.5a2.25 2.25 0 0 0-2.25-2.25h-.75m-6 3.75 3 3m0 0 3-3m-3 3V1.5m6 9h.75a2.25 2.25 0 0 1 2.25 2.25v7.5a2.25 2.25 0 0 1-2.25 2.25h-7.5a2.25 2.25 0 0 1-2.25-2.25v-.75" />
                        </svg> Download CSV</button>

                    <c:if test="${user.roleUsers == 'ADMIN' || user.roleUsers == 'ROOT'}">

                        <button data-modal-target="modalNew" data-modal-toggle="modalNew" class="bg-green-700 flex text-white px-4 py-2 rounded hover:bg-green-600 m-2">
                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v6m3-3H9m12 0a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z" />
                            </svg>New</button>
                        </c:if>
                </div>


            </div>

            <div class="overflow-x-auto">
                <table id="treesTable" class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-gray-100">
                        <tr>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Name</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Common Name</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Family</th>


                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Order Name</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Habitat</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Description</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-gray-200">
                        <c:forEach var="currentTree" items="${trees}">
                            <tr>
                                <td class="px-6 py-4">${currentTree.name}</td>
                                <td class="px-6 py-4">${currentTree.commonName}</td>
                                <td class="px-6 py-4">${currentTree.family}</td>

                                <td class="px-6 py-4">${currentTree.orderName}</td>
                                <td class="px-6 py-4">${currentTree.habitat}</td>
                                <td class="px-6 py-4">${currentTree.description}</td>
                                <td class="px-6 py-4">
                                    <button 
                                        data-modal-target="modal-${currentTree.uuid}"
                                        data-modal-toggle="modal-${currentTree.uuid}"
                                        class="bg-green-600 text-white px-3 py-1 rounded hover:bg-green-500">
                                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                                        <path stroke-linecap="round" stroke-linejoin="round" d="M2.036 12.322a1.012 1.012 0 0 1 0-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178Z" />
                                        <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
                                        </svg>

                                    </button>
                                    <c:if test="${user.roleUsers == 'ADMIN' || user.roleUsers == 'ROOT'}">

                                        <button
                                            onclick="onDelete('${currentTree.uuid}')"
                                            class="bg-green-600 text-white px-3 py-1 rounded hover:bg-green-500"
                                            >
                                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                                            <path stroke-linecap="round" stroke-linejoin="round" d="m14.74 9-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 0 1-2.244 2.077H8.084a2.25 2.25 0 0 1-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 0 0-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 0 1 3.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 0 0-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 0 0-7.5 0" />
                                            </svg>


                                        </button>
                                    </c:if>
                                </td>
                            </tr>

                        </c:forEach>
                        <!-- Repeatable Rows -->
                    </tbody>
                </table>


            </div>
        </section>

        <!-- Modal New -->

        <div id="modalNew" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 hidden">
            <div class="bg-white rounded-lg w-full max-w-xl shadow-lg transform transition-all my-10 max-h-[90vh] overflow-hidden flex flex-col">
                <div class="flex justify-between items-center border-b px-6 py-4 flex-shrink-0">
                    <h3 class="text-xl font-semibold text-green-800">Add Tree Species</h3>
                    <button class="text-gray-500 hover:text-green-600 text-xl" data-modal-target="modalNew" data-modal-toggle="modalNew">&times;</button>
                </div>


                <div class="p-6 overflow-y-auto flex-grow">
                    <form method="post" id="treeSpeciesForm" class="space-y-4">
                        <div>
                            <label for="treeSpeciesName" class="block text-sm font-medium text-gray-700 mb-1">Tree Species Name</label>
                            <div class="relative">
                                <i class="fas fa-tree absolute left-3 top-3 text-gray-400"></i>
                                <input type="text" id="treeSpeciesName" name="name" placeholder="Enter Tree Species Name"
                                       class="text-gray-400 w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500">
                            </div>
                        </div>

                        <div>
                            <label for="commonTreeSpeciesName" class="block text-sm font-medium text-gray-700 mb-1">Common Tree Species Name</label>
                            <div class="relative">
                                <i class="fas fa-tree absolute left-3 top-3 text-gray-400"></i>
                                <input type="text" id="commonTreeSpeciesName" name="commonName" placeholder="Enter Common Tree Species Name"
                                       class="text-gray-400 w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500">
                            </div>
                        </div>

                        <div>
                            <label for="familyTreeSpecies" class="block text-sm font-medium text-gray-700 mb-1">Family Tree Species</label>
                            <div class="relative">
                                <i class="fas fa-align-left absolute left-3 top-3 text-gray-400"></i>
                                <input type="text" id="familyTreeSpecies" name="family" placeholder="Enter Family Tree Species"
                                       class="text-gray-400 w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500">
                            </div>
                        </div>

                        <div>
                            <label for="originTreeSpecies" class="block text-sm font-medium text-gray-700 mb-1">Origin Tree Species</label>
                            <select id="originTreeSpecies" name="origin"
                                    class="w-full px-3 py-2 border border-gray-300 rounded-lg text-gray-700 focus:outline-none focus:ring-2 focus:ring-green-500">
                                <c:forEach var="origin" items="${origins}">
                                    <option value="${origin.uuid_origin}">${origin.name_origin}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div>
                            <label for="orderNameTreeSpecies" class="block text-sm font-medium text-gray-700 mb-1">Order Name Tree Species</label>
                            <div class="relative">
                                <i class="fas fa-align-left absolute left-3 top-3 text-gray-400"></i>
                                <input type="text" id="orderTreeSpecies" name="orderName" placeholder="Enter Order Name Tree Species"
                                       class="text-gray-400 w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500">
                            </div>
                        </div>

                        <div>
                            <label for="habitatTreeSpecies" class="block text-sm font-medium text-gray-700 mb-1">Habitat Tree Species</label>
                            <div class="relative">
                                <i class="fas fa-align-left absolute left-3 top-3 text-gray-400"></i>
                                <input type="text" id="habitatTreeSpecies" name="habitat" placeholder="Enter Habitat Tree Species"
                                       class="text-gray-400 w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500">
                            </div>
                        </div>

                        <div>
                            <label for="descriptionTreeSpecies" class="block text-sm font-medium text-gray-700 mb-1">Description Tree Species</label>
                            <div class="relative">
                                <i class="fas fa-align-left absolute left-3 top-3 text-gray-400"></i>
                                <input type="text" id="descriptionTreeSpecies" name="description" placeholder="Enter Description Tree Species"
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

                    </form>
                </div>

                <div class="flex justify-end space-x-4 px-6 py-4 border-t flex-shrink-0">
                    <button data-modal-target="modalNew" data-modal-toggle="modalNew" type="button" id="cancelBtn"
                            class="px-4 py-2 bg-gray-200 text-gray-700 rounded hover:bg-gray-300">Cancel</button>
                    <button type="submit" form="treeSpeciesForm"
                            class="px-4 py-2 bg-green-600 text-white rounded hover:bg-green-700">Save Tree Specie</button>
                </div>


            </div>


        </div>

        <c:forEach var="currentTree" items="${trees}"> 
            <div id="modal-${currentTree.uuid}" tabindex="-1" class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 w-full h-modal h-full bg-black/40"> <div class="relative p-4 w-full max-w-2xl h-full md:h-auto mx-auto"> 
                    <div class="bg-white rounded-lg shadow-lg max-w-lg w-full p-6 relative"> 

                        <h3 class="text-xl font-semibold text-green-700 mb-4">Tree Species Information</h3>
                        <button data-modal-hide="modal-${currentTree.uuid}" onclick="makeReadOnly('${currentTree.uuid}')" class="absolute top-3 right-3 text-gray-500 hover:text-gray-800" data-modal-hide="modal-${currentTree.uuid}"> 
                            <svg class="w-6 h-6" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"> 
                            <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12"/> 
                            </svg> 
                        </button> 


                        <div class="overflow-y-auto max-h-[75vh] p-6 space-y-4">
                            <img src="${currentTree.image}" alt="Tree Image" class="w-full h-48 object-cover rounded mb-4" />

                            <div id="tree-info-${currentTree.uuid}" class="mb-4 space-y-2">
                                <div class=" flex items-center gap-4">
                                    <strong class="w-32">Name:</strong>
                                    <i class="fas fa-tree  text-lg"></i>
                                    <input
                                        id="name-${currentTree.uuid}"
                                        readonly
                                        class="text-gray-400 pl-3 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 w-full"
                                        type="text"
                                        value="${currentTree.name}"
                                        />
                                </div>

                                <div class=" flex items-center gap-4">
                                    <strong class="w-32">Common Name:</strong>
                                    <i class="fas fa-tree  text-lg"></i>
                                    <input
                                        id="commonName-${currentTree.uuid}"
                                        readonly
                                        class="text-gray-400 pl-3 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 w-full"
                                        type="text"
                                        value="${currentTree.commonName}"
                                        />
                                </div>

                                <div class=" flex items-center gap-4">
                                    <strong class="w-32">Family:</strong>
                                    <i class="fas fa-tree  text-lg"></i>
                                    <input
                                        id="family-${currentTree.uuid}"
                                        readonly
                                        class="text-gray-400 pl-3 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 w-full"
                                        type="text"
                                        value="${currentTree.family}"
                                        />
                                </div>

                                <div class=" flex items-center gap-4">
                                    <strong class="w-32">Order Name:</strong>
                                    <i class="fas fa-tree  text-lg"></i>
                                    <input
                                        id="orderName-${currentTree.uuid}"
                                        readonly
                                        class="text-gray-400 pl-3 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 w-full"
                                        type="text"
                                        value="${currentTree.orderName}"
                                        />
                                </div>

                                <div class="flex items-center gap-4">
                                    <strong class="w-32">Origin:</strong>
                                    <i class="fas fa-globe-americas text-lg"></i>

                                    <select
                                        id="origin-${currentTree.uuid}"
                                        disabled
                                        class="text-gray-400 w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500">
                                        <c:forEach var="origin" items="${origins}">
                                            <option value="${origin.uuid_origin}" 
                                                    <c:if test="${origin.uuid_origin == currentTree.origin}">selected</c:if>>
                                                ${origin.name_origin}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>



                                <div class=" flex items-center gap-4">
                                    <strong class="w-32">Habitat:</strong>
                                    <i class="fas fa-tree  text-lg"></i>
                                    <input
                                        id="habitat-${currentTree.uuid}"
                                        readonly
                                        class="text-gray-400 pl-3 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 w-full"
                                        type="text"
                                        value="${currentTree.habitat}"
                                        />
                                </div>

                                <div class=" flex items-center gap-4">
                                    <strong class="w-32">Description:</strong>
                                    <i class="fas fa-tree  text-lg"></i>
                                    <input
                                        id="description-${currentTree.uuid}"
                                        readonly
                                        class="text-gray-400 pl-3 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 w-full"
                                        type="text"
                                        value="${currentTree.description}"
                                        />
                                </div>


                            </div>
                        </div>

                        <h4 class="text-lg font-semibold text-gray-700 mb-2">Forestal Zone</h4>



                        <c:choose>
                            <c:when test="${not empty currentTree.zones}">
                                <table id="table-${currentTree.uuid}" class="min-w-full divide-y divide-gray-200 border">
                                    <thead class="bg-gray-100">
                                        <tr>
                                            <th class="px-4 py-2 text-left text-sm font-medium text-gray-500">Zone Name</th>
                                            <th class="px-4 py-2 text-left text-sm font-medium text-gray-500">Description</th>
                                            <th class="px-4 py-2 text-left text-sm font-medium text-gray-500">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody class="bg-white divide-y divide-gray-200">
                                        <c:forEach var="zone" items="${currentTree.zones}">
                                            <tr>
                                                <td class="px-4 py-2">${zone.name}</td>
                                                <td class="px-4 py-2">${zone.description}</td>
                                                <td class="px-4 py-2">
                                                    <c:if test="${user.roleUsers == 'ADMIN' || user.roleUsers == 'ROOT'}">

                                                        <button
                                                            onclick="onDeleteZone('${currentTree.uuid}', '${zone.uuid}')"
                                                            class="bg-green-600 text-white px-3 py-1 rounded hover:bg-green-500"
                                                            >
                                                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                                                            <path stroke-linecap="round" stroke-linejoin="round" d="m14.74 9-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 0 1-2.244 2.077H8.084a2.25 2.25 0 0 1-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 0 0-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 0 1 3.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 0 0-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 0 0-7.5 0" />
                                                            </svg>
                                                        </button>
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                                <div class="my-3 flex justify-between items-center">

                                    <div class="flex gap-3">
                                        <c:if test="${user.roleUsers == 'ADMIN' || user.roleUsers == 'ROOT'}">

                                            <button onclick="makeEditable('${currentTree.uuid}')" class="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-500">
                                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                                                <path stroke-linecap="round" stroke-linejoin="round" d="m16.862 4.487 1.687-1.688a1.875 1.875 0 1 1 2.652 2.652L10.582 16.07a4.5 4.5 0 0 1-1.897 1.13L6 18l.8-2.685a4.5 4.5 0 0 1 1.13-1.897l8.932-8.931Zm0 0L19.5 7.125M18 14v4.75A2.25 2.25 0 0 1 15.75 21H5.25A2.25 2.25 0 0 1 3 18.75V8.25A2.25 2.25 0 0 1 5.25 6H10" />
                                                </svg>
                                            </button>
                                            <button id="btn-save-${currentTree.uuid}" onclick="onUpdate('${currentTree.uuid}')" class="hidden flex gap-1 bg-green-600 text-white px-4 py-2 rounded hover:bg-green-500">
                                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                                                <path stroke-linecap="round" stroke-linejoin="round" d="M17.593 3.322c1.1.128 1.907 1.077 1.907 2.185V21L12 17.25 4.5 21V5.507c0-1.108.806-2.057 1.907-2.185a48.507 48.507 0 0 1 11.186 0Z" />
                                                </svg>
                                                Save
                                            </button>
                                        </c:if>
                                    </div>


                                    <button id="addZoneBtn-${currentTree.uuid}" class="flex items-center gap-2 bg-green-600 text-white px-4 py-2 rounded hover:bg-green-500">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v6m3-3H9m12 0a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z" />
                                        </svg>
                                        Add Zone
                                    </button>
                                </div>


                                <div id="zoneSelectContainer-${currentTree.uuid}" class="hidden opacity-0 transition-all duration-500 ease-in-out bg-white border border-gray-200 rounded-lg shadow-md p-4 mt-4 space-y-3">
                                    <label for="zone" class="block text-sm font-medium text-gray-700">Select Zone</label>

                                    <select id="zoneSelect-${currentTree.uuid}" name="zoneId" placeholder="Select a zone..."
                                            class="w-full px-4 py-2 border border-gray-300 rounded-md text-gray-700 focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500">
                                        <option value="" selected disabled hidden>Select a Zone...</option>
                                        <c:forEach var="currentZone" items="${zones}">
                                            <c:set var="isAlreadyInTree" value="false" />

                                            <c:forEach var="zone" items="${currentTree.zones}">
                                                <c:if test="${currentZone.uuid == zone.uuid}">
                                                    <c:set var="isAlreadyInTree" value="true" />
                                                </c:if>
                                            </c:forEach>

                                            <c:if test="${!isAlreadyInTree}">
                                                <option value="${currentZone.uuid}">${currentZone.name}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>

                                    <div class="my-3 flex justify-end">
                                        <button onclick="addNewZone('${currentTree.uuid}')"
                                                class="px-4 py-2 bg-green-600 text-white rounded hover:bg-green-700 transition-colors duration-200">
                                            Save
                                        </button>  
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <p class="text-sm text-gray-500 italic">No zones added yet.</p>
                                <div class="my-3 flex justify-between items-center"">
                                    <c:if test="${user.roleUsers == 'ADMIN' || user.roleUsers == 'ROOT'}">

                                        <div class="my-3 flex gap-3">
                                            <button onclick="makeEditable('${currentTree.uuid}')" class="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-500">
                                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                                                <path stroke-linecap="round" stroke-linejoin="round" d="m16.862 4.487 1.687-1.688a1.875 1.875 0 1 1 2.652 2.652L10.582 16.07a4.5 4.5 0 0 1-1.897 1.13L6 18l.8-2.685a4.5 4.5 0 0 1 1.13-1.897l8.932-8.931Zm0 0L19.5 7.125M18 14v4.75A2.25 2.25 0 0 1 15.75 21H5.25A2.25 2.25 0 0 1 3 18.75V8.25A2.25 2.25 0 0 1 5.25 6H10" />
                                                </svg>
                                            </button>
                                            <button id="btn-save-${currentTree.uuid}" onclick="onUpdate('${currentTree.uuid}')" class="hidden flex gap-1 bg-green-600 text-white px-4 py-2 rounded hover:bg-green-500">
                                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                                                <path stroke-linecap="round" stroke-linejoin="round" d="M17.593 3.322c1.1.128 1.907 1.077 1.907 2.185V21L12 17.25 4.5 21V5.507c0-1.108.806-2.057 1.907-2.185a48.507 48.507 0 0 1 11.186 0Z" />
                                                </svg>
                                                Save
                                            </button>
                                        </div>

                                        <button id="addZoneBtn-${currentTree.uuid}" class="flex items-center gap-2 bg-green-600 text-white px-4 py-2 rounded hover:bg-green-500">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v6m3-3H9m12 0a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z" />
                                            </svg>
                                            Add Zone
                                        </button>
                                    </c:if>
                                </div>

                                <div id="zoneSelectContainer-${currentTree.uuid}" class="hidden opacity-0 transition-all duration-500 ease-in-out bg-white border border-gray-200 rounded-lg shadow-md p-4 mt-4 space-y-3">
                                    <label for="zone" class="block text-sm font-medium text-gray-700">Select Zone</label>

                                    <select id="zoneSelect-${currentTree.uuid}" name="zoneId" placeholder="Select a tree..."
                                            class="w-full px-4 py-2 border border-gray-300 rounded-md text-gray-700 focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500">
                                        <option value="" selected disabled hidden>Select a Zone...</option>
                                        <c:forEach var="currentZone" items="${zones}">
                                            <option value="${currentZone.uuid}">${currentZone.name}</option>
                                        </c:forEach>
                                    </select>

                                    <div class="my-3 flex justify-end">
                                        <button onclick="addNewZone('${currentTree.uuid}')"
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

        </c:forEach>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/notyf@3/notyf.min.css">
        <script src="https://cdn.jsdelivr.net/npm/notyf@3/notyf.min.js"></script>

        <script src="https://cdn.jsdelivr.net/npm/tom-select@2.3.1/dist/js/tom-select.complete.min.js"></script>

        <form action="/forestal/tree_species" id="addNewZoneForm" method="post">
            <input type="hidden" name="uuidTree" id="uuidTreeAdd">
            <input type="hidden" name="uuidZone" id="uuidZoneAdd">
            <input type="hidden" name="_method" value="ADD_ZONE">
        </form>

        <script>
                                            function addNewZone(uuidTree) {
                                                const select = document.getElementById(`zoneSelect-` + uuidTree);
                                                if (!select) {
                                                    console.error(`No se encontró el select para la zona con UUID: ${uuidTree}`);
                                                    return;
                                                }
                                                const uuidZone = select.value;
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
                                                        document.getElementById("uuidTreeAdd").value = uuidTree;
                                                        document.getElementById("uuidZoneAdd").value = uuidZone;
                                                        document.getElementById("addNewZoneForm").submit();
                                                    }
                                                });
                                            }
        </script>

        <script>
            document.addEventListener("DOMContentLoaded", () => {
                document.querySelectorAll('[id^="zoneSelect-"]').forEach(selectElement => {
                    if (selectElement.tomselect)
                        return;
                    new TomSelect(selectElement, {
                        create: false,
                        allowEmptyOption: true,
                        maxOptions: 100
                    });
                });

                document.querySelectorAll('[id^="addZoneBtn-"]').forEach(btn => {
                    btn.addEventListener('click', function () {
                        const treeId = btn.id.replace('addZoneBtn-', '');
                        const treeSelectContainer = document.getElementById(`zoneSelectContainer-` + treeId);
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
                            console.error(`El contenedor para el arbol con ID ${treeId} no se encontró.`);
                        }
                    });
                });
            });

        </script>

        <script>

            const activeEdit = false;

            const makeEditable = (uuid) => {
                const inputs = document.querySelectorAll("#tree-info-" + uuid + " input");
                const select = document.getElementById("origin-" + uuid);

                const saveBtn = document.querySelector("#btn-save-" + uuid);
                saveBtn.classList.toggle("hidden");
                if (inputs) {
                    inputs.forEach(input => {
                        input.toggleAttribute("readonly");
                        input.classList.toggle("text-gray-400");
                    });
                    inputs[0].focus();
                }

                if (select) {
                    select.disabled = false;

                    select.classList.add("text-black");
                }
            };

            const makeReadOnly = (uuid) => {
                const inputs = document.querySelectorAll("#tree-info-" + uuid + " input");
                const saveBtn = document.querySelector("#btn-save-" + uuid);
                const select = document.getElementById("origin-" + uuid);

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
                }
                if (select) {
                    select.disabled = true;
                    select.classList.remove("text-black");
                    select.classList.add("text-gray-400");
                }

            };
        </script>


        <form action="/forestal/tree_species" id="deleteZoneForm" method="post">
            <input type="hidden" name="uuidForestal" id="uuidForestal">
            <input type="hidden" name="uuidTree" id="uuidTree">
            <input type="hidden" name="_method" value="DELETE_ZONE">
        </form>



        <form action="/forestal/tree_species" id="updateForm" method="post">
            <input type="hidden" name="uuid" id="uuidUpdate">
            <input type="hidden" name="name" id="nameUpdate">
            <input type="hidden" name="commonName" id="commonNameUpdate">
            <input type="hidden" name="family" id="familyUpdate">
            <input type="hidden" name="origin" id="originUpdate">
            <input type="hidden" name="orderName" id="orderNameUpdate">
            <input type="hidden" name="habitat" id="habitatUpdate">
            <input type="hidden" name="description" id="descriptionUpdate">


            <input type="hidden" name="_method" value="UPDATE">
        </form>

        <script>
            const onUpdate = (uuid) => {
                const name = document.getElementById("name-" + uuid);
                const commonName = document.getElementById("commonName-" + uuid);
                const family = document.getElementById("family-" + uuid);
                const origin = document.getElementById("origin-" + uuid);
                const orderName = document.getElementById("orderName-" + uuid);
                const habitat = document.getElementById("habitat-" + uuid);
                const description = document.getElementById("description-" + uuid);

                let isValid = true;
                if (name.value.trim() === "") {
                    isValid = false;
                    name.classList.add('border-red-500');
                }

                if (commonName.value.trim() === "") {
                    isValid = false;
                    commonName.classList.add('border-red-500');
                }
                if (family.value.trim() === "") {
                    isValid = false;
                    family.classList.add('border-red-500');
                }

                if (origin.value.trim() === "") {
                    isValid = false;
                    origin.classList.add('border-red-500');
                }

                if (orderName.value.trim() === "") {
                    isValid = false;
                    orderName.classList.add('border-red-500');
                }
                if (habitat.value.trim() === "") {
                    isValid = false;
                    habitat.classList.add('border-red-500');
                }
                if (description.value.trim() === "") {
                    isValid = false;
                    description.classList.add('border-red-500');
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
                        document.getElementById('commonNameUpdate').value = commonName.value;
                        document.getElementById('familyUpdate').value = family.value;
                        document.getElementById('originUpdate').value = origin.value;
                        document.getElementById('orderNameUpdate').value = orderName.value;
                        document.getElementById('habitatUpdate').value = habitat.value;
                        document.getElementById('descriptionUpdate').value = description.value;
                        document.getElementById('updateForm').submit();
                    }
                });
            };
        </script>

        <script src="./scripts/downloadCSV.js"></script>

        <form action="/forestal/tree_species" id="deleteZoneForm" method="post">
            <input type="hidden" name="uuidForestal" id="uuidForestal">
            <input type="hidden" name="uuidTree" id="uuidTree">
            <input type="hidden" name="_method" value="DELETE_ZONE">
        </form>




        <script>
        const onDeleteZone = (uuidTree, uuidZone) => {
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
                    document.getElementById("uuidForestal").value = uuidZone;
                    document.getElementById("uuidTree").value = uuidTree;
                    document.getElementById("deleteZoneForm").submit();
                }
            });
        }
        </script>

        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" defer></script>

        <script>
        document.addEventListener("DOMContentLoaded", () => {
            const table = document.querySelector("#treesTable");
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
        document.addEventListener("DOMContentLoaded", () => {
            document.querySelectorAll("[data-modal-toggle]").forEach(button => {
                const targetId = button.getAttribute("data-modal-target");
                const modal = document.getElementById(targetId);

                if (!modal)
                    return;

                button.addEventListener("click", () => {
                    modal.classList.remove("hidden");
                });
            });

            document.querySelectorAll("[data-modal-hide]").forEach(button => {
                const targetId = button.getAttribute("data-modal-hide");
                const modal = document.getElementById(targetId);

                if (!modal)
                    return;

                button.addEventListener("click", () => {
                    modal.classList.add("hidden");
                });
            });
        });
        </script>
        <form id="deleteForm" method="post" action="/forestal/tree_species">
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
            document.getElementById('treeSpeciesForm').addEventListener('submit', (e) => {
                e.preventDefault();


                let isValid = true;
                const form = e.target;
                console.log("form: " + form);

                const name = form.name.value.trim();
                const commonName = form.commonName.value.trim();
                const family = form.family.value.trim();
                const origin = form.origin.value.trim();
                const orderName = form.orderName.value.trim();
                const habitat = form.habitat.value.trim();
                const description = form.description.value.trim();
                const image = form.image.value.trim();

                [...form.elements].forEach(el => el.classList.remove('border-red-500'));

                if (name === "") {
                    isValid = false;
                    form.name.classList.add('border-red-500');
                }

                if (commonName === "") {
                    isValid = false;
                    form.commonName.classList.add('border-red-500');
                }
                if (family === "") {
                    isValid = false;
                    form.family.classList.add('border-red-500');
                }

                if (origin === "") {
                    isValid = false;
                    form.origin.classList.add('border-red-500');
                }

                if (orderName === "") {
                    isValid = false;
                    form.orderName.classList.add('border-red-500');
                }
                if (habitat === "") {
                    isValid = false;
                    form.habitat.classList.add('border-red-500');
                }
                if (description === "") {
                    isValid = false;
                    form.description.classList.add('border-red-500');
                }
                if (image === "") {
                    isValid = false;
                    form.image.classList.add('border-red-500');
                }

                if (!isValid) {
                    console.error("Please fill in all required fields.");
                    onWarningToast("Please fill in all required fields.");
                    return;
                }



                form.submit();
            });

        </script>


        <script src="./scripts/toastrService.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.7.1/leaflet.js"></script>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/leaflet.draw/1.0.4/leaflet.draw.js"></script>

        <script src="./scipts/downloadCSV.js"></script>



    </body>
</html>
