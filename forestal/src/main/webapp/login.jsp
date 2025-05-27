<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Login | Run Forest, Run!</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="icon" href="./assets/leave.png" type="image/x-icon">
    </head>
    <body class="bg-green-50 flex items-center justify-center min-h-screen text-gray-900">

        <div class="bg-white shadow-lg rounded-xl p-8 max-w-md w-full space-y-6">
            <div class="text-center">
                <h1 class="text-3xl font-bold text-green-700">Welcome Back</h1>
                <p class="text-sm text-gray-600 mt-1">Log in to access the Forestal System</p>
            </div>

            <% if (request.getAttribute("error") != null) {%>
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative text-sm">
                <strong>Error:</strong> <%= request.getAttribute("error")%>
            </div>
            <% }%>

            <form action="login" method="post" class="space-y-4">
                <div>
                    <label for="email" class="block text-sm font-medium text-gray-700">Email or Username</label>
                    <input type="text" name="email" id="email" required
                           class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-green-500 focus:border-green-500">
                </div>

                <div>
                    <label for="password" class="block text-sm font-medium text-gray-700">Password</label>
                    <input type="password" name="password" id="password" required
                           class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-green-500 focus:border-green-500">
                </div>

                <div>
                    <button type="submit"
                            class="w-full py-2 px-4 bg-green-700 hover:bg-green-800 text-white font-semibold rounded-lg shadow-md transition duration-200">
                        Log In
                    </button>
                </div>
            </form>

            <div class="text-center text-sm text-gray-600">
                Don't have an account?
                <a href="register" class="text-green-700 hover:underline font-medium">Sign up here</a>
            </div>

            <div class="text-center text-sm text-gray-500">
                &copy; 2025 Run Forest, Run! All rights reserved.
            </div>
        </div>

    </body>
</html>
