body {
    background: #f4f6f8;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    margin: 0;
    padding: 30px;
}

.container {
    max-width: 1100px;
    margin: 0 auto;
    padding: 20px;
}

.header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
}

.header h1 {
    color: #333;
    font-size: 26px;
}

.btn {
    padding: 10px 15px;
    border: none;
    border-radius: 6px;
    text-decoration: none;
    font-weight: 500;
    color: white;
    background-color: #4CAF50;
    transition: background-color 0.3s, transform 0.2s;
}

.btn:hover {
    background-color: #45a049;
    transform: translateY(-2px);
}

.btn-secondary {
    background-color: #888;
}

.btn-secondary:hover {
    background-color: #777;
}

.view-options {
    margin-bottom: 20px;
    display: flex;
    gap: 10px;
    flex-wrap: wrap;
}

.view-options .btn.active {
    background-color: #357a38;
}

.table-wrapper {
    overflow-x: auto;
}

.styled-table {
    width: 100%;
    border-collapse: collapse;
    background-color: white;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.06);
    border-radius: 8px;
    overflow: hidden;
}

.styled-table thead tr {
    background-color: #4CAF50;
    color: white;
    text-align: left;
}

.styled-table th,
.styled-table td {
    padding: 12px 16px;
}

.styled-table tbody tr {
    border-bottom: 1px solid #dddddd;
    transition: background-color 0.3s;
}

.styled-table tbody tr:hover {
    background-color: #f1f1f1;
}

.styled-table tbody tr.available {
    background-color: #e8fce8;
}

.styled-table tbody tr.occupied {
    background-color: #fdecea;
}

.action-link {
    color: #007BFF;
    text-decoration: none;
    margin: 0 3px;
    font-weight: 500;
}

.action-link:hover {
    text-decoration: underline;
}

.action-link.delete {
    color: #e74c3c;
}

/* Animations */
@keyframes fadeIn {
    from { opacity: 0; transform: translateY(30px); }
    to { opacity: 1; transform: translateY(0); }
}

.animate-fade-in {
    animation: fadeIn 0.7s ease-in-out;
}
