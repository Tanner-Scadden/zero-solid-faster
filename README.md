# Zero Tanstack Faster

A modern e-commerce application built with a powerful tech stack for real-time, type-safe data synchronization.

## Tech Stack

- **Frontend**:
  - [SolidJS](https://www.solidjs.com/) - A declarative, efficient, and flexible JavaScript library for building user interfaces
  - [TanStack Router](https://tanstack.com/router/latest) - Type-safe routing for modern web applications
  - [Tailwind CSS](https://tailwindcss.com/) - A utility-first CSS framework

- **Backend**:
  - [Zero](https://www.rocicorp.dev/zero) - Real-time sync and state management with automatic conflict resolution
  - [PostgreSQL](https://www.postgresql.org/) - Open source relational database
  - [Docker](https://www.docker.com/) - Containerization for consistent development environments

## Getting Started

### Prerequisites

- Node.js (Latest LTS recommended)
- Docker and Docker Compose
- [Bun](https://bun.sh/) - Fast JavaScript runtime and package manager

### Development Setup

1. Clone the repository:
```bash
git clone git@github.com:your-username/zero-tanstack-faster.git
cd zero-tanstack-faster
```

2. Install dependencies:
```bash
bun install
```

3. Make the development script executable:
```bash
chmod +x scripts/dev.sh
```

4. Initialize the database and seeders (Takes a few minutes)
```bash
bun run dev:init
```

5. Start the development environment:
```bash
bun run dev
```

This will:
- Start PostgreSQL in Docker
- Initialize the database schema and seed data
- Start the Zero cache server
- Launch the development UI server

The application will be available at:
- UI: http://localhost:5173
- Zero Cache Server: http://localhost:4848
