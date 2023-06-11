function updateCities() {
  // Get the county select element
  var countySelect = document.getElementById("county");

  // Get the city select element
  var citySelect = document.getElementById("city");

  // Clear the city select element
  citySelect.innerHTML = "";

  // If no county is selected, do nothing
  if (countySelect.value === "") {
    return;
  }

  // Define the cities for each county
  var cities = {
    "": ["Select county first:"],
    Arad: ["Arad", "Ineu", "Pancota"],
    Arges: ["Pitesti", "Campulung", "Curtea de Arges"],
    Bacau: ["Bacau", "Onesti", "Moinesti"],
    Bihor: ["Oradea", "Salonta", "Marghita"],
    "Bistrita-Nasaud": ["Bistrita", "Nasaud", "Sangeorz-Bai"],
    Botosani: ["Botosani", "Dorohoi", "Saveni"],
    Braila: ["Braila", "Ianca", "Insuratei"],
    Brasov: ["Brasov", "Fagaras", "Sacele"],
    Bucuresti: ["Bucuresti"],
    Buzau: ["Buzau", "Ramnicu Sarat", "Nehoiu"],
    Calarasi: ["Calarasi", "Oltenita", "Fundulea"],
    "Caras-Severin": ["Resita", "Caransebes", "Oravita"],
    Cluj: ["Cluj-Napoca", "Turda", "Dej"],
    Constanta: ["Constanta", "Mangalia", "Medgidia"],
    Covasna: ["Sfantu Gheorghe", "Targu Secuiesc", "Baraolt"],
    Dambovita: ["Targoviste", "Moreni", "Gaesti"],
    Dolj: ["Craiova", "Calafat", "Dabuleni"],
    Galati: ["Galati", "Tecuci", "Targu Bujor"],
    Giurgiu: ["Giurgiu", "Bolintin-Vale", "Mihailesti"],
    Gorj: ["Targu Jiu", "Motru", "Rovinari"],
    Harghita: ["Miercurea-Ciuc", "Odorheiu Secuiesc", "Toplita"],
    Hunedoara: ["Deva", "Hunedoara", "Petrosani"],
    Ialomita: ["Slobozia", "Urziceni", "Fetesti"],
    Iasi: ["Iasi", "Pascani", "Harlau"],
    Ilfov: ["Voluntari", "Buftea", "Pantelimon"],
    Maramures: ["Baia Mare", "Sighetu Marmatiei", "Viseu de Sus"],
    Mehedinti: ["Drobeta-Turnu Severin", "Orsova", "Strehaia"],
    Mures: ["Targu Mures", "Sighisoara", "Reghin"],
    Neamt: ["Piatra Neamt", "Roman", "Targu Neamt"],
    Olt: ["Slatina", "Caracal", "Scornicesti"],
    Prahova: ["Ploiesti", "Baicoi", "Comarnic", "Breaza", "Urlati"],
    "Satu Mare": ["Satu Mare", "Carei", "Negresti-Oas", "Ardud", "Livada"],
    Salaj: ["Zalau", "Simleu Silvaniei", "Jibou", "Cehu Silvaniei", "Barcau"],
    Sibiu: ["Sibiu", "Medias", "Cisnadie", "Avrig", "Saliste"],
    Suceava: [
      "Suceava",
      "Falticeni",
      "Radauti",
      "Vatra Dornei",
      "Gura Humorului",
    ],
    Teleorman: [
      "Alexandria",
      "Rosiorii de Vede",
      "Turnu Magurele",
      "Zimnicea",
      "Videle",
    ],
    Timis: ["Timisoara", "Lugoj", "Jimbolia", "Buzias", "Faget"],
    Vaslui: ["Vaslui", "Barlad", "Husi", "Negresti", "Murgeni"],
    Valcea: ["Hunedoara", "Deva", "Petrosani", "Lupeni", "Vulcan"],
    Vrancea: ["Focsani", "Adjud", "Panciu", "Marasesti", "Odobesti"],
  };

  if (cities.hasOwnProperty(county)) {
    citySelect.disabled = false;
    citySelect.options.length = 0;
    var cityOptions = cities[county];
    for (var i = 0; i < cityOptions.length; i++) {
      var option = new Option(cityOptions[i], cityOptions[i]);
      citySelect.options.add(option);
    }
  } else {
    citySelect.disabled = true;
    citySelect.options.length = 0;
    var option = new Option("--Select County First--", "");
    citySelect.options.add(option);
  }
}
