<%@ include file="common/header.jspf" %>
<script type="text/javascript">
    window.onload = function() {

        var dps = [[]];
        var chart = new CanvasJS.Chart("chartContainer", {
            theme: "light2",
            title: {
                text: "Covid Stats"
            },
            subtitles: [{
                text: ""
            }],
            legend: {
                cursor: "pointer",
                itemclick: explodeSlice
            },
            data: [{
                type: "doughnut",
                showInLegend: true,
                indexLabelPlacement: "inside",
                indexLabelFontColor: "#111",
                indexLabel: "{y}",
                yValueFormatString: "",
                dataPoints: dps[0]
            }]
        });

        var yValue;
        var name;

        <c:forEach items="${dataPointsList}" var="dataPoints" varStatus="loop">
        <c:forEach items="${dataPoints}" var="dataPoint">
        yValue = parseFloat("${dataPoint.y}");
        name = "${dataPoint.name}";
        dps[parseInt("${loop.index}")].push({
            name : name,
            y : yValue
        });
        </c:forEach>
        </c:forEach>

        chart.render();

        function explodeSlice(e) {
            if (typeof (e.dataSeries.dataPoints[e.dataPointIndex].exploded) === "undefined" || !e.dataSeries.dataPoints[e.dataPointIndex].exploded) {
                e.dataSeries.dataPoints[e.dataPointIndex].exploded = true;
            } else {
                e.dataSeries.dataPoints[e.dataPointIndex].exploded = false;
            }
            e.chart.render();
        }

    }
</script>
<div class="container my-2">
    <div class="card card-cascade wider">
        <div class="view view-cascade gradient-card-header morpheus-den-gradient">
            <h2 class="card-header-title mt-3 text-center text-light">Snippets In Graph</h2>

        </div>
        <div class="card-body card-body-cascade text-center">
            <form action="/canvasjschart">
                <div class="row">
                    <div class="col">
                        <select class="custom-select custom-select-sm" name='country' style="margin-top: 5%;">
                            <option selected>Select Country</option>
                            <c:forEach items="${countries}" var="country">
                                <option value="${country}">${country}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col">
                        <div class="text-center mb-3" style="margin-top: 5%;">
                            <button type="submit"
                                    class="btn btn-unique waves-effect waves-light btn-block btn-rounded z-depth-1a">Get
                                Snippet
                            </button>
                        </div>
                    </div>
                </div>
            </form>
            <div class="mt-3">
                <h2> Country : ${country}</h2>
            </div>
        </div>
    </div>

    <div class="card card-cascade wider mt-5">
        <div class="view view-cascade gradient-card-header morpheus-den-gradient">
            <h2 class="card-header-title mt-3 text-center text-light">Graph</h2>

        </div>
        <div class="card-body card-body-cascade text-center">
            <div id="chartContainer" style="height: 370px; width: 100%;"></div>
        </div>
    </div>
</div>
<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
</body>
</html>