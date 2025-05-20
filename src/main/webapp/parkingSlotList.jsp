<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.app.parking.model.ParkingSlot" %>
<%@ page import="java.util.List" %>
<%
  List<ParkingSlot> parkingSlots = (List<ParkingSlot>) request.getAttribute("parkingSlots");
  boolean availableView = request.getAttribute("availableView") != null;
  boolean sortedView = request.getAttribute("sortedView") != null;
%>
<html>
<head>
  <title>Parking Slot Management</title>
  <link rel="stylesheet" href="css/parking-slot-list.css">
</head>
<body>
<div class="container animate-fade-in">
  <div class="header">
    <h1>🚗 Parking Slot Management</h1>
    <a href="parking-slots?action=new" class="btn btn-primary">➕ Add New Slot</a>
  </div>

  <div class="view-options">
    <a href="parking-slots" class="btn <%= !availableView && !sortedView ? "active" : "" %>">All Slots</a>
    <a href="parking-slots?action=available" class="btn <%= availableView ? "active" : "" %>">Available Slots</a>
    <a href="parking-slots?action=sorted" class="btn <%= sortedView ? "active" : "" %>">Sort by Availability</a>
    <a href="admin-dashboard.jsp" class="btn btn-secondary">← Back to Dashboard</a>
  </div>

  <div class="table-wrapper">
    <table class="styled-table">
      <thead>
      <tr>
        <th>Slot ID</th>
        <th>Slot Number</th>
        <th>Type</th>
        <th>Status</th>
        <th>Vehicle ID</th>
        <th>Actions</th>
      </tr>
      </thead>
      <tbody>
      <% for (ParkingSlot slot : parkingSlots) { %>
      <tr class="<%= slot.isOccupied() ? "occupied" : "available" %>">
        <td><%= slot.getSlotId() %></td>
        <td><%= slot.getSlotNumber() %></td>
        <td><%= slot.getType() %></td>
        <td><%= slot.isOccupied() ? "🚫 Occupied" : "✅ Available" %></td>
        <td><%= slot.getVehicleId() != null ? slot.getVehicleId() : "N/A" %></td>
        <td>
          <% if (!slot.isOccupied()) { %>
          <a href="parking-slots?action=assign&id=<%= slot.getSlotId() %>" class="action-link">Assign</a>
          <% } else { %>
          <a href="parking-slots?action=release&id=<%= slot.getSlotId() %>" class="action-link">Release</a>
          <% } %>
          | <a href="parking-slots?action=edit&id=<%= slot.getSlotId() %>" class="action-link">Edit</a>
          | <a href="parking-slots?action=delete&id=<%= slot.getSlotId() %>"
               class="action-link delete" onclick="return confirm('Are you sure you want to delete this parking slot?')">Delete</a>
        </td>
      </tr>
      <% } %>
      </tbody>
    </table>
  </div>
</div>
</body>
</html>
