<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.app.parking.model.SupportTicket" %>
<%
    SupportTicket ticket = (SupportTicket) request.getAttribute("ticket");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Ticket Details</title>
    <link rel="stylesheet" href="css/ticketStyles.css">
</head>
<body>
<div class="ticket-container animate-fadeIn">
    <div class="ticket-header animate-slideDown">
        <h2><%= ticket.getSubject() %></h2>
        <div class="ticket-meta">
            Submitted by: <strong><%= ticket.getUserId() %></strong> on <%= ticket.getSubmissionDate() %>
        </div>
    </div>

    <div class="ticket-message card">
        <h4>Original Message:</h4>
        <p><%= ticket.getMessage() %></p>
    </div>

    <% if (ticket.isResolved()) { %>
    <div class="ticket-response card animate-pop">
        <h4>Admin Response:</h4>
        <p><%= ticket.getResponse() %></p>
        <div class="ticket-meta">
            Responded on <%= ticket.getResponseDate() %>
        </div>
    </div>
    <% } else { %>
    <form class="response-form card animate-slideUp" action="feedback" method="post">
        <input type="hidden" name="action" value="respond-ticket">
        <input type="hidden" name="ticketId" value="<%= ticket.getFeedbackId() %>">

        <h4>Respond to Ticket:</h4>
        <textarea name="response" required placeholder="Type your response here..."></textarea>

        <div class="button-group">
            <button type="submit" class="btn btn-submit">Submit Response</button>
            <a href="feedback?action=manage" class="btn btn-back">Back to Tickets</a>
        </div>
    </form>
    <% } %>
</div>
</body>
</html>
