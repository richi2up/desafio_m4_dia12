require 'uri'
require 'net/http'
require 'json'

# Método para hacer la solicitud a la API y obtener el resultado como hash
def request(url)
  uri = URI(url)
  response = Net::HTTP.get(uri)
  JSON.parse(response)
end

# Método para construir la página web con las imágenes obtenidas
def build_web_page(data)
  html = "<html>\n<head>\n</head>\n<body>\n<ul>\n"
  # Iterar sobre las fotos y agregar cada imagen al HTML
  data['photos'].each do |photo|
    html += "<li><img src='#{photo['img_src']}'></li>\n"
  end
  html += "</ul>\n</body>\n</html>"
  
  # Escribir el HTML en un archivo
  File.write('fotos_marte.html', html)
end

# Método para contar la cantidad de fotos por cada cámara
def photos_count(data)
  count = Hash.new(0)
  data['photos'].each do |photo|
    camera_name = photo['camera']['name']
    count[camera_name] += 1
  end
  count
end

# Usar la API de la NASA 
api_key = "TvMvHsnwpMsJcpCu7OSs37XbHid9LZyGJ08AaD5zn"
sol = 15 # Cambia este valor si quieres más o menos fotos
url = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=#{sol}&api_key=vMvHsnwpMsJcpCu7OSs37XbHid9LZyGJ08AaD5zn"

# Obtener los datos de la API
data = request(url)

# Generar la página web
build_web_page(data)

# Contar las fotos por cámara
puts photos_count(data)
