<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="edu.espe.cotbert.forestal.domain.model.security.UserAuthModel"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Users</title>
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

    <body class="bg-gray-50 text-gray-900">

        <header class="sticky top-0 z-50 bg-white shadow">
            <nav class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex justify-between items-center py-4">
                    <div class="text-2xl font-bold text-green-700">
                        <a href="/forestal/">Run Forest, Run!</a>
                    </div>
                    <ul class="flex space-x-8 text-sm font-medium">
                        <li><a href="forestal_zone" class="hover:text-green-700">Forest Zones</a></li>
                        <li><a href="tree_species" class="hover:text-green-700">Tree Species</a></li>
                        <li><a href="conservation_activities" class="hover:text-green-700">Conservation Efforts</a></li>
                        <li><a href="users" class="text-green-700 font-bold">Users</a></li>

                    </ul>
                </div>
            </nav>
        </header>

        <!-- Modal New User -->
        <div id="modalNew"
             class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 hidden">
            <div class="bg-white rounded-lg w-full max-w-xl shadow-lg transform transition-all my-10 max-h-[90vh] overflow-hidden flex flex-col">
                <div class="flex justify-between items-center border-b px-6 py-4 flex-shrink-0">
                    <h3 class="text-xl font-semibold text-green-800">Add User</h3>
                    <button class="text-gray-500 hover:text-green-600 text-xl" data-modal-target="modalNew"
                            data-modal-toggle="modalNew">&times;</button>
                </div>

                <div class="p-6 overflow-y-auto flex-grow">
                    <form method="post" id="userForm" class="space-y-4">
                        <div>
                            <label for="firstName" class="block text-sm font-medium text-gray-700 mb-1">First Name</label>
                            <input type="text" id="firstName" name="first_name_users" placeholder="Enter first name"
                                   class="text-gray-700 w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500">
                        </div>

                        <div>
                            <label for="lastName" class="block text-sm font-medium text-gray-700 mb-1">Last Name</label>
                            <input type="text" id="lastName" name="last_name_users" placeholder="Enter last name"
                                   class="text-gray-700 w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500">
                        </div>

                        <div>
                            <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Email</label>
                            <input type="email" id="email" name="email_users" placeholder="Enter email"
                                   class="text-gray-700 w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500">
                        </div>

                        <div>
                            <label for="phone" class="block text-sm font-medium text-gray-700 mb-1">Phone</label>
                            <input type="text" id="phone" name="phone_users" placeholder="Enter phone number"
                                   class="text-gray-700 w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500">
                        </div>

                        <div>
                            <label for="role" class="block text-sm font-medium text-gray-700 mb-1">Role</label>
                            <select id="role" name="role_users"
                                    class="text-gray-700 w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500">
                                <option value="admin">Admin</option>
                                <option value="root">Root</option>
                            </select>
                        </div>

                        <div>
                            <label for="password" class="block text-sm font-medium text-gray-700 mb-1">Password</label>
                            <input type="password" id="password" name="password_users" placeholder="Enter password"
                                   class="text-gray-700 w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500">
                        </div>
                    </form>
                </div>

                <div class="flex justify-end space-x-4 px-6 py-4 border-t flex-shrink-0">
                    <button data-modal-target="modalNew" data-modal-toggle="modalNew" type="button"
                            class="px-4 py-2 bg-gray-200 text-gray-700 rounded hover:bg-gray-300">Cancel</button>
                    <button type="submit" form="userForm"
                            class="px-4 py-2 bg-green-600 text-white rounded hover:bg-green-700">Save User</button>
                </div>
            </div>
        </div>








        <section class="max-w-7xl mx-auto py-16 px-4 sm:px-6 lg:px-8" id="forest-zones">
            <div class="flex justify-between items-center mb-4">
                <h2 class="text-3xl font-bold text-green-800">Users</h2>
                <div class="flex">

                    <button onclick="downloadCSVFileFromTable('usersTable', 'users')"
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
                <table id="usersTable" class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-gray-100">
                        <tr>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">First Name</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Last Name</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Email</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Phone</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Role</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Actions
                            </th>
                        </tr>
                    </thead>

                    <tbody class="bg-white divide-y divide-gray-200">
                        <c:forEach var="u" items="${users}">
                            <tr>
                                <td class="px-6 py-4">${u.firstNameUsers}</td>
                                <td class="px-6 py-4">${u.lastNameUsers}</td>
                                <td class="px-6 py-4">${u.emailUsers}</td>
                                <td class="px-6 py-4">${u.phoneUsers}</td>
                                <td class="px-6 py-4">${u.roleUsers}</td>
                                <td>
                                    <button onclick="viewUserModal('${u.uuidUsers}')"
                                            data-modal-target="modal-${u.uuidUsers}"
                                            data-modal-toggle="modal-${u.uuidUsers}"
                                            class="bg-green-600 text-white px-3 py-1 rounded hover:bg-green-500">
                                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                                             stroke-width="1.5" stroke="currentColor" class="size-6">
                                        <path stroke-linecap="round" stroke-linejoin="round"
                                              d="M2.036 12.322a1.012 1.012 0 0 1 0-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178Z" />
                                        <path stroke-linecap="round" stroke-linejoin="round"
                                              d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
                                        </svg>
                                    <c:if test="${u.roleUsers != 'ROOT'}">
                                    </button>
                                    <button onclick="onDelete('${u.uuidUsers}')"
                                            class="bg-green-600 text-white px-3 py-1 rounded hover:bg-green-500">
                                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                                             stroke-width="1.5" stroke="currentColor" class="size-6">
                                        <path stroke-linecap="round" stroke-linejoin="round"
                                              d="m14.74 9-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 0 1-2.244 2.077H8.084a2.25 2.25 0 0 1-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 0 0-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 0 1 3.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 0 0-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 0 0-7.5 0" />
                                        </svg>
                                    </button>
                                    </c:if>   
                                </td>
                            </tr>





                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <c:forEach var="us" items="${users}">
                <div id="modal-${us.uuidUsers}" tabindex="-1"
                     class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 w-full h-modal h-full bg-black/40">
                    <div class="relative p-4 w-full max-w-2xl max-h-[90vh] mx-auto overflow-y-auto">
                        <div class="bg-white rounded-lg shadow p-6 relative">
                            <div
                                class="sticky top-0 z-20 bg-white p-4 border-b border-gray-200 flex justify-between items-center">
                                <h3 class="text-xl font-semibold text-green-700">User Information</h3>
                                <button data-modal-hide="modal-${us.uuidUsers}"
                                        onclick="makeReadOnly('${us.uuidUsers}')" type="button"
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


                                <div id="user-info-${us.uuidUsers}" class="mb-4 space-y-2">
                                    <div class=" flex items-center gap-4">
                                        <strong class="w-32">First Name:</strong>
                                        <i class="fas fa-tree  text-lg"></i>
                                        <input id="name-${us.uuidUsers}" readonly
                                               class="text-gray-400 pl-3 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 w-full"
                                               type="text" value="${us.firstNameUsers}" />
                                    </div>

                                    <div class="flex items-center gap-4">
                                        <strong class="w-32">Last Name:</strong>
                                        <i class="fas fa-align-left  text-lg"></i>
                                        <input id="lastname-${us.uuidUsers}" readonly
                                               class="text-gray-400 pl-3 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 w-full"
                                               type="text" value="${us.lastNameUsers}" />
                                    </div>

                                    <div class="flex items-center gap-4">
                                        <strong class="w-32">Email:</strong>
                                        <i class="fas fa-align-left  text-lg"></i>
                                        <input id="email-${us.uuidUsers}" readonly
                                               class="text-gray-400 pl-3 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 w-full"
                                               type="text" value="${us.emailUsers}" />
                                    </div>

                                    <div class="flex items-center gap-4">
                                        <strong class="w-32">Phone:</strong>
                                        <i class="fas fa-align-left  text-lg"></i>
                                        <input id="phone-${us.uuidUsers}" readonly
                                               class="text-gray-400 pl-3 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 w-full"
                                               type="text" value="${us.phoneUsers}" />
                                    </div>

                                    <select id="role-${us.uuidUsers}" name="role_users"
                                            class="text-gray-700 w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500">
                                        <option value="admin" ${us.roleUsers == 'admin' ? 'selected' : ''}>Admin</option>
                                        <option value="root" ${us.roleUsers == 'root' ? 'selected' : ''}>Root</option>
                                    </select>



                                </div>

                                <div class="flex gap-4 justify-end pt-4">
                                    <button onclick="makeEditable('${us.uuidUsers}')"
                                            class="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-500">
                                        <svg xmlns="http://www.w3.org/2000/svg" fill="none"
                                             viewBox="0 0 24 24" stroke-width="1.5"
                                             stroke="currentColor" class="size-6">
                                        <path stroke-linecap="round" stroke-linejoin="round"
                                              d="m16.862 4.487 1.687-1.688a1.875 1.875 0 1 1 2.652 2.652L10.582 16.07a4.5 4.5 0 0 1-1.897 1.13L6 18l.8-2.685a4.5 4.5 0 0 1 1.13-1.897l8.932-8.931Zm0 0L19.5 7.125M18 14v4.75A2.25 2.25 0 0 1 15.75 21H5.25A2.25 2.25 0 0 1 3 18.75V8.25A2.25 2.25 0 0 1 5.25 6H10" />
                                        </svg>
                                    </button>

                                    <button id="btn-save-${us.uuidUsers}" onclick="onUpdate('${us.uuidUsers}')"
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

                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </table>
    </div>
