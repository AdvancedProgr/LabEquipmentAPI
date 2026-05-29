# Lab Equipment API

A Rails API application for tracking lab equipment, their statuses, and maintenance history. Built as part of a Week 4 project to replace chaotic whiteboard-and-WhatsApp lab management with a structured system.

## Project Description

This API manages three core models — **Categories**, **Equipment**, and **MaintenanceRecords** — with full CRUD, filtering, business rule validation, and edge case handling.

## Task Assignment

| Task | Description | Assignee | Status |
|------|-------------|----------|--------|
| 1 | Create the Project and Data Model | Nahum | Done |
| 2 | Seed Data | Tesfaye | Done |
| 3 | Category CRUD | Alazar | Done |
| 4 | Equipment CRUD with Filtering | Nahum | Done |
| 5 | MaintenanceRecord CRUD with Filtering | Tesfaye | Done |
| 6 | Business Rules | Nahum | Done |
| 7 | Edge Cases | Alazar | Done |

## Setup Instructions

### Prerequisites

- Ruby 3.x
- Rails 8.x
- SQLite3

### Installation

```bash
git clone <repository-url>
cd LabEquipmentAPI
bundle install
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed
bin/rails server
```

The API will be available at `http://localhost:3000`.

### Running Tests

```bash
bin/rails test
```

## Data Model

### Category

| Column | Type | Constraints |
|--------|------|-------------|
| name | string | Required, unique, min 3 characters |

### Equipment

| Column | Type | Constraints |
|--------|------|-------------|
| name | string | Required, min 3 chars, must contain a letter |
| serial_number | string | Required, unique, format `XXX-NNN` |
| status | string | Required, one of: `available`, `in_use`, `maintenance` (default: `available`) |
| category_id | reference | Foreign key to categories |

### MaintenanceRecord

| Column | Type | Constraints |
|--------|------|-------------|
| description | text | Required |
| performed_at | datetime | Required, cannot be in the future |
| equipment_id | reference | Foreign key to equipment |

### Associations

- Category `has_many` equipment (`dependent: :restrict_with_error`)
- Equipment `belongs_to` category, `has_many` maintenance_records (`dependent: :destroy`)
- MaintenanceRecord `belongs_to` equipment

## API Endpoints

### Categories

| Method | Path | Description |
|--------|------|-------------|
| GET | `/categories` | List all, ordered by name |
| GET | `/categories/:id` | Show one with equipment count |
| POST | `/categories` | Create |
| PATCH | `/categories/:id` | Update |
| DELETE | `/categories/:id` | Delete (409 if equipment exists) |

### Equipment

| Method | Path | Description |
|--------|------|-------------|
| GET | `/equipment` | List all, supports `?status=` filter, includes category name |
| GET | `/equipment/:id` | Show one with category and maintenance records |
| POST | `/equipment` | Create |
| PATCH | `/equipment/:id` | Update |
| DELETE | `/equipment/:id` | Delete (cascades maintenance records) |

### MaintenanceRecords

| Method | Path | Description |
|--------|------|-------------|
| GET | `/maintenance_records` | List all, supports `?equipment_id=` filter, ordered by `performed_at` desc |
| GET | `/maintenance_records/:id` | Show one with equipment name |
| POST | `/maintenance_records` | Create |
| PATCH | `/maintenance_records/:id` | Update |
| DELETE | `/maintenance_records/:id` | Delete |

### Status Codes

| Situation | Status |
|-----------|--------|
| Record created | 201 |
| Record read or updated | 200 |
| Record deleted | 204 |
| Record not found | 404 |
| Validation failed | 422 |
| Cannot delete category with equipment | 409 |

## Seed Data

The `db/seeds.rb` file creates:
- 4 categories: Computing, Optics, Networking, Electronics
- 8 equipment items across all categories with mixed statuses
- 5 maintenance records across 3 different equipment items

## Business Rules

1. **Serial number format**: Must match `XXX-NNN` (e.g., `LAP-001`)
2. **Maintenance date**: Cannot be in the future
3. **Category name**: Minimum 3 characters
4. **Equipment name**: Minimum 3 characters and must contain at least one letter

## Curl Examples

See `curl_commands.txt` for the full collection of curl commands and responses for all endpoints, business rules, and edge cases.
