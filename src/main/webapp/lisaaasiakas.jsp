<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1" name="viewport"
	content="width=device-width, initial-scale=1">
<script src="scripts/main.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="css/tyylit.css" rel="stylesheet">
<title>Uusi asiakas</title>
</head>
<body>
	<p></p>
	<h1 class="container">Lisää asiakas</h1>
	<p></p>

	<div class="container">
		<form id="tiedot">
			<table class="table table-dark table-striped">
				<thead>
					<tr>
						<th colspan="5" class="oikealle pointer"><span id="takaisin">Takaisin listaan</span></th>
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
					<tr>
						<td><input class="form-control" type="text" name="etunimi" id="etunimi"></td>
						<td><input class="form-control" type="text" name="sukunimi" id="sukunimi"></td>
						<td><input class="form-control" type="text" name="puhelin" id="puhelin"></td>
						<td><input class="form-control" type="text" name="sposti" id="sposti"></td>
						<td><input class="btn bg-white text-dark" type="submit" id="tallenna" value="Lisää"></td>
					</tr>
					<tr>
						<th colspan="5"></th>
					</tr>
					<tr>
						<th colspan="5"><span class="viesti" id="viesti"></span></th>
					</tr>
				</tbody>
			</table>
		</form>

	</div>
	<div class="container" id="viesti"></div>

</body>

<script>
	$(document).ready(function() {
		$("#takaisin").click(function() {
			document.location = "listaaasiakkaat.jsp";
		});
		
		$("#tiedot").validate({
			rules : {
				etunimi : {
					required : true,
					minlength : 2
				},
				sukunimi : {
					required : true,
					minlength : 2
				},
				puhelin : {
					required : true,
					number : true
				},
				sposti : {
					required : true,
					email : true
				}
			},
			messages : {
				etunimi : {
					required : "Etunimi puuttuu",
					minlength : "Etunimi on liian lyhyt"
				},
				sukunimi : {
					required : "Sukunimi puuttuu",
					minlength : "Sukunimi on liian lyhyt"
				},
				puhelin : {
					required : "Puhelinnumero puuttuu",
					number : "Tarkista puhelinnumero"
				},
				sposti : {
					required : "Sähköpostiosoite puuttuu",
					email : "Anna toimiva sähköpostiosoite"
				}

			},
			submitHandler : function(form) {
				lisaaTiedot();
			}

		});
	});

	function lisaaTiedot() {
		var formJsonStr = formDataJsonStr($("#tiedot").serializeArray());
		$.ajax({
			url : "asiakkaat",
			data : formJsonStr,
			type : "POST",
			dataType : "json",
			success : function(result) {
				if (result.response == 0) {
					$("#viesti").html("Asiakkaan lisääminen epäonnistui");
				} else if (result.response == 1) {
					$("#viesti").html("Asiakkaan lisääminen onnistui");
					//$("#etunimi", "#sukunimi", "#puhelin", "#sposti").val(""); EI TOIMI JOSTAIN SYYSTÄ	
					setInterval('refreshPage()', 1000)
				}
			}});
	}
	
	function refreshPage() {
	    location.reload(true);
	}
</script>
</html>