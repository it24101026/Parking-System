<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="lk.sliit.parkingsystem.parkingsystem.model.User" %>
<%@ page import="java.util.List" %>
<%
  List<User> users = (List<User>) request.getAttribute("users");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>User Management</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="css/user-list.css">
</head>
<body class="bg-gray-100 min-h-screen font-sans">
<div class="container mx-auto p-6 animate-fadeInSlow">
  <div class="flex justify-between items-center mb-8">
    <h1 class="text-3xl font-bold text-gray-800">User Management</h1>
    <div class="flex gap-4">
      <a href="admin-dashboard.jsp" class="btn-secondary">Back to Dashboard</a>
      <a href="users?action=new" class="btn-primary">Add New User</a>
    </div>
  </div>

  <div class="bg-white rounded-xl shadow-lg p-6 transition-transform transform hover:scale-[1.01] duration-300 ease-in-out">
    <% if (users.isEmpty()) { %>
    <div class="text-center py-12">
      <svg class="mx-auto h-16 w-16 text-gray-400 animate-pulse" fill="none" viewBox="0 0 24 24" stroke="currentColor">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
              d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"/>
      </svg>
      <h2 class="mt-4 text-xl font-semibold text-gray-700">No Users Found</h2>
      <p class="text-gray-500">Click below to add your first user.</p>
      <a href="users?action=new" class="btn-primary mt-6 inline-block">Add New User</a>
    </div>
    <% } else { %>
    <div class="overflow-x-auto animate-slideUp">
      <table class="min-w-full table-auto text-sm text-left text-gray-700">
        <thead class="bg-gray-100 text-gray-600 uppercase text-xs">
        <tr>
          <th class="px-6 py-3">ID</th>
          <th class="px-6 py-3">Username</th>
          <th class="px-6 py-3">Full Name</th>
          <th class="px-6 py-3">Contact</th>
          <th class="px-6 py-3">Role</th>
          <th class="px-6 py-3">Actions</th>
        </tr>
        </thead>
        <tbody class="divide-y divide-gray-200">
        <% for (User user : users) { %>
        <tr class="hover:bg-gray-50 transition duration-150 ease-in-out">
          <td class="px-6 py-4"><%= user.getId() %></td>
          <td class="px-6 py-4 font-medium text-gray-900"><%= user.getUsername() %></td>
          <td class="px-6 py-4"><%= user.getFullName() %></td>
          <td class="px-6 py-4"><%= user.getContact() %></td>
          <td class="px-6 py-4">
            <% if ("admin".equals(user.getRole())) { %>
            <span class="badge-admin">Admin</span>
            <% } else { %>
            <span class="badge-user">User</span>
            <% } %>
          </td>
          <td class="px-6 py-4">
            <div class="flex space-x-2">
              <a href="users?action=edit&id=<%= user.getId() %>" class="btn-warning">Edit</a>
              <a href="users?action=delete&id=<%= user.getId() %>"
                 onclick="return confirm('Are you sure you want to delete this user?')"
                 class="btn-danger">Delete</a>
            </div>
          </td>
        </tr>
        <% } %>
        </tbody>
      </table>
    </div>
    <% } %>
  </div>
</div>
</body>
</html>
