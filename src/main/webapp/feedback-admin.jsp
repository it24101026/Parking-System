<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="lk.sliit.parkingsystem.parkingsystem.model.SupportTicket" %>
<%@ page import="lk.sliit.parkingsystem.parkingsystem.model.Feedback" %>
<%@ page import="java.util.List" %>
<%
  List<SupportTicket> unresolvedTickets = (List<SupportTicket>) request.getAttribute("unresolvedTickets");
  List<Feedback> allFeedback = (List<Feedback>) request.getAttribute("allFeedback");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Feedback Management</title>
  <link rel="stylesheet" href="css/feedback-management.css">
</head>
<body>
<div class="container">
  <div class="card">
    <h2>Feedback Management Dashboard</h2>

    <!-- Unresolved Support Tickets Section -->
    <div class="section">
      <h3>Unresolved Support Tickets</h3>
      <% if (unresolvedTickets.isEmpty()) { %>
      <p class="empty">No unresolved tickets.</p>
      <% } else { %>
      <div class="table-container">
        <table>
          <thead>
          <tr>
            <th>Date</th>
            <th>User ID</th>
            <th>Subject</th>
            <th>Actions</th>
          </tr>
          </thead>
          <tbody>
          <% for (SupportTicket ticket : unresolvedTickets) { %>
          <tr>
            <td><%= ticket.getSubmissionDate() %></td>
            <td><%= ticket.getUserId() %></td>
            <td><%= ticket.getSubject() %></td>
            <td>
              <a href="feedback?action=view-ticket&id=<%= ticket.getFeedbackId() %>" class="btn btn-primary">
                Respond
              </a>
            </td>
          </tr>
          <% } %>
          </tbody>
        </table>
      </div>
      <% } %>
    </div>

    <!-- All Feedback Items Section -->
    <div class="section">
      <h3>All Feedback Items</h3>
      <% if (allFeedback.isEmpty()) { %>
      <p class="empty">No feedback items found.</p>
      <% } else { %>
      <div class="table-container">
        <table>
          <thead>
          <tr>
            <th>Date</th>
            <th>User ID</th>
            <th>Type</th>
            <th>Subject</th>
            <th>Status</th>
          </tr>
          </thead>
          <tbody>
          <% for (Feedback feedback : allFeedback) { %>
          <tr>
            <td><%= feedback.getSubmissionDate() %></td>
            <td><%= feedback.getUserId() %></td>
            <td class="<%= feedback instanceof SupportTicket ? "highlight-ticket" : "" %>">
              <%= feedback instanceof SupportTicket ? "Ticket" : "Feedback" %>
            </td>
            <td><%= feedback.getSubject() %></td>
            <td class="<%= feedback.isResolved() ? "status-resolved" : "status-pending" %>">
              <%= feedback.isResolved() ? "Resolved" : "Pending" %>
            </td>
          </tr>
          <% } %>
          </tbody>
        </table>
      </div>
      <% } %>
    </div>

    <!-- Back Button -->
    <div class="actions">
      <a href="admin-dashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
    </div>
  </div>
</div>
</body>
</html>
