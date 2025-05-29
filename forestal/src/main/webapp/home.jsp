<%-- 
    Document   : home
    Created on : May 27, 2025, 3:01:18 PM
    Author     : mateo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Start Page</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.1/flowbite.min.css" rel="stylesheet"/>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.1/flowbite.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/flowbite/dist/flowbite.min.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" href="./assets/leave.png" type="image/x-icon">
    </head>

    <body class="bg-gray-50 text-gray-900">

        <!-- Sticky Top Navbar -->
        <header class="sticky top-0 z-50 bg-white shadow">
            <nav class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex justify-between items-center py-4">
                    <div class="text-2xl font-bold text-green-700">
                        <a href="/forestal/">
                            Run Forest, Run!
                        </a>
                    </div>

                    <ul class="flex space-x-8 text-sm font-medium">
                        <li><a href="forestal_zone" class="hover:text-green-700">Forest Zones</a></li>
                        <li><a href="tree_species" class="hover:text-green-700">Tree Species</a></li>
                        <li><a href="conservation_activities" class="hover:text-green-700">Conservation Efforts</a></li>
                            <c:if test="${user.roleUsers == 'ROOT'}">
                            <li><a href="users" class="hover:text-green-700">Users</a></li>
                            </c:if>
                        <li>
                            <form action="logout" method="get">
                                <button type="submit" class="hover:text-green-700">Logout</button>
                            </form>
                        </li>
                    </ul>

                </div>
            </nav>
        </header>

        <section class="relative">
            <video autoplay loop muted playsinline class="w-full h-[80vh] object-cover">
                <source src="./assets/landscape.mp4" type="video/mp4">
                Your browser does not support the video tag.
            </video>
            <div class="absolute inset-0 bg-black/40 flex flex-col justify-center items-center text-white text-center px-4">
                <h1 class="text-4xl md:text-6xl font-bold mb-4">Hi, ${user.firstNameUsers}</h1>
                <p class="text-lg md:text-xl max-w-xl">Forests regulate our climate, filter the air we breathe, and sustain over 80% of the world’s terrestrial biodiversity. Their protection is not optional—it's essential.</p>
            </div>
        </section>

        <section id="zones" class="max-w-7xl mx-auto py-16 px-4 sm:px-6 lg:px-8">
            <h2 class="text-3xl font-bold text-green-800 mb-6">Forest Zones</h2>
            <p class="text-gray-700 mb-4">Forests are categorized by climate, location, and vegetation type. Each zone offers unique environmental services, from storing carbon to providing critical habitat. Understanding their differences helps us protect them more effectively.</p>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                <div class="bg-white shadow-md rounded-lg p-6">
                    <h3 class="font-semibold text-lg text-green-700 mb-2">Tropical Forest</h3>
                    <p class="text-sm text-gray-600">Covering just 6% of Earth’s surface, tropical rainforests are home to over 50% of known species. They play a vital role in global rainfall patterns and oxygen production.</p>
                </div>
                <div class="bg-white shadow-md rounded-lg p-6">
                    <h3 class="font-semibold text-lg text-green-700 mb-2">Temperate Forest</h3>
                    <p class="text-sm text-gray-600">Located in North America, Europe, and Asia, these forests experience all four seasons. Their biodiversity includes deciduous trees, birds, and large mammals like bears and deer.</p>
                </div>
                <div class="bg-white shadow-md rounded-lg p-6">
                    <h3 class="font-semibold text-lg text-green-700 mb-2">Boreal Forest</h3>
                    <p class="text-sm text-gray-600">Spanning across Canada, Russia, and Scandinavia, boreal forests absorb vast amounts of carbon dioxide and support cold-adapted wildlife like moose and lynx.</p>
                </div>
            </div>
        </section>

        <section id="species" class="bg-green-50 py-16 px-4 sm:px-6 lg:px-8">
            <div class="max-w-7xl mx-auto">
                <h2 class="text-3xl font-bold text-green-800 mb-6">Endangered Species</h2>
                <p class="text-gray-700 mb-6">Forests support the survival of thousands of species, many of which are currently endangered. Protecting these animals helps preserve ecological balance, pollination, seed dispersion, and forest regeneration.</p>
                <ul class="list-disc list-inside text-gray-700 space-y-2">
                    <li><strong>Jaguar</strong> – Apex predator of the Amazon, essential for maintaining population control of prey species.</li>
                    <li><strong>Red Panda</strong> – Native to the Eastern Himalayas, facing habitat loss from agriculture and logging.</li>
                    <li><strong>Spotted Owl</strong> – Found in North America's old-growth forests, threatened by deforestation and competition from invasive owl species.</li>
                    <li><strong>Orangutan</strong> – Highly intelligent primates, critically endangered due to illegal wildlife trade and palm oil plantations.</li>
                </ul>
            </div>
        </section>

        <section id="sustainability" class="max-w-7xl mx-auto py-16 px-4 sm:px-6 lg:px-8">
            <h2 class="text-3xl font-bold text-green-800 mb-6">Sustainable Practices</h2>
            <p class="text-gray-700 mb-4">Sustainable forest management aims to meet current demands for resources like timber and medicine without compromising future generations’ ability to enjoy the same benefits. It integrates environmental, social, and economic goals.</p>
            <div class="grid md:grid-cols-2 gap-6">
                <div class="bg-white shadow-md rounded-lg p-6">
                    <h3 class="font-semibold text-lg text-green-700 mb-2">Responsible Forestry</h3>
                    <p class="text-sm text-gray-600">Practices such as selective logging, reduced impact harvesting, and forest certification (FSC) help ensure forest resources are used responsibly and renewably.</p>
                </div>
                <div class="bg-white shadow-md rounded-lg p-6">
                    <h3 class="font-semibold text-lg text-green-700 mb-2">Community Stewardship</h3>
                    <p class="text-sm text-gray-600">Empowering Indigenous and local communities to manage forest lands has proven to reduce deforestation while preserving cultural and ecological heritage.</p>
                </div>
            </div>
        </section>

        <footer class="bg-green-800 text-white py-6">
            <div class="max-w-7xl mx-auto px-4 text-center">
                &copy; 2025 Run Forest, Run! All rights reserved. Together for a greener future.
            </div>
        </footer>

    </body>
</html>

