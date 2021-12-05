<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1" name="viewport"
	content="width=device-width, initial-scale=1">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="css/tyylit.css" rel="stylesheet">
<title>Asiakkaat</title>
</head>
<body>
	<p></p>
	<h1 class="container">Asiakkaat</h1>
	<p></p>

	<div class="container">

		<form class="row g-3 align-items-center">
			<div class="col-md-10">
				<input class="form-control" type="text" id="hakusana"
					name="hakusana" placeholder="Hakusana">
			</div>
			<div class="col-md">
				<input class="btn btn-dark" type="button" value="hae" id="hakunappi">
			</div>
		</form>
		<div class="mt-5">
			<table class="table table-dark table-striped" id="lista">
				<thead>
					<tr>
						<th colspan="5" class="oikealle pointer"><span id="uusiAsiakas">Lisää
								uusi asiakas</span></th>
					</tr>
					<tr>
						<th>Etunimi</th>
						<th>Sukunimi</th>
						<th>Puhelin</th>
						<th>Sähköposti</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
				</tbody>

			</table>
		</div>

	</div>

	<script>
		$(document).ready(function() {

			$("#uusiAsiakas").click(function() {
				document.location = "lisaaasiakas.jsp";
			});

			haeAsiakkaat();

			$("#hakunappi").click(function() {
				haeAsiakkaat();
			});

			$(document.body).on("keydown", function(event) {
				if (event.keyCode == 13) {
					event.preventDefault();
					haeAsiakkaat();
				}
			});

			$("#hakusana").focus();
		});

		function haeAsiakkaat() {
			$("#lista tbody").empty();
			$.getJSON({
				url : "asiakkaat/" + $("#hakusana").val(),
				type : "GET",
				dataType : "json",
				success : function(result) {
					$.each(result.asiakkaat, function(x, tieto) {
						var htmlStr;
						htmlStr += "<tr id='rivi_"+tieto.asiakas_id+"'>";
						htmlStr += "<td>" + tieto.etunimi + "</td>";
						htmlStr += "<td>" + tieto.sukunimi + "</td>";
						htmlStr += "<td>" + tieto.puhelin + "</td>";
						htmlStr += "<td>" + tieto.sposti + "</td>";
						htmlStr += "<td align='right'><a class='btn bg-white text-dark' href='muutaasiakas.jsp?asiakas_id="+tieto.asiakas_id+"')>Muuta</a>&nbsp;</span>&nbsp;";
						htmlStr += "<span class='btn bg-danger text-white' onclick=poista("
								+ tieto.asiakas_id + ",'" + tieto.etunimi + "','" + tieto.sukunimi + "')>Poista</span></td>";
						htmlStr += "</tr>";
						$("#lista tbody").append(htmlStr);
					});
				}
			});
		}
		function poista(asiakas_id, etunimi, sukunimi) {
			if (confirm("Poista asiakas " + etunimi + " " + sukunimi + "?")) {
				$.ajax({
					url : "asiakkaat/" + asiakas_id,
					type : "DELETE",
					dataType : "json",
					success : function(result) { 
						if (result.response == 0) {
							$("#viesti").html("Asiakkaan poisto epäonnistui.");
						} else if (result.response == 1) {
							$("#rivi_" + asiakas_id).css("background-color", "red"); 
							alert("Asiakkaan " + etunimi + " " + sukunimi + " poisto onnistui.");
							haeAsiakkaat();
						}
					}
				});
			}
		}
	</script>

</body>
</html>


