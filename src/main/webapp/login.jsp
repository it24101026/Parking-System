<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Parking System</title>
    <link rel="stylesheet" href="css/login.css">
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="min-h-screen flex items-center justify-center bg-cover bg-center bg-fixed" style="background-image: url('background.jpeg');">
<div class="bg-white/70 backdrop-blur-md rounded-2xl shadow-xl p-10 w-full max-w-md animate-fadeIn">
    <div class="text-center mb-6">
        <h2 class="text-4xl font-bold text-gray-800">🚗 Parking System</h2>
        <p class="text-sm text-gray-600 mt-2">Sign in to continue</p>
    </div>

    <% String error = (String) request.getAttribute("error"); %>
    <% if (error != null) { %>
    <div class="alert alert-error mb-4">
        <svg class="icon-error" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"/>
        </svg>
        <p><%= error %></p>
    </div>
    <% } %>

    <% String registered = request.getParameter("registered"); %>
    <% if ("true".equals(registered)) { %>
    <div class="alert alert-success mb-4">
        <svg class="icon-success" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
        </svg>
        <p>Registration successful! Please login.</p>
    </div>
    <% } %>

    <form action="users" method="post" class="space-y-5">
        <input type="hidden" name="action" value="login">

        <div>
            <label for="username" class="block text-sm font-medium text-gray-700">Username</label>
            <input type="text" id="username" name="username" required
                   class="input-field input-animate input-lg" placeholder="Enter your username">
        </div>

        <div>
            <label for="password" class="block text-sm font-medium text-gray-700">Password</label>
            <input type="password" id="password" name="password" required
                   class="input-field input-animate" placeholder="Enter your password">
        </div>

        <button type="submit"
                class="w-full py-2 px-4 bg-blue-600 hover:bg-blue-700 text-white rounded-md font-semibold shadow transition duration-300">
            Sign in
        </button>
    </form>

    <p class="mt-6 text-center text-sm text-gray-600">
        Don't have an account?
        <a href="users?action=new" class="text-blue-600 hover:underline font-medium">Register here</a>
    </p>
</div>
</body>
</html>
