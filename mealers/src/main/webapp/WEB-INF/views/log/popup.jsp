<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>일정 추가</title>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<style type="text/css">
body {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    background-color: rgba(0, 0, 0, 0.5);
}

.modal-dialog {
    max-width: 500px;
}
</style>
</head>
<body>
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">일정추가</h5>
                <button type="button" class="btn-close" aria-label="Close" onclick="window.close()"></button>
            </div>
            <div class="modal-body">
                <form id="eventForm">
                    <div class="mb-3">
                        <label for="eventName" class="form-label">일정이름</label>
                        <input type="text" class="form-control" id="eventName" name="eventName" required>
                    </div>
                    <div class="mb-3">
                        <label for="eventTime" class="form-label">추가일정</label>
                        <input type="text" class="form-control" id="eventTime" name="eventTime" required>
                    </div>
                    <button type="submit" class="btn btn-primary">일정추가</button>
                </form>
            </div>
        </div>
    </div>
    
    <script type="text/javascript">
    document.getElementById('eventForm').addEventListener('submit', function(event) {
        event.preventDefault();
        // 기능추가해주어야함
        alert('일정등록완료');
        window.close();
    });
    </script>
    
</body>
</html>