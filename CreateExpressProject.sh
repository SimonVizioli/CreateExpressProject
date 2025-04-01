#!/bin/bash
set -euo pipefail

# ===== Funciones de impresión =====
print_msg() {
    local msg="$1"
    local style="$2"  # Código ANSI para formato y color
    echo -e "\n${style}${msg}\e[0m\n"
}

# Definición de estilos para mensajes
BOLD_GREEN="\e[1m\e[32m"
BOLD_BLUE="\e[1m\e[37m\e[44m"
BOLD_CYAN="\e[1m\e[36m"

# ===== Mensaje de Bienvenida =====
echo -e "${BOLD_CYAN}"
echo "   ██████╗██████╗ ███████╗ █████╗ ████████╗███████╗    ███████╗██╗  ██╗██████╗ ██████╗ ███████╗███████╗███████╗    ██████╗ ██████╗  ██████╗      ██╗███████╗ ██████╗████████╗ "
echo "  ██╔════╝██╔══██╗██╔════╝██╔══██╗╚══██╔══╝██╔════╝    ██╔════╝╚██╗██╔╝██╔══██╗██╔══██╗██╔════╝██╔════╝██╔════╝    ██╔══██╗██╔══██╗██╔═══██╗     ██║██╔════╝██╔════╝╚══██╔══╝ "
echo "  ██║     ██████╔╝█████╗  ███████║   ██║   █████╗      █████╗   ╚███╔╝ ██████╔╝██████╔╝█████╗  ███████╗███████╗    ██████╔╝██████╔╝██║   ██║     ██║█████╗  ██║        ██║    "
echo "  ██║     ██╔══██╗██╔══╝  ██╔══██║   ██║   ██╔══╝      ██╔══╝   ██╔██╗ ██╔═══╝ ██╔══██╗██╔══╝  ╚════██║╚════██║    ██╔═══╝ ██╔══██╗██║   ██║██   ██║██╔══╝  ██║        ██║    "
echo "  ╚██████╗██║  ██║███████╗██║  ██║   ██║   ███████╗    ███████╗██╔╝ ██╗██║     ██║  ██║███████╗███████║███████║    ██║     ██║  ██║╚██████╔╝╚█████╔╝███████╗╚██████╗   ██║    "
echo "   ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝    ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝    ╚═╝     ╚═╝  ╚═╝ ╚═════╝  ╚════╝ ╚══════╝ ╚═════╝   ╚═╝    "
echo -e "\e[0m"  # Restablecer formato

# ===== Solicitar la ruta del proyecto =====
read -r -p "Ingrese el nombre o ruta de la carpeta donde quiere crear (o usar) el proyecto: " PROJECT_PATH

if [ -d "$PROJECT_PATH" ]; then
    echo "La carpeta '$PROJECT_PATH' ya existe. Se continuará trabajando en ella."
else
    mkdir -p "$PROJECT_PATH"
    echo "La carpeta '$PROJECT_PATH' no existía y se ha creado."
fi

cd "$PROJECT_PATH"
print_msg "Ahora todas las operaciones se realizarán dentro de la carpeta '$PROJECT_PATH'" "$BOLD_GREEN"

# ===== Verificación de Node.js =====
if ! command -v node &> /dev/null; then
    echo "Error: Node.js no está instalado. Instálalo y vuelve a intentarlo."
    exit 1
fi

REQUIRED_NODE_VERSION="19.9.0"
CURRENT_NODE_VERSION=$(node -v | sed 's/^v//')
if [ "$(printf '%s\n' "$REQUIRED_NODE_VERSION" "$CURRENT_NODE_VERSION" | sort -V | head -n1)" != "$REQUIRED_NODE_VERSION" ]; then
    echo "Error: La versión instalada de Node.js ($CURRENT_NODE_VERSION) es menor que la requerida ($REQUIRED_NODE_VERSION)."
    exit 1
fi
echo "La versión de Node.js instalada es: v${CURRENT_NODE_VERSION}"

# ===== Selección del Gestor de Paquetes =====
read -r -p "Ingrese el gestor de paquetes que desea usar (npm, yarn, pnpm, bun): " PKG_MANAGER
if ! command -v "$PKG_MANAGER" &> /dev/null; then
    echo "Error: $PKG_MANAGER no está instalado o no es reconocido."
    exit 1
