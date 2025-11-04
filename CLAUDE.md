# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Delphi VCL application called "Project2" that implements a contact management system with MVC architecture. The application manages contacts, companies, and favorites with PostgreSQL database connectivity.

## Build and Development Commands

### Building the Project
```bash
# Build Debug configuration (default)
msbuild Project2.dproj /p:Config=Debug /p:Platform=Win32

# Build Release configuration
msbuild Project2.dproj /p:Config=Release /p:Platform=Win32

# Build for Win64 platform
msbuild Project2.dproj /p:Config=Debug /p:Platform=Win64
```

### Running Tests
No unit tests are currently configured in this project.

## Architecture

### MVC Pattern Implementation
The project follows a Model-View-Controller (MVC) architecture:

- **Models**: Entity classes representing business objects (TUsuarioModel, TContatosModel, EmpresaModel, etc.)
- **Views**: VCL forms for user interface (uMain.pas, uLogin.pas, uCadastroUsuariosView.pas)
- **Controllers**: Business logic and data orchestration (ContatosController, EmpresaController, etc.)
- **Repositories**: Data access layer (TUsuarioRepository, ContatosRepository, etc.)

### Key Components

1. **Main Forms**:
   - `FMain`: Main application form with tabbed interface
   - `FLogin`: User authentication form
   - `FormCadastroUsuario`: User registration form

2. **Data Access**:
   - `ConexaoBanco`: PostgreSQL database connection using FireDAC
   - Repository pattern for data operations
   - ClientDataSet components for in-memory data management

3. **Business Entities**:
   - Users (authentication and registration)
   - Contacts (CRUD operations)
   - Companies (management with CNPJ validation)
   - Favorites (contact marking system)

### Database Layer
- Uses FireDAC with PostgreSQL driver
- Connection managed through `TDataModule1` in `ConexaoBanco.pas`
- Repository classes handle all database operations

### Project Structure
```
/ProjetoFinalDelphi/
├── Controller/           # Business logic controllers
├── Model/               # Entity/model classes
├── Repository/          # Data access layer
├── View/               # VCL forms and UI components
├── Pictures/           # Application images and icons
├── Project2.dpr        # Main program entry point
├── Project2.dproj      # Delphi project configuration
└── README.md           # Project documentation
```

### Key Features
- User authentication and registration
- Contact management with CRUD operations
- Company management with CNPJ validation
- Favorites system for contacts
- Grid-based data display with inline editing
- Card-based UI navigation system
- Responsive design with dynamic resizing

### Development Notes
- Uses Delphi 20.1 (or later) with VCL framework
- PostgreSQL database backend
- FireDAC for database connectivity
- ClientDataSet for in-memory data operations
- TDBGrid components for data display
- TCardPanel for tabbed interface navigation