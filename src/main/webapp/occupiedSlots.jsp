<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.app.parking.model.User" %>
<%@ page import="com.app.parking.model.Vehicle" %>
<%@ page import="com.app.parking.model.ParkingSlot" %>
<%@ page import="java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    List<ParkingSlot> occupiedSlots = (List<ParkingSlot>) request.getAttribute("occupiedSlots");
    List<Vehicle> vehicles = (List<Vehicle>) request.getAttribute("vehicles");
    String error = (String) request.getAttribute("error");
    String success = (String) request.getAttribute("success");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Occupied Parking Slots</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="css/occupied-slots.css" rel="stylesheet" />
</head>

<body class="bg-gray-100 animate-fadeIn">
<header class="bg-gradient-to-r from-blue-600 to-blue-500 text-white p-6 shadow-lg">
    <div class="max-w-7xl mx-auto flex justify-between items-center">
        <h1 class="text-4xl font-bold tracking-wide animate-slideIn">Occupied Slots</h1>
        <div class="flex space-x-3">
            <a href="parking-slots?action=operator-view"
               class="transition duration-300 ease-in-out transform hover:scale-105 bg-white text-blue-600 px-4 py-2 rounded-md font-semibold shadow hover:bg-blue-50">
                Dashboard
            </a>
            <a href="login.jsp"
               class="transition duration-300 ease-in-out transform hover:scale-105 bg-red-500 text-white px-4 py-2 rounded-md font-semibold shadow hover:bg-red-600">
                Logout
            </a>
        </div>
    </div>
</header>

<main class="p-6">
    <% if (error != null) { %>
    <div class="alert error animate-fadeInDown">
        <p><%= error %></p>
    </div>
    <% } %>

    <% if (success != null) { %>
    <div class="alert success animate-fadeInDown">
        <p><%= success %></p>
    </div>
    <% } %>

    <div class="max-w-7xl mx-auto bg-white p-8 rounded-xl shadow-xl animate-fadeInUp">
        <div class="flex justify-between items-center mb-6">
            <h2 class="text-2xl font-semibold text-gray-800">Occupied Slots: <%= occupiedSlots != null ? occupiedSlots.size() : 0 %></h2>
            <a href="parking-slots?action=operator-view"
               class="btn-primary">View All Slots</a>
        </div>

        <% if (occupiedSlots != null && !occupiedSlots.isEmpty()) { %>
        <div class="overflow-x-auto">
            <table class="min-w-full divide-y divide-gray-200 table-auto">
                <thead class="bg-gray-100">
                <tr>
                    <th class="th text-center">Slot Number</th>
                    <th class="th text-center">Type</th>
                    <th class="th text-center">Vehicle</th>
                    <th class="th text-center">License Plate</th>
                    <th class="th text-center">Actions</th>
                </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                <% for (ParkingSlot slot : occupiedSlots) { %>
                <tr class="hover:bg-red-50 transition duration-300">
                    <td class="td text-center"><%= slot.getSlotNumber() %></td>
                    <td class="td text-center"><%= slot.getType() %></td>
                    <td class="td text-center break-all"><%= slot.getVehicleId() != null ? slot.getVehicleId() : "Unknown" %></td>
                    <td class="td text-center"><%= getVehicleLicensePlate(vehicles, slot.getVehicleId()) %></td>
                    <td class="td text-center">
                        <div class="flex justify-center space-x-2">
                            <form action="transactions" method="post">
                                <input type="hidden" name="action" value="checkout">
                                <input type="hidden" name="slotId" value="<%= slot.getSlotId() %>">
                                <button type="submit" class="btn-warning">Checkout</button>
                            </form>
                            <form action="parking-slots" method="post"
                                  onsubmit="return confirm('Are you sure you want to release this vehicle?');">
                                <input type="hidden" name="action" value="release">
                                <input type="hidden" name="id" value="<%= slot.getSlotId() %>">
                                <button type="submit" class="btn-danger">Release</button>
                            </form>
                        </div>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
        <% } else { %>
        <div class="text-center py-16 animate-fadeInUp">
            <svg class="mx-auto h-12 w-12 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                      d="M9.172 16.172a4 4 0 015.656 0M9 10h.01M15 10h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
            </svg>
            <h3 class="mt-4 text-xl font-semibold text-gray-900">No occupied slots</h3>
            <p class="mt-2 text-gray-600">All parking slots are currently available.</p>
            <a href="parking-slots?action=operator-view" class="mt-6 btn-primary">View All Slots</a>
        </div>
        <% } %>
    </div>
</main>
</body>
</html>

<%!
    private String getVehicleLicensePlate(List<Vehicle> vehicles, String vehicleId) {
        if (vehicles == null || vehicleId == null) return "N/A";
        for (Vehicle vehicle : vehicles) {
            if (vehicle.getVehicleId().equals(vehicleId)) {
                return vehicle.getLicensePlate();
            }
        }
        return "N/A";
    }
%>
