# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Delphi VCL application called "Project2" that implements a contact management system with MVC architecture. The application manages contacts, companies, messages, configurations and favorites with PostgreSQL database connectivity.

## Build and Development Commands

### Building the Project
```bash
# Build Debug configuration (default)
msbuild Project2.dproj /p:Config=Debug /p:Platform=Win32

# Build Release configuration
msbuild Project2.dproj /p:Config=Release /p:Platform=Win32

# Build for Win64 platform
msbuild Project2.dproj /p:Config=Debug /p:Platform=Win64

# Run the application (after build)
.\Win32\Debug\Project2.exe
```

### Running Tests
No unit tests are currently configured in this project.

## Database Configuration

### PostgreSQL Connection
- **Server**: localhost
- **Port**: 5432
- **Database**: ContactHub
- **User**: postgres
- **Password**: root
- **Driver**: FireDAC PostgreSQL (PG)
- **Library Path**: `C:\Users\ARTHUR\Documents\ProjetoFinalDelphi\lib\libpq.dll`

### Database Schema
The application uses several key tables:
- `"Contato"` - Contacts with soft delete (ativo flag)
- `"Usuario"` - User management with MD5 password hashing
- `"Empresa"` - Company records with CNPJ validation
- `"Favoritos"` - Contact favorites relationship table
- `"Mensagens"` - Message system
- `"Configuracao"` - Application settings

## Architecture

### MVC Pattern Implementation
The project follows a strict MVC architecture:

- **Models** (`Model/`): Entity classes with getter/setter methods (TContatosModel, TUsuarioModel, EmpresaModel, etc.)
- **Views** (`View/`): VCL forms with card-based navigation (uMain.pas, uLogin.pas, uCadastroUsuariosView.pas)
- **Controllers** (`Controller/`): Business logic layer (ContatosController, EmpresaController, CadastroUsuarioController)
- **Repositories** (`Repository/`): Data access using FireDAC with parameterized queries

### Data Access Patterns
- Repository pattern for all database operations
- Centralized connection through `TDataModule1` (ConexaoBanco.pas)
- Parameterized SQL queries for security
- Soft delete implementation (ativo flag)
- Grid-based inline editing with direct database updates

### Key Components

1. **Main Navigation**:
   - `FMain`: Card-based interface using TCardPanel with 6 main sections
   - Navigation panels with hover effects and image switching
   - Tabbed interface within each card using TPageControl

2. **Business Entities**:
   - **Contacts**: Full CRUD with favorites system and company relationships
   - **Users**: Authentication with MD5 password hashing
   - **Companies**: CNPJ validation and management
   - **Messages**: Internal messaging system
   - **Configuration**: Application settings management

3. **UI Features**:
   - Grid-based data display with TDBGrid components
   - Inline editing capabilities with immediate database updates
   - Responsive design with dynamic resizing
   - Mouse hover effects on navigation panels
   - Contact favorites system with toggle functionality

### Project Structure
```
/ProjetoFinalDelphi/
├── Controller/           # Business logic controllers
│   ├── ContatosController.pas
│   ├── EmpresaController.pas
│   ├── CadastroUsuarioController.pas
│   └── ...
├── Model/               # Entity/model classes
│   ├── TContatosModel.pas
│   ├── TUsuarioModel.pas
│   ├── EmpresaModel.pas
│   ├── FavoritosModel.pas
│   └── ...
├── Repository/          # Data access layer
│   ├── ContatosRepository.pas
│   ├── ConexaoBanco.pas
│   ├── TUsuarioRepository.pas
│   └── ...
├── View/               # VCL forms and UI components
│   ├── uMain.pas
│   ├── uLogin.pas
│   ├── uCadastroUsuariosView.pas
│   └── ...
├── Pictures/           # Application images and icons
├── lib/               # External libraries (libpq.dll)
├── Project2.dpr        # Main program entry point
├── Project2.dproj      # Delphi project configuration
└── README.md           # Project documentation
```

## Development Guidelines

### Adding New Features
1. Create model class in `Model/` with proper getter/setter methods
2. Implement repository class in `Repository/` using TFDQuery with parameterized queries
3. Create controller in `Controller/` to orchestrate business logic
4. Add UI components to appropriate view form in `View/`
5. Follow naming convention: `[Entity]Model`, `[Entity]Repository`, `[Entity]Controller`

### Database Operations
- Always use parameterized queries through TFDQuery
- Repository classes should handle all SQL operations
- Implement soft delete pattern where applicable
- Use transactions for multi-table operations
- Handle connection state through DataModule1.FDConnection1

### UI Development
- Use TCardPanel for main navigation sections
- Implement TPageControl for tabbed interfaces within cards
- Add mouse hover effects for navigation panels
- Use TDBGrid with TDataSource for data display
- Enable inline editing with immediate database updates

## Key Features
- User authentication and registration with MD5 password hashing
- Contact management with full CRUD operations and inline grid editing
- Company management with CNPJ validation
- Favorites system for contacts with toggle functionality
- Grid-based data display with immediate database updates
- Card-based UI navigation system with 6 main sections
- Responsive design with dynamic resizing and hover effects
- Soft delete implementation for data preservation