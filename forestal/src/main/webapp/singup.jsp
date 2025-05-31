<%-- 
    Document   : singup
    Created on : May 27, 2025, 3:10:14 PM
    Author     : mateo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sign Up | Run Forest, Run!</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/notyf@3/notyf.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/notyf@3/notyf.min.css">
        <script src="https://cdn.jsdelivr.net/npm/notyf@3/notyf.min.js"></script>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="icon" href="./assets/leave.png" type="image/x-icon">
</head>
<body class="bg-green-50 flex items-center justify-center min-h-screen text-gray-900">

    <div class="bg-white shadow-lg rounded-xl p-8 max-w-md w-full space-y-6">
        <div class="text-center">
            <h1 class="text-3xl font-bold text-green-700">Create an Account</h1>
            <p class="text-sm text-gray-600 mt-1">Join the Forestal System and help protect nature</p>
        </div>

        <% if (request.getAttribute("error") != null) { %>
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded text-sm">
                <strong>Error:</strong> <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <!-- ✅ Mensaje de error para JS -->
        <div id="passwordError" class="hidden bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded text-sm">
            <strong>Error:</strong> Passwords do not match.
        </div>

        <form id="registerForm" action="register" method="post" class="space-y-4">

            <div>
                <label for="firstName" class="block text-sm font-medium text-gray-700">First Name</label>
                <input type="text" name="firstName" id="firstName" required
                       class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-green-500 focus:border-green-500">
            </div>

            <div>
                <label for="lastName" class="block text-sm font-medium text-gray-700">Last Name</label>
                <input type="text" name="lastName" id="lastName" required
                       class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-green-500 focus:border-green-500">
            </div>

            <div>
                <label for="email" class="block text-sm font-medium text-gray-700">Email</label>
                <input type="email" name="email" id="email" required
                       class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-green-500 focus:border-green-500">
            </div>

            <div>
                <label for="phone" class="block text-sm font-medium text-gray-700">Phone</label>
                <input type="text" name="phone" id="phone" required
                       class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-green-500 focus:border-green-500">
            </div>

            <div>
                <label for="password" class="block text-sm font-medium text-gray-700">Password</label>
                <input type="password" name="password" id="password" required minlength="6"
                       class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-green-500 focus:border-green-500">
            </div>

            <div>
                <label for="confirmPassword" class="block text-sm font-medium text-gray-700">Repeat Password</label>
                <input type="password" id="confirmPassword" required minlength="6"
                       class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-green-500 focus:border-green-500">
            </div>

            <div>
                <button type="submit"
                        class="w-full py-2 px-4 bg-green-700 hover:bg-green-800 text-white font-semibold rounded-lg shadow-md transition duration-200">
                    Sign Up
                </button>
            </div>
        </form>

        <div class="text-center text-sm text-gray-600">
            Already have an account?
            <a href="login.jsp" class="text-green-700 hover:underline font-medium">Log in</a>
        </div>

        <div class="text-center text-xs text-gray-500 pt-4">
            &copy; 2025 Run Forest, Run! All rights reserved.
        </div>
    </div>
        
                <script src="./scripts/toastrService.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.7.1/leaflet.js"></script>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/leaflet.draw/1.0.4/leaflet.draw.js"></script>

    <script>
        document.getElementById("registerForm").addEventListener("submit", function(event) {
            const password = document.getElementById("password").value;
            const confirmPassword = document.getElementById("confirmPassword").value;
            const errorDiv = document.getElementById("passwordError");

            if (password !== confirmPassword) {
                errorDiv.classList.remove("hidden");
                event.preventDefault();
            } else {
                errorDiv.classList.add("hidden");
            }
        });
    </script>

     <script>
            document.getElementById('registerForm').addEventListener('submit', (e) => {
                e.preventDefault();

                let isValid = true;
                const form = e.target;
                console.log("form: " + form);

                const firstName = form.firstName.value.trim();
                const lastName = form.lastName.value.trim();
                const email = form.email.value.trim();
                const phone = form.phone.value.trim();
                const password = form.password.value.trim();
                const confirmPassword = form.confirmPassword.value.trim();

                [...form.elements].forEach(el => el.classList.remove('border-red-500'));

                if (firstName === "") {
                    isValid = false;
                    form.firstName.classList.add('border-red-500');
                }

                if (lastName === "") {
                    isValid = false;
                    form.lastName.classList.add('border-red-500');
                }
                if (email === "") {
                    isValid = false;
                    form.email.classList.add('border-red-500');
                }

                if (phone === "") {
                    isValid = false;
                    form.phone.classList.add('border-red-500');
                }

                if (password === "") {
                    isValid = false;
                    form.password.classList.add('border-red-500');
                }
                if (confirmPassword === "") {
                    isValid = false;
                    form.confirmPassword.classList.add('border-red-500');
                }

                if (!isValid) {
                    console.error("Please fill in all required fields.");
                    onWarningToast("Please fill in all required fields.");
                    return;
                }



                form.submit();
            });

        </script>
        
        
    
</body>
</html>

