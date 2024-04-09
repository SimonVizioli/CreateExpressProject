#!/bin/bash

# Función para imprimir texto en negrita y con color
function print_decorated {
    echo ""
    echo -e "\e[1m\e[32m$1\e[0m"  # \e[1m para negrita, \e[32m para color verde, \e[0m para restablecer formato
    echo ""
}
function print_azul {
    echo ""
    echo -e "\e[1m\e[37m\e[44m$1\e[0m"  # \e[1m para negrita, \e[32m para color verde, \e[0m para restablecer formato
    echo ""
}

# Mensaje de bienvenida decorado
echo -e "\e[1m\e[36m"
echo "   ██████╗██████╗ ███████╗ █████╗ ████████╗███████╗    ███████╗██╗  ██╗██████╗ ██████╗ ███████╗███████╗███████╗    ██████╗ ██████╗  ██████╗      ██╗███████╗ ██████╗████████╗ "
echo "  ██╔════╝██╔══██╗██╔════╝██╔══██╗╚══██╔══╝██╔════╝    ██╔════╝╚██╗██╔╝██╔══██╗██╔══██╗██╔════╝██╔════╝██╔════╝    ██╔══██╗██╔══██╗██╔═══██╗     ██║██╔════╝██╔════╝╚══██╔══╝ "
echo "  ██║     ██████╔╝█████╗  ███████║   ██║   █████╗      █████╗   ╚███╔╝ ██████╔╝██████╔╝█████╗  ███████╗███████╗    ██████╔╝██████╔╝██║   ██║     ██║█████╗  ██║        ██║    "
echo "  ██║     ██╔══██╗██╔══╝  ██╔══██║   ██║   ██╔══╝      ██╔══╝   ██╔██╗ ██╔═══╝ ██╔══██╗██╔══╝  ╚════██║╚════██║    ██╔═══╝ ██╔══██╗██║   ██║██   ██║██╔══╝  ██║        ██║    "
echo "  ╚██████╗██║  ██║███████╗██║  ██║   ██║   ███████╗    ███████╗██╔╝ ██╗██║     ██║  ██║███████╗███████║███████║    ██║     ██║  ██║╚██████╔╝╚█████╔╝███████╗╚██████╗   ██║    "
echo "   ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝    ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝    ╚═╝     ╚═╝  ╚═╝ ╚═════╝  ╚════╝ ╚══════╝ ╚═════╝   ╚═╝    "
echo -e "\e[0m"  # Restablecer formato                                                                                                                                                                             
                                                                                                                                                                                   
                                                                                                                                                        
# Define la versión de Node.js que deseas verificar y establecer
version_deseada="19.9.0"

# Verifica si Node.js está instalado y obtiene la versión actual
node_version=$(node -v 2>/dev/null)

# Verifica si node_version está vacío, lo que significa que Node.js no está instalado
if [ -z "$node_version" ]; then
    echo "Node.js no está instalado."
    # Aquí puedes agregar comandos para instalar Node.js, dependiendo de tu sistema operativo
else
    echo "La versión de Node.js instalada es: $node_version"
    # Compara la versión actual con la versión deseada
    if [ "$node_version" != "v$version_deseada" ]; then
        echo "La versión de Node.js no es la requerida. Estableciendo la versión $version_deseada..."
        # Aquí puedes agregar comandos para instalar la versión deseada de Node.js, dependiendo de tu sistema operativo
    else
        echo "La versión de Node.js es la requerida: $version_deseada"
    fi
fi

# Solicitar al usuario el nombre de la carpeta
echo "Ingrese el nombre de la carpeta donde quiere crear el proyecto:"
read carpeta_nombre

# Crear la carpeta
mkdir "$carpeta_nombre"

# Cambiar al directorio recién creado
cd "$carpeta_nombre" || exit

print_decorated "Ahora todas las operaciones se realizarán dentro de la carpeta "$carpeta_nombre""

touch package.json
ls -l

cat <<EOF > package.json
{
    "name": "$carpeta_nombre",
    "version": "1.0.0",
    "description": "",
    "main": "index.js",

    "scripts": {
        "dev": "ts-node-dev src/index.ts",
        "start": "node build/index.js",
        "tsc": "tsc",
        "test": "echo \"Error: no test specified\" && exit 1"
    },

    "keywords": [],
    "author": "",
    "license": "ISC"
}
EOF

echo "Creado archivo package.json"

echo Instalando dependencias..

npm install typescript -D 
print_azul "TypeScript Instalado correctamente"

npm install express 
print_decorated "Express Instalado correctamente"

npm i @types/express -D
print_decorated "Types para Express Instalado correctamente"

npm i ts-node-dev -D 
print_decorated "ts-node-dev Instalado correctamente"

cat package.json

mkdir src && touch src/index.ts && touch src/types.d.ts && mkdir src/routes && mkdir src/service

print_azul "Configurando TypeScript..."

npm run tsc -- --init

print_decorated "Creado tsconfig.ts"
print_decorated "Listado de archivos en el directorio actual:"
ls -l   

#!/bin/bash

# Función para imprimir texto en negrita y con color
function print_folders {
    echo -e "\e[1m\e[36m$1\e[0m"  # \e[1m para negrita, \e[36m para color cyan, \e[0m para restablecer formato
}

echo "Estructura de Carpeta"
# Mensaje de estructura de directorio personalizada
echo "" 
print_folders "├── node_modules"
print_folders "├── src"
print_folders "│   ├── routes"
print_folders "│   ├── service"
print_folders "│   └── index.ts"
print_folders "├── package.json"
print_folders "├── package-lock.json"
print_folders "└── tsconfig.ts"
echo ""

print_folders "*************************************"
print_folders "*      ¡El script ha finalizado!     *"
print_folders "*************************************"