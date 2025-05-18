<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="lk.sliit.parkingsystem.parkingsystem.model.User" %>
<%
  User user = (User) request.getAttribute("user");
  String action = user == null ? "Add" : "Edit";
  String formAction = user == null ? "register" : "update";
  String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title><%= action %> User - Parking System</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="css/user-form.css">
</head>
<body class="bg-cover bg-fixed bg-center min-h-screen flex items-center justify-center bg-overlay-img">

<div class="w-full max-w-lg p-8 bg-white/90 rounded-3xl shadow-xl animate-fadeSlideDown">
  <div class="text-center mb-6">
    <h1 class="text-3xl font-extrabold text-blue-800 tracking-wide"><%= action %> User</h1>
    <% if (user == null) { %>
    <p class="mt-2 text-sm text-gray-600">Create an account to access the system</p>
    <% } %>
  </div>

  <% if (error != null) { %>
  <div class="alert error mb-4 animate-fadeIn">
    <svg class="w-5 h-5 text-red-500 mr-2" fill="currentColor" viewBox="0 0 20 20">
      <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm0-11a1 1 0 00-1 1v3a1 1 0 002 0V8a1 1 0 00-1-1zm-.25 7.75a1.25 1.25 0 112.5 0 1.25 1.25 0 01-2.5 0z" clip-rule="evenodd" />
    </svg>
    <p><%= error %></p>
  </div>
  <% } %>

  <form action="users" method="post" class="space-y-5">
    <input type="hidden" name="action" value="<%= formAction %>">
    <% if (user != null) { %>
    <input type="hidden" name="id" value="<%= user.getId() %>">
    <% } %>

    <div>
      <label class="input-label" for="username">Username</label>
      <input type="text" id="username" name="username" required value="<%= user != null ? user.getUsername() : "" %>" class="input-field">
    </div>

    <div>
      <label class="input-label" for="password">Password</label>
      <input type="password" id="password" name="password" required value="<%= user != null ? user.getPassword() : "" %>" class="input-field">
    </div>

    <div>
      <label class="input-label" for="fullName">Full Name</label>
      <input type="text" id="fullName" name="fullName" required value="<%= user != null ? user.getFullName() : "" %>" class="input-field">
    </div>

    <div>
      <label class="input-label" for="contact">Contact</label>
      <input type="text" id="contact" name="contact" required value="<%= user != null ? user.getContact() : "" %>" class="input-field">
    </div>

    <div>
      <label class="input-label" for="role">Role</label>
      <select id="role" name="role" <%= user != null && "admin".equals(user.getRole()) ? "disabled" : "" %> class="input-field">
        <option value="user" <%= user != null && "user".equals(user.getRole()) ? "selected" : "" %>>User</option>
        <option value="admin" <%= user != null && "admin".equals(user.getRole()) ? "selected" : "" %>>Admin</option>
      </select>
    </div>

    <div>
      <button type="submit" class="submit-button w-full"><%= action %> User</button>
    </div>
  </form>

  <div class="text-center mt-6 border-t pt-4 text-sm text-gray-600">
    <% if (user == null) { %>
    Already registered?
    <a href="login.jsp" class="text-blue-600 hover:underline">Login here</a>
    <% } else { %>
    <a href="admin-dashboard.jsp" class="text-blue-600 hover:underline">Back to Dashboard</a>
    <% } %>
  </div>
</div>

</body>
</html>
