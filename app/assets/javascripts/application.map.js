/*$(document).ready(function(n) {*/
google.maps.event.addDomListener(window, 'load', function() {
    var opts = {
        zoom: 11,
        //center: new google.maps.LatLng(46.1420653, 8.9959221),
        center: new google.maps.LatLng(46.066084877475234, 8.928451538085938),
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        scrollwheel: false,
        zoomControl: true,
        mapTypeControl: false,
        scaleControl: false,
        streetViewControl: false,
        rotateControl: true
    };

    var gMap = new google.maps.Map(document.getElementById('map-container'), opts);

    google.maps.event.addListener(gMap, 'click', function(e) {
        var curZoom = gMap.getZoom();
        if (curZoom < 22)
            gMap.setZoom(parseInt(curZoom) + 1);
    });

    google.maps.event.addListener(gMap, 'rightclick', function(e) {
        var curZoom = gMap.getZoom();
        if (curZoom > 1)
            gMap.setZoom(parseInt(curZoom) - 1);
    });

    var path = [];
    path.push(new google.maps.LatLng('46.19931964112396', '8.995742797851562'));
    path.push(new google.maps.LatLng('46.17935497410555', '8.949050903320312'));
    path.push(new google.maps.LatLng('46.176977744996925', '8.895492553710938'));
    path.push(new google.maps.LatLng('46.14511295910613','8.895492553710938'));
    path.push(new google.maps.LatLng('46.128459837044915','8.886566162109375'));
    path.push(new google.maps.LatLng('46.122273108999224','8.896865844726562'));
    path.push(new google.maps.LatLng('46.05703226870927','8.902359008789062'));
    path.push(new google.maps.LatLng('46.01603873833416','8.887252807617188'));
    path.push(new google.maps.LatLng('46.00411630923806','8.8824462890625'));
    path.push(new google.maps.LatLng('45.92870710966921','8.903732299804688'));
    path.push(new google.maps.LatLng('45.97262874820093','8.966217041015625'));
    path.push(new google.maps.LatLng('45.98837476770814','8.975830078125'));
    path.push(new google.maps.LatLng('46.00983939593243','8.98681640625'));
    path.push(new google.maps.LatLng('46.034155908665014','8.98956298828125'));
    path.push(new google.maps.LatLng('46.0536967228988','8.954544067382812'));
    path.push(new google.maps.LatLng('46.06751410107052','8.96209716796875'));
    path.push(new google.maps.LatLng('46.08370938230368','8.949737548828125'));
    path.push(new google.maps.LatLng('46.13702492883557','8.961410522460938'));
    path.push(new google.maps.LatLng('46.160809861457125','9.019088745117188'));
    //path.push(new google.maps.LatLng('46.14416148780093','9.06646728515625'));
    path.push(new google.maps.LatLng('46.20122065978112','9.065093994140625'));

    var polygon = new google.maps.Polygon({
        path: path,
        strokeColor: '#50b98e',
        strokeOpacity: 1,
        strokeWeight: 2,
        fillColor: '#50b98e',
        fillOpacity: 0.6,
        draggable: false
    });
    polygon.setMap(gMap);
});