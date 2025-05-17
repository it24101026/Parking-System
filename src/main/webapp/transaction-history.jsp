<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="lk.sliit.parkingsystem.parkingsystem.model.ParkingTransaction" %>
<%@ page import="java.util.List" %>
<%
    List<ParkingTransaction> transactions = (List<ParkingTransaction>) request.getAttribute("transactions");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Transaction History</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/transactionStyles.css">
</head>
<body>
<div class="container animate-fadeIn">
    <div class="card animate-slideUp">
        <h2 class="title">🚗 Parking Transaction History</h2>

        <div class="table-wrapper">
            <table class="transaction-table">
                <thead>
                <tr>
                    <th>Transaction ID</th>
                    <th>Vehicle ID</th>
                    <th>Slot ID</th>
                    <th>Entry Time</th>
                    <th>Exit Time</th>
                    <th>Duration (hours)</th>
                    <th>Fee</th>
                    <th>Status</th>
                    <th>Payment Method</th>
                </tr>
                </thead>
                <tbody>
                <% for (ParkingTransaction t : transactions) { %>
                <tr class="hover-row">
                    <td><%= t.getTransactionId() %></td>
                    <td><%= t.getVehicleId() %></td>
                    <td><%= t.getSlotId() %></td>
                    <td><%= t.getEntryTime() %></td>
                    <td><%= t.getExitTime() != null ? t.getExitTime() : "N/A" %></td>
                    <td><%= t.getExitTime() != null ? t.getDurationHours() : "N/A" %></td>
                    <td><%= String.format("%.2f", t.getFee()) %> LKR</td>
                    <td class="<%= t.isPaid() ? "status-paid" : "status-unpaid" %>">
                        <%= t.isPaid() ? "Paid" : "Unpaid" %>
                    </td>
                    <td><%= t.getPaymentMethod() != null ? t.getPaymentMethod() : "N/A" %></td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>

        <div class="btn-wrapper">
            <a href="admin-dashboard.jsp" class="btn-back">← Back to Dashboard</a>
        </div>
    </div>
</div>
</body>
</html>