</section>


<form action="/forestal/users" id="updateForm" method="post">
    <input type="hidden" name="uuid" id="uuidUpdate">
    <input type="hidden" name="name" id="nameUpdate">
    <input type="hidden" name="lastname" id="lastnameUpdate">
    <input type="hidden" name="email" id="emailUpdate">
    <input type="hidden" name="phone" id="phoneUpdate">
    <input type="hidden" name="role_users" id="roleUpdate">
    <input type="hidden" name="_method" value="UPDATE">
</form>

<form action="/forestal/users" id="deleteForm" method="post">
    <input type="hidden" name="uuid" id="uuid">
    <input type="hidden" name="_method" value="DELETE">
</form>

    
<script>
    document.addEventListener("DOMContentLoaded", () => {
        const table = document.querySelector("#usersTable");

        if (!table.classList.contains("datatable-loaded")) {
            new simpleDatatables.DataTable(table, {
                perPage: 5,
                perPageSelect: [5, 10, 25, 50],
                searchable: true,
                sortable: true,
            });
            table.classList.add("datatable-loaded");
        }
    });
</script>


<script>
    const existingEmails = [
        <c:forEach var="u" items="${users}" varStatus="status">
            "${u.emailUsers}"<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];
</script>



</body>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/notyf@3/notyf.min.css">
<script src="https://cdn.jsdelivr.net/npm/notyf@3/notyf.min.js"></script>

<script src="./scripts/users.js"></script>
<script src="./scripts/downloadCSV.js"></script>
<script src="./scripts/toastrService.js"></script>
</html>