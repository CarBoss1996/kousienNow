function checkUserLocation(userLocation, seats) {
    function isPointInPolygon(point, polygon) {
        var x = point.lng, y = point.lat;
        
        var inside = false;
        for (var i = 0, j = polygon.length - 1; i < polygon.length; j = i++) {
            var xi = polygon[i].lng, yi = polygon[i].lat;
            var xj = polygon[j].lng, yj = polygon[j].lat;
            
            var intersect = ((yi > y) !== (yj > y)) && (x < (xj - xi) * (y - yi) / (yj - yi) + xi);
            if (intersect) inside = !inside;
        }
        
        return inside;
    };

    var userInSeat = false;
    for (var i = 0; i < seats.length; i++) {
        if (isPointInPolygon(userLocation, seats[i].spots)) {
            alert(`今日は${seats[i].seat_name}から応援ですか？`);
            userInSeat = true;
            break;
        }
    }

    if (!userInSeat) {
        location_id = 9;
        alert("今日は自宅から応援ですか？");
    }
}