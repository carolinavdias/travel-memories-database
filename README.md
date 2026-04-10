<div align="center">

<h1>🗺️ ᗰᗩᑭᗩ ᗪE ᗰEᗰóᖇIᗩꌗ</h1>
<h3>Relational Database System for Travel Cataloguing</h3>

![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-orange?style=for-the-badge)

*Academic project developed for **Bases de Dados** @ University of Minho*  
*Final grade: **17/20** ⭐*

</div>

---

## 🧳 About

A full relational database system designed for **Sofia**, a passionate traveller who needed a structured way to store, organise and revisit her travel memories across photos, videos and personal notes.

The system was designed and implemented from scratch: from requirements analysis and interviews with the client, through ER modelling, relational schema normalisation and full MySQL implementation with queries, views, indexes, procedures and triggers.

---

## ⚡ Features

- **ER diagram** - entity-relationship model designed from real user requirements
- **Relational schema** - normalised to Third Normal Form (3NF)
- **Relational algebra** - queries validated before SQL implementation
- **MySQL implementation** - full physical model with InnoDB engine and UTF-8 support
- **10 analytical queries** - covering search, filtering, ranking and aggregation
- **6 views** - pre-built perspectives for common access patterns
- **Optimised indexing** - composite indexes aligned with query access patterns
- **Stored procedures** - business logic encapsulated server-side
- **Triggers** - data integrity enforced at database level
- **Role-based access control** - admin, app and readonly roles with least-privilege principle

---

## 🗂️ Data Model

| Entity | Description |
|---|---|
| `UTILIZADOR` | Users with profile, biography and account status |
| `DESTINO` | Travel destinations with geographic coordinates |
| `EXPERIENCIA` | Travel experiences authored by users |
| `MULTIMEDIA` | Photos, videos and audio files linked to experiences |
| `COMENTARIO` | User comments on experiences |
| `AVALIACAO` | Ratings (0–5) per user per experience |

---

## 📁 File Structure

```
travel-memories-database/
├── sql/
│   ├── schema.sql              # Database creation and table definitions
│   ├── queries.sql             # Analytical queries (RM01–RM10)
│   ├── views_indexes.sql       # Views and performance indexes
│   ├── procedures_triggers.sql # Stored procedures, functions and triggers
│   └── users_permissions.sql   # Roles and access control
├── docs/
│   └── relatorio.pdf           # Full project report
└── README.md
```

---

## 🚀 How to Run

```bash
# Create the database and tables
mysql -u root -p < sql/schema.sql

# Load views and indexes
mysql -u root -p < sql/views_indexes.sql

# Load procedures, functions and triggers
mysql -u root -p < sql/procedures_triggers.sql

# Set up users and permissions
mysql -u root -p < sql/users_permissions.sql

# Run analytical queries
mysql -u root -p MapaDeMemorias < sql/queries.sql
```

---

## 🛠️ Tech Stack

`MySQL` · `SQL` · `ER Modelling` · `Relational Algebra` · `3NF Normalisation` · `Stored Procedures` · `Triggers` · `Role-Based Access Control`

---

## 👩‍💻 Authors

**Carolina Dias** - [@carolinavdias](https://github.com/carolinavdias)  
**António Barroso**  
**Gabriel Carvalho**  
**Gustavo Silva**
