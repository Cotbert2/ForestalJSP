<%-- 
    Document   : conservation_activities
    Created on : 12 may. 2025, 21:09:17
    Author     : Luis Sagnay
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Conservation Activities</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.1/flowbite.min.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.1/flowbite.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/flowbite/dist/flowbite.min.js"></script>
    <link rel="icon" href="./assets/leave.png" type="image/x-icon">
</head>
<body class="bg-gray-50 text-gray-900">
    <header class="sticky top-0 z-50 bg-white shadow">
        <nav class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div class="flex justify-between items-center py-4">
            <div class="text-2xl font-bold text-green-700">Run Forest, Run!</div>
            <ul class="flex space-x-8 text-sm font-medium">
              <li><a href="#forest-zones" class="hover:text-green-700">Conservation Activities</a></li>
            </ul>
          </div>
        </nav>
    </header>
    
    <section class="max-w-7xl mx-auto py-16 px-4 sm:px-6 lg:px-8" id="conservation-activities">
      <div class="flex justify-between items-center mb-4">
        <h2 class="text-3xl font-bold text-green-800">Conservation Activities</h2>
        <button onclick="downloadCSV()" class="flex items-center gap-2 bg-green-700 text-white px-4 py-2 rounded hover:bg-green-600">
          <svg class="w-5 h-5" fill="currentColor" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
            <path d="M288 32c0-17.7-14.3-32-32-32s-32 14.3-32 32l0 242.7-73.4-73.4c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3l128 128c12.5 12.5 32.8 12.5 45.3 0l128-128c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0L288 274.7 288 32zM64 352c-35.3 0-64 28.7-64 64l0 32c0 35.3 28.7 64 64 64l384 0c35.3 0 64-28.7 64-64l0-32c0-35.3-28.7-64-64-64l-101.5 0-45.3 45.3c-25 25-65.5 25-90.5 0L165.5 352 64 352zm368 56a24 24 0 1 1 0 48 24 24 0 1 1 0-48z"/>
          </svg>
          Download CSV
        </button>
      </div>

      <input type="text" id="searchInput" onkeyup="filterTable()" placeholder="Search activities..." class="mb-4 p-2 border border-gray-300 rounded w-full" />

      <div class="overflow-x-auto">
        <table id="activitiesTable" class="min-w-full divide-y divide-gray-200">
          <thead class="bg-gray-100">
            <tr>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Name</th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Description</th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Activity Date</th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Forestal Zone UUID</th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Actions</th>
            </tr>
          </thead>
          <tbody class="bg-white divide-y divide-gray-200">
            <c:forEach var="activity" items="${activities}">
              <tr>
                <td class="px-6 py-4">${activity.name}</td>
                <td class="px-6 py-4">${activity.description}</td>
                <td class="px-6 py-4">${activity.activityDate}</td>
                <td class="px-6 py-4">${activity.forestalZoneUuid}</td>
                <td class="px-6 py-4 flex gap-2">
                  <button data-modal-target="previewModal" data-modal-toggle="previewModal" onclick="previewModal()" class="flex items-center gap-2 bg-green-700 text-white px-3 py-1 rounded hover:bg-green-600">
                    <svg class="w-5 h-5" fill="currentColor" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                      <path d="M288 32c-80.8 0-145.5 36.8-192.6 80.6C48.6 156 17.3 208 2.5 243.7c-3.3 7.9-3.3 16.7 0 24.6C17.3 304 48.6 356 95.4 399.4C142.5 443.2 207.2 480 288 480s145.5-36.8 192.6-80.6c46.8-43.5 78.1-95.4 93-131.1c3.3-7.9 3.3-16.7 0-24.6c-14.9-35.7-46.2-87.7-93-131.1C433.5 68.8 368.8 32 288 32zM144 256a144 144 0 1 1 288 0 144 144 0 1 1 -288 0zm144-64c0 35.3-28.7 64-64 64c-7.1 0-13.9-1.2-20.3-3.3c-5.5-1.8-11.9 1.6-11.7 7.4c.3 6.9 1.3 13.8 3.2 20.7c13.7 51.2 66.4 81.6 117.6 67.9s81.6-66.4 67.9-117.6c-11.1-41.5-47.8-69.4-88.6-71.1c-5.8-.2-9.2 6.1-7.4 11.7c2.1 6.4 3.3 13.2 3.3 20.3z"/>
                    </svg>
                    Preview
                  </button>
                  <button data-modal-target="editModal" data-modal-toggle="editModal" onclick="editModal()" class="flex items-center gap-2 bg-green-700 text-white px-3 py-1 rounded hover:bg-green-600">
                    <svg class="w-5 h-5" fill="currentColor" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                      <path d="M471.6 21.7c-21.9-21.9-57.3-21.9-79.2 0L362.3 51.7l97.9 97.9 30.1-30.1c21.9-21.9 21.9-57.3 0-79.2L471.6 21.7zm-299.2 220c-6.1 6.1-10.8 13.6-13.5 21.9l-29.6 88.8c-2.9 8.6-.6 18.1 5.8 24.6s15.9 8.7 24.6 5.8l88.8-29.6c8.2-2.7 15.7-7.4 21.9-13.5L437.7 172.3 339.7 74.3 172.4 241.7zM96 64C43 64 0 107 0 160L0 416c0 53 43 96 96 96l256 0c53 0 96-43 96-96l0-96c0-17.7-14.3-32-32-32s-32 14.3-32 32l0 96c0 17.7-14.3 32-32 32L96 448c-17.7 0-32-14.3-32-32l0-256c0-17.7 14.3-32 32-32l96 0c17.7 0 32-14.3 32-32s-14.3-32-32-32L96 64z"/>
                    </svg>
                    Edit
                  </button>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
    </section>

    

</body>
</html>
