# Library Management App

A full-stack Library Management application with **Flutter** frontend and **Django** backend.

## Features

- **Book Management**: Add, view, and track books with author information
- **Member Management**: Manage library members and their information
- **Transaction System**: Borrow and return books with automated due date tracking
- **Fine Calculation**: Automatic fine calculation for overdue books ($1 per day)
- **Real-time Updates**: Track available book copies in real-time
- **REST API**: Complete RESTful API for all operations

## Technology Stack

### Backend (Django)
- Django 4.2.0
- Django REST Framework 3.14.0
- Django CORS Headers 4.0.0
- SQLite Database

### Frontend (Flutter)
- Flutter SDK (3.0+)
- HTTP package for API calls
- Material Design 3
- Provider for state management

## Project Structure

```
Library-Management-App/
├── backend/                    # Django Backend
│   ├── library/               # Main app
│   │   ├── models.py         # Database models
│   │   ├── serializers.py    # REST API serializers
│   │   ├── views.py          # API views
│   │   ├── urls.py           # API endpoints
│   │   └── admin.py          # Admin configuration
│   ├── library_backend/      # Project settings
│   │   ├── settings.py       # Django settings
│   │   └── urls.py           # URL configuration
│   ├── manage.py             # Django management script
│   └── requirements.txt      # Python dependencies
│
└── frontend/                  # Flutter Frontend
    ├── lib/
    │   ├── models/           # Data models
    │   ├── services/         # API service
    │   ├── screens/          # UI screens
    │   └── main.dart         # App entry point
    └── pubspec.yaml          # Flutter dependencies
```

## Setup Instructions

### Backend Setup

1. Navigate to the backend directory:
   ```bash
   cd backend
   ```

2. Create and activate a virtual environment:
   ```bash
   python3 -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

3. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

4. Run migrations:
   ```bash
   python manage.py makemigrations
   python manage.py migrate
   ```

5. Create a superuser (for admin access):
   ```bash
   python manage.py createsuperuser
   ```

6. Start the development server:
   ```bash
   python manage.py runserver
   ```

The backend API will be available at `http://127.0.0.1:8000/`

### Frontend Setup

1. Navigate to the frontend directory:
   ```bash
   cd frontend
   ```

2. Install Flutter dependencies:
   ```bash
   flutter pub get
   ```

3. Run the Flutter app:
   ```bash
   flutter run
   ```

Or run on a specific platform:
```bash
flutter run -d chrome        # For web
flutter run -d windows       # For Windows
flutter run -d macos         # For macOS
flutter run -d linux         # For Linux
```

## API Endpoints

### Books
- `GET /api/books/` - List all books
- `POST /api/books/` - Create a new book
- `GET /api/books/{id}/` - Get book details
- `PUT /api/books/{id}/` - Update book
- `DELETE /api/books/{id}/` - Delete book
- `GET /api/books/available/` - Get available books

### Authors
- `GET /api/authors/` - List all authors
- `POST /api/authors/` - Create a new author
- `GET /api/authors/{id}/` - Get author details
- `PUT /api/authors/{id}/` - Update author
- `DELETE /api/authors/{id}/` - Delete author

### Members
- `GET /api/members/` - List all members
- `POST /api/members/` - Create a new member
- `GET /api/members/{id}/` - Get member details
- `PUT /api/members/{id}/` - Update member
- `DELETE /api/members/{id}/` - Delete member
- `GET /api/members/active/` - Get active members

### Transactions
- `GET /api/transactions/` - List all transactions
- `POST /api/transactions/` - Create a new transaction (borrow book)
- `GET /api/transactions/{id}/` - Get transaction details
- `GET /api/transactions/active/` - Get active transactions
- `POST /api/transactions/{id}/return_book/` - Return a book

## Database Models

### Author
- Name
- Bio
- Created date

### Book
- Title
- Author (Foreign Key)
- ISBN (Unique)
- Published date
- Total copies
- Available copies
- Description

### Member
- Name
- Email (Unique)
- Phone
- Address
- Membership date
- Active status

### Transaction
- Book (Foreign Key)
- Member (Foreign Key)
- Borrow date
- Due date (14 days from borrow)
- Return date
- Status (borrowed/returned/overdue)
- Fine amount

## Usage

1. **Start the Backend**: Run the Django server first
2. **Access Admin Panel**: Go to `http://127.0.0.1:8000/admin/` to add initial data (authors, books, members)
3. **Run Flutter App**: Start the Flutter application
4. **Manage Library**: Use the app to view books, members, and handle transactions

## Development Notes

- The backend runs on port 8000 by default
- CORS is enabled for development (should be restricted in production)
- The app uses SQLite for simplicity (can be changed to PostgreSQL/MySQL in production)
- Fine calculation: $1 per day for overdue books
- Default borrowing period: 14 days

## Future Enhancements

- User authentication and authorization
- Book search and filtering
- Member borrowing history
- Email notifications for due dates
- Barcode scanning for books
- Advanced reporting and analytics
- Book reservations
- Multi-language support

## License

This project is licensed under the MIT License - see the LICENSE file for details.