fi

# ===== Inicialización del package.json =====
echo "Inicializando package.json con $PKG_MANAGER..."
case "$PKG_MANAGER" in
    npm)
        npm init -y
        ;;
    yarn)
        yarn init
        ;;
    pnpm)
        pnpm init
        ;;
    bun)
        bun init
        ;;
    *)
        echo "Gestor de paquetes desconocido: $PKG_MANAGER"
        exit 1
        ;;
esac

# ===== Funciones para instalar dependencias =====
install_package() {
    local package="$1"
    local is_dev="${2:-false}"
    case "$PKG_MANAGER" in
        npm)
            if [ "$is_dev" = "true" ]; then
                npm install "$package" -D
            else
                npm install "$package"
            fi
            ;;
        yarn)
            if [ "$is_dev" = "true" ]; then
                yarn add "$package" --dev
            else
                yarn add "$package"
            fi
            ;;
        pnpm)
            if [ "$is_dev" = "true" ]; then
                pnpm add "$package" -D
            else
                pnpm add "$package"
            fi
            ;;
        bun)
            if [ "$is_dev" = "true" ]; then
                bun add "$package" --dev
            else
                bun add "$package"
            fi
            ;;
    esac
}

# Función para inicializar TypeScript
run_tsc_init() {
    case "$PKG_MANAGER" in
        npm)
            npx tsc --init
            ;;
        yarn)
            yarn tsc --init
            ;;
        pnpm)
            pnpm exec tsc --init
            ;;
        bun)
            bun x tsc --init
            ;;
    esac
}

# ===== Instalación de Dependencias =====
echo "Instalando dependencias..."
install_package typescript true
print_msg "TypeScript instalado correctamente" "$BOLD_BLUE"

install_package express
print_msg "Express instalado correctamente" "$BOLD_GREEN"

install_package "@types/express" true
print_msg "Types para Express instalados correctamente" "$BOLD_GREEN"

install_package ts-node-dev true
print_msg "ts-node-dev instalado correctamente" "$BOLD_GREEN"

install_package dotenv
print_msg "dotenv instalado correctamente" "$BOLD_GREEN"

echo "Contenido de package.json:"
cat package.json

if [ "$PKG_MANAGER" = "npm" ]; then
    npm set-script dev "ts-node-dev --respawn --transpile-only src/index.ts"
    npm set-script build "tsc"
    npm set-script start "node build/index.js"
    npm set-script test "echo \"Error: no test specified\" && exit 1"
    print_msg "Scripts agregados al package.json usando npm set-script" "$BOLD_GREEN"
fi

# ===== Crear estructura de carpetas y archivos =====
mkdir -p src/routes src/controllers src/models

# Crear un boilerplate básico en src/index.ts
cat <<'EOF' > src/index.ts
import express from 'express';
import dotenv from 'dotenv';

// Cargar variables de entorno desde .env
dotenv.config();

const app = express();
const PORT = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.send('Hello World');
});

app.listen(PORT, () => {
  console.log(`Servidor corriendo en el puerto ${PORT}`);
});
EOF

# Crear el archivo de tipados
touch src/types.d.ts

# Crear archivo .env con configuración predeterminada
cat <<EOF > .env
PORT=3000
EOF

print_msg "Configurando TypeScript..." "$BOLD_BLUE"
run_tsc_init
print_msg "Archivo tsconfig.json creado" "$BOLD_GREEN"

print_msg "Listado de archivos en el directorio actual:" "$BOLD_GREEN"
ls -l

# ===== Mostrar estructura de carpetas =====
print_folders() {
    echo -e "${BOLD_CYAN}$1\e[0m"
}

echo "Estructura de Carpeta:"
echo ""
print_folders "├── node_modules"
print_folders "├── src"
print_folders "│   ├── routes"
print_folders "│   ├── service"
print_folders "│   ├── index.ts"
print_folders "│   └── types.d.ts"
print_folders "├── .env"
print_folders "├── package.json"
print_folders "├── package-lock.json"
print_folders "└── tsconfig.json"
echo ""

print_folders "*************************************"
print_folders "*      ¡El script ha finalizado!     *"
print_folders "*************************************"
