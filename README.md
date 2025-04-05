# CreateExpressProject is a Node/Express/TypeScript Project Initializer

This Bash script automates the initial setup of a Node.js project using Express and TypeScript. It performs several tasks to quickly get you started with a ready-to-run boilerplate.

## Features

- **Node.js Version Check:**  
  Verifies that Node.js is installed and meets the minimum version requirement (>= 19.9.0).

- **Flexible Project Directory:**  
  Prompts for a project directory (name or full path). If the directory exists, it will continue working in it; otherwise, it will be created.

- **Package Manager Initialization:**  
  Asks which package manager to use (npm, yarn, pnpm, or bun) and initializes a `package.json` file using the selected manager.

- **Dependency Installation:**  
  Automatically installs essential dependencies:
  - **TypeScript**
  - **Express** along with its type definitions (`@types/express`)
  - **ts-node-dev** for development
  - **dotenv** for managing environment variables

- **Project Structure and Boilerplate:**  
  Creates a basic project structure that includes:
  - A boilerplate server in `src/index.ts` that sets up an Express server, loads environment variables from a `.env` file, and responds with "Hello World" at the root path.
  - A default `.env` file with a predefined PORT value.
  - A basic TypeScript configuration (`tsconfig.json`) is generated.

- **Automated Script Configuration (npm only):**  
  If using npm, the script automatically sets up common scripts in the `package.json` for development (`dev`), building (`build`), starting (`start`), and testing (`test`).

## Requirements

- **Bash**: The script is written in Bash.
- **Node.js**: Version 19.9.0 or higher.
- **Package Manager**: npm, yarn, pnpm, or bun must be installed and available in your system’s PATH.

## How to Use

1. **Make the Script Executable:**

   ```bash
   chmod +x init_project.sh
   ```

2. **Run the Script:**

   ```bash
   ./init_project.sh
   ```

3. **Follow the Interactive Prompts:**
   - Enter the project directory (name or full path). The script will create the directory if it doesn’t exist.
   - Confirm that your Node.js installation meets the minimum version requirement.
   - Choose your preferred package manager (npm, yarn, pnpm, or bun). The script checks that the selected manager is installed.
   - The script will then initialize a `package.json`, install dependencies, add project scripts (for npm), and set up the project structure.

4. **Start Developing:**
   - For development with npm:
     ```bash
     npm run dev
     ```
   - To build the project:
     ```bash
     npm run build
     ```
   - To start the compiled server:
     ```bash
     npm start
     ```

## Project Structure

After running the script, your project will have a structure similar to this:

```
├── node_modules
├── src
│   ├── controllers
│   ├── models
│   ├── routes
│   ├── index.ts       # Boilerplate Express server
│   └── types.d.ts     # Type declarations
├── .env               # Environment variables file
├── package.json
├── package-lock.json  (if using npm)
└── tsconfig.json      # TypeScript configuration
```

## Customization

- **Modify Scripts:**  
  The script automatically adds the common scripts to `package.json` when using npm. For other package managers, you might want to update the scripts manually if needed.

- **Extend the Boilerplate:**  
  The `src/index.ts` file contains a simple Express server that you can expand with additional routes, controllers, and business logic.

## Troubleshooting

- **Node.js Version:**  
  Ensure your Node.js installation is at least version 19.9.0. If not, update Node.js before running the script.

- **Package Manager:**  
  Verify that the package manager you choose is installed and accessible via your terminal.

## License

This project is distributed under the MIT License. See the [LICENSE](LICENSE) file for details.
